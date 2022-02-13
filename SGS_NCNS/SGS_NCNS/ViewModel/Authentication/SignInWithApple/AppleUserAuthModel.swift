//
//  AppleUserAuthModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/26.
//

import Foundation
import Combine
import AuthenticationServices
import JWTDecode

// Apple OAuth 로그인을 위한 ViewModel

final class AppleUserAuthModel: ObservableObject {
    @Published var userSocialLogin: SocialSignInModel
    @Published var isLoginSuccess: Bool = false
    
    private var bag = Set<AnyCancellable>()
    // Apple계정으로 로그인한다는 정보를 서버에게 주기 위해 authType을 APPLE로 설정하고 초기화
    init() {
        self.userSocialLogin = SocialSignInModel(authType: "APPLE", email: "")
    }
    
    // OAtuh를 통해 Apple계정 로그인 후 결과 return
    func checkAppleLoginResult(result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authResults):
            print("Authorization successful")
            self.checkUserInfo(result: authResults)
        case .failure(let error):
            print("Authorization failed: " + error.localizedDescription)
        }
    }
    
    /*
     - 서버에게 로그인한 authType과 유저 email 정보를 전달
     - 해당 이메일이 회원가입된 이메일인지 확인하고, 회원가입된 회원이면 로그인 후 피드화면으로 가기, 비회원이면 이메일 그대로 회원가입으로 이동(추가예정)
     */
    func checkUserInfo(result: (ASAuthorization)) {
        guard let credentials = result.credential as? ASAuthorizationAppleIDCredential, let identityToken = credentials.identityToken, let identityTokenString = String(data: identityToken, encoding: .utf8) else { return }
        
        let emailAddress = try! decode(jwt: identityTokenString).body["email"]!
        
        self.userSocialLogin.email = emailAddress as? String ?? ""
        print("AuthType: \(userSocialLogin.authType), user EmailAddress: \(userSocialLogin.email)")
        
        requestSocialLogin(data: userSocialLogin)
    }
}

extension AppleUserAuthModel {
    func requestSocialLogin(data: SocialSignInModel) {
        APIRequest.shared.requestSocialLogin(data: data)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] in
                if let response = try? $0.map(ResponseModel<[String:String]>.self) {
                    if response.responseCode == "200" {
                        print("성공!! : \(response)")
                        self?.isLoginSuccess = true
                    }
                } else {
                    print("실패...")
                }
            })
            .store(in: &bag)
    }
}
