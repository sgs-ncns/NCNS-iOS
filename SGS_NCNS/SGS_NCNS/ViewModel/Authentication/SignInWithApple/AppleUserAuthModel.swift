//
//  AppleUserAuthModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/26.
//

import Foundation
import AuthenticationServices
import JWTDecode

final class AppleUserAuthModel: ObservableObject {
    @Published var userSocialLogin = SocialSignInModel(authType: "APPLE", email: "")
    
    init() {
        
    }
    
    func checkUserInfo(result: (ASAuthorization)) {
        guard let credentials = result.credential as? ASAuthorizationAppleIDCredential, let identityToken = credentials.identityToken, let identityTokenString = String(data: identityToken, encoding: .utf8) else { return }

        let emailAddress = try! decode(jwt: identityTokenString).body["email"]!
        
        self.userSocialLogin.email = emailAddress as? String ?? ""
        print("AuthType: \(userSocialLogin.authType), user EmailAddress: \(userSocialLogin.email)")
    }
}
