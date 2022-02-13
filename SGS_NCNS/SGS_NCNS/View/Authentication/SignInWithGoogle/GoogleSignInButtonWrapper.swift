//
//  GoogleSignInButtonWrapper.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/26.
//

/*
 구글 OAuth 로그인을 담당하는 뷰입니다.
 SwiftUI용 OAtuh를 지원하지 않아 UIKit 뷰를 보여주는 UIViewRepresentable을 사용합니다.
 이벤트는 handler로 GoogleUserAuthModel로 처리합니다.
 */


import SwiftUI
import GoogleSignIn

struct GoogleSignInButtonWrapper: UIViewRepresentable {
    let handler: () -> Void
    
    init(handler: @escaping () -> Void) {
        self.handler = handler
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    // 버튼 layout 정하기
    func makeUIView(context: Context) -> GIDSignInButton {
        let signInButton = GIDSignInButton()
        signInButton.colorScheme = .light
        signInButton.style = .wide
        signInButton.addTarget(context.coordinator,
                               action: #selector(Coordinator.callHandler),
                               for: .touchUpInside)
        return signInButton
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        context.coordinator.handler = handler
    }
}

extension GoogleSignInButtonWrapper {
    class Coordinator {
        var handler: (() -> Void)?
        
        @objc func callHandler() {
            handler?()
        }
    }
}
