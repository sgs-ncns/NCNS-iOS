//
//  SGS_NCNSApp.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2021/12/28.
//

import SwiftUI

// 앱 전반에서 사용하는 변수 여기서 관리
class MySettings: ObservableObject {
    // 프로필 = 무조건 true, 유저검색 -> 자신 : true, 다른사람: false
    struct UserCheck {
        var isMe: Bool
    }
    @Published var checkUser: UserCheck = UserCheck(isMe: false)
}

@main
struct SGS_NCNSApp: App {
    // 로그인 화면에서 로그인 성공 시 이동
    @StateObject var googleUserAuthModel: GoogleUserAuthModel = GoogleUserAuthModel()
    @StateObject var appleUserAuthModel: AppleUserAuthModel = AppleUserAuthModel()
    @StateObject var loginCheckModel: LoginCheckModel = LoginCheckModel()
    init() {
        
    }
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ZStack {
                if !loginCheckModel.isLoggedIn {
                    LoginView()
                        .environmentObject(googleUserAuthModel)
                        .environmentObject(appleUserAuthModel)
                        .environmentObject(loginCheckModel)
                } else {
                    ContentView()
                        .environmentObject(loginCheckModel)
                        .environmentObject(MySettings())
                }
            }.animation(loginCheckModel.isLoggedIn ? .easeOut : nil)
        }
    }
}
