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

final class AppleUserAuthModel: ObservableObject {
    @Published var userSocialLogin = SocialSignInModel(authType: "APPLE", email: "")
    @Published var isLoginSuccess: Bool = false
    
    private var bag = Set<AnyCancellable>()
    
    init() {
        
    }
    
    func checkAppleLoginResult(result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authResults):
            print("Authorization successful")
            self.checkUserInfo(result: authResults)
        case .failure(let error):
            print("Authorization failed: " + error.localizedDescription)
        }
    }
    
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
