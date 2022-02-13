//
//  UserAuthModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/26.
//

import SwiftUI
import Combine
import GoogleSignIn
import JWTDecode

// Google OAtuh 로그인을 위한 ViewModel

final class GoogleUserAuthModel: ObservableObject {
    // Published 할 변수들 설정
    @Published var userSocialLogin = SocialSignInModel(authType: "GOOGLE", email: "")
    @Published var errorMessage: String = ""
    @Published var isLoginSuccess = false
    
    private var bag = Set<AnyCancellable>()
    
    init() {
        check()
    }
    
    // 유저 정보를 확인하는 함수
    func checkStatus() {
        if (GIDSignIn.sharedInstance.currentUser != nil) {
            // 현재 유저에 대한 정보를 user 변수에 담는다.
            let user = GIDSignIn.sharedInstance.currentUser
            guard let user = user else { return }
            
            // 유저의 정보 중 idToken값을 받아와서 접속한 유저의 email을 jwt에서 디코딩 후 서버에 보낼 준비
            let idToken = user.authentication.idToken
            let emailAddress = try! decode(jwt: idToken!).body["email"]
            
            //서버에게 로그인한 authType과 유저 email 정보를 전달
            self.userSocialLogin.email = emailAddress as? String ?? ""
            requesetSocialLogin(data: userSocialLogin)
        } else {
            self.userSocialLogin.email = ""
        }
    }
    
    // 로그인이 되어있는지 확인 - 로그아웃이 되었는지 확인
    func check() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let error = error {
                self.errorMessage = "error: \(error.localizedDescription)"
            }
            
            self.checkStatus()
        }
    }
    
    // Google OAuth 로그인을 통해 유저의 토큰 받아오는 함수
    func signIn() {
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}

        let signInConfig = GIDConfiguration.init(clientID: Const.GoogleOAuth.CLIENT_ID)
         GIDSignIn.sharedInstance.signIn(
             with: signInConfig,
             presenting: presentingViewController,
             callback: { user, error in
                 if let error = error {
                     self.errorMessage = "error: \(error.localizedDescription)"
                 }
                 self.checkStatus()
             }
         )
    }
    
    // OAuth 로그인 후 계정을 로그아웃 - 유저정보를 계속 저장하면 안되기 때문에!
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        print("무사히 로그아웃 완료")
        self.checkStatus()
    }
}

extension GoogleUserAuthModel {
    func requesetSocialLogin(data: SocialSignInModel) {
        APIRequest.shared.requestSocialLogin(data: data)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] in
                if let response = try? $0.map(ResponseModel<[String:String]>.self) {
                    if response.responseCode == "200" {
                        print("성공!! : \(response)")
                        self?.isLoginSuccess = true
                        self?.signOut()
                    }
                } else {
                    print("실패...")
                }
            })
            .store(in: &bag)
    }
}
