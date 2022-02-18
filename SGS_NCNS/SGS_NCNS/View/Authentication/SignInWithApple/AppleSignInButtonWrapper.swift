//
//  AppleSignInButtonWrapper.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/26.
//

import SwiftUI
import AuthenticationServices

/*
 애플 OAuth 로그인을 담당하는 뷰입니다.
 애플 로그인 후 로그인한 Email을 받아서 회원가입되어있는 유저, 안되어있는 유저를 구별합니다.
 회원가입이 되어있지 않은 유저는 회원가입 뷰로 이동합니다.
 */

struct AppleSignInButtonWrapper: View {
    
    @EnvironmentObject var appleUserAuthModel: AppleUserAuthModel
    @EnvironmentObject var loginCheckModel: LoginCheckModel
    
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
                    loginCheckModel.isLoggedIn = true
                }
            }
    }
}

struct AppleSignInButtonWrapper_Previews: PreviewProvider {
    static var previews: some View {
        AppleSignInButtonWrapper()
    }
}
