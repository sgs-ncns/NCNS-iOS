//
//  MainTabView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/06.
//

import SwiftUI

/*
 로그인 성공 시 보여주는 TabView입니다.
 하단에 있는 TabItem을 누르면 그 item에 맞는 뷰를 보여줍니다.
 */

struct MainTabView: View {
    @EnvironmentObject var isCurrentUser: MySettings
    @State private var isHidden: Bool = false
    
    init() {
        UITabBar.changeAppearance(clear: false)
    }
    
    var body: some View {
        TabView {
            FeedView()
                .tabItem {
                    Image("Home")
                        .renderingMode(.template)
                }
            
            SearchView(searchViewModel: SearchViewModel())
            .tabItem {
                Image("Search")
                    .renderingMode(.template)
            }
            
            UploadPostView(uploadPostViewModel: UploadPostViewModel(), imagePageViewModel: ImagePageViewModel())
                .tabItem {
                    Image("Add")
                        .renderingMode(.template)
                }
            
            NotificationsView()
                .tabItem {
                    Image("Heart")
                        .renderingMode(.template)
                }
            
            ProfileView()
                .tabItem {
                    Image("Profile")
                        .renderingMode(.template)
                }
                .onAppear(perform: {
                    self.isCurrentUser.checkUser.isMe = true
                })
        }
        .foregroundColor(Color.black)
        .accentColor(.black)
        .animation(nil)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainTabView()
                .previewInterfaceOrientation(.portrait)
        }
    }
}
