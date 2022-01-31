//
//  AppleSignInButtonWrapper.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/26.
//

import SwiftUI
import AuthenticationServices

struct AppleSignInButtonWrapper: View {
    
    @EnvironmentObject var appleUserAuthModel: AppleUserAuthModel
    @Binding var isLogin: Bool
    
    var body: some View {
        SignInWithAppleButton(
            .signIn,
            onRequest: { request in
                request.requestedScopes = [.fullName, .email]
            },
            onCompletion: { result in
                appleUserAuthModel.checkAppleLoginResult(result: result)
            }
        )
            .onReceive(appleUserAuthModel.$isLoginSuccess) {
                if $0 {
                    isLogin = true
                }
            }
    }
}

struct AppleSignInButtonWrapper_Previews: PreviewProvider {
    static var previews: some View {
        AppleSignInButtonWrapper(isLogin: .constant(false))
    }
}
