//
//  NotificationView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/06.
//

import SwiftUI

struct NotificationsView: View {
    @StateObject var notificationGetViewModel = NotificationGetViewModel()
    // 임시
    @StateObject var notificationPostViewModel = NotificationPostViewModel()
    @State private var tabs = ["깐부 알림", "일반 알림"]
    @State private var selectedTab = 0
    @State private var preSelection = 0
    @State private var isFirstLoad = true
    @State private var loadingComplete = false
    
    var kcAccountId: String = KeyChainUtils().read("login", account: "accountName")!
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 5) {
                    if notificationGetViewModel.notificationGetModel.count != 0 {
                        ForEach(0 ..< notificationGetViewModel.notificationGetModel.count, id: \.self) { i in
                            UserCell(accountName: "\(notificationGetViewModel.notificationGetModel[i].likedName)님이 \(notificationGetViewModel.notificationGetModel[i].category)를 달았습니다.", nickname: "")
                            .padding([.leading, .trailing], 10)
                        }
                    } else {
                        Text("Please Wait Like which one Press to you!")
                    }
                }
            }
            
            .onReceive(notificationGetViewModel.$isLoading, perform: {
                if !$0 {
                    self.loadingComplete = true
                } else {
                    self.loadingComplete = false
                }
            })
            .navigationTitle("활동")
            .padding(0.0)
            .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(StackNavigationViewStyle())
            .onAppear {
                if isFirstLoad {
                    notificationGetViewModel.requestNotificationGet(accountId: kcAccountId)
                    isFirstLoad = false
                }
                
            }
    }
}

//struct NotificationsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NotificationsView()
//    }
//}
