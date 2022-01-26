//
//  GoogleSignInButtonWrapper.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/26.
//

import SwiftUI
import GoogleSignIn

/// A wrapper for `GIDSignInButton` so that it can be used in SwiftUI.
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
