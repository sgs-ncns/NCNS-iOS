//
//  MainTabView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/06.
//

import SwiftUI

struct MainTabView: View {
    @State private var isHidden: Bool = false
//    @State private var selection = 0
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
        }
        .foregroundColor(Color.black)
        .accentColor(.black)
//        .onAppear(perform: {
//            if #available(iOS 15, *) {
//                UINavigationBar.changeAppearance(clear: false)
//                UITabBar.changeAppearance(clear: false)
//            }
//        })
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
