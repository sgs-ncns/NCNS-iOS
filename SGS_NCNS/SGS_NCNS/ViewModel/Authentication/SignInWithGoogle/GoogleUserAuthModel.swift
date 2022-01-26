//
//  UserAuthModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/26.
//

import SwiftUI
import GoogleSignIn
import JWTDecode

final class GoogleUserAuthModel: ObservableObject {
    
    // Published 할 변수들 설정
    @Published var userSocialLogin = SocialSignInModel(authType: "GOOGLE", email: "")
    @Published var errorMessage: String = ""
    @Published var isLoggedIn = false
    
    init() {
        check()
    }
    
    /// 유저 토큰을 체크할 수 있는 함수
    func checkStatus() {
        if (GIDSignIn.sharedInstance.currentUser != nil) {
            // 현재 유저에 대한 정보를 담기
            let user = GIDSignIn.sharedInstance.currentUser
            guard let user = user else { return }
            let idToken = user.authentication.idToken
            //
            let emailAddress = try! decode(jwt: idToken!).body["email"]
            self.userSocialLogin.email = emailAddress as? String ?? ""
            print("AuthType: \(userSocialLogin.authType), user EmailAddress: \(userSocialLogin.email)")
            self.isLoggedIn = true
            self.signOut()
        } else {
            self.isLoggedIn = false
            self.userSocialLogin.email = ""
        }
    }
    
    /// 전에 로그인했는지 확인
    func check() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let error = error {
                self.errorMessage = "error: \(error.localizedDescription)"
            }
            
            self.checkStatus()
        }
    }
    
    ///
    func signIn() {
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}

         let signInConfig = GIDConfiguration.init(clientID: "1057902567521-8bi707mtii0ehag5u4hvs032dl1hk710.apps.googleusercontent.com")
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
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        print("무사히 로그아웃 완료")
        self.checkStatus()
    }
}
