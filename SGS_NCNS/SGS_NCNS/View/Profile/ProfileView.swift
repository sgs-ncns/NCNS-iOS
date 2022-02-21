//
//  ProfileView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/06.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    @EnvironmentObject var isCurrentUser: MySettings
    @EnvironmentObject var loginCheckModel: LoginCheckModel
    @StateObject var profileViewModel = ProfileViewModel()
    @State private var isFirstLoad = true
    @State var showActionSheet = false
    let kc = KeyChainUtils()
    var body: some View {
        NavigationView {
                ProfileSubView(clickedUserName: kc.read("login", account: "accountName") ?? "")
                    .navigationTitle(kc.read("login", account: "accountName") ?? "")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                self.profileViewModel.requestReissueToken()
                            }, label: {
                                Text("TR")
                            })
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                self.showActionSheet = true
                            }, label: {
                                Text("LogOut")
                            })
                                .actionSheet(isPresented: $showActionSheet, content:
                                                getActionSheet)
                        }
                    }
                    .padding(0.0)
                    .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    func getActionSheet() -> ActionSheet {
        let title = Text("정말 로그아웃하실건가요?")
        let kc = KeyChainUtils()
        let logoutButton: ActionSheet.Button = .destructive(Text("Logout"), action: {
            // KeyChain에 저장된 유저 정보 삭제
            Messaging.messaging().unsubscribe(fromTopic: kc.read("login", account: "accountName")!)
            
            kc.delete("login", account: "accessToken")
            kc.delete("login", account: "refreshToken")
            kc.delete("login", account: "userId")
            kc.delete("login", account: "accountName")
            
            
            self.loginCheckModel.isLoggedIn.toggle()
        })
        let cancleButton: ActionSheet.Button = .cancel()
        
        return ActionSheet(title: title, message: nil, buttons: [logoutButton, cancleButton])
    }
}




//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
////            .environmentObject(isCurrentUser)
//    }
//}
