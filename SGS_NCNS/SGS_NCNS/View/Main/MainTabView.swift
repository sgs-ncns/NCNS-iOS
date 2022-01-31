//
//  MainTabView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/06.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var isCurrentUser: MySettings
    @State private var isHidden: Bool = false
    
    var body: some View {
        TabView {
            FeedView()
                .tabItem {
                    Image("Home")
                        .renderingMode(.template)
                }
            
            SearchView()
            .tabItem {
                Image("Search")
                    .renderingMode(.template)
            }
            
            UploadPostView()
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
