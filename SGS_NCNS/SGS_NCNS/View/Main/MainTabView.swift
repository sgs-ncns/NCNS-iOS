//
//  MainTabView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/06.
//

import SwiftUI

struct MainTabView: View {
    @State private var isHidden: Bool = false
    var body: some View {
        NavigationView {
            TabView {
                FeedView()
                    .onAppear { self.isHidden = false }
                    .tabItem {
                        Image("Home")
                            .renderingMode(.template)
                    }
                
                SearchView()
                    .onAppear { self.isHidden = true }
                    .tabItem {
                        Image("Search")
                            .renderingMode(.template)
                    }
                
                UploadPostView()
                    .onAppear { self.isHidden = true }
                    .tabItem {
                        Image("Add")
                            .renderingMode(.template)
                    }
                
                NotificationsView()
                    .onAppear { self.isHidden = true }
                    .tabItem {
                        Image("Heart")
                            .renderingMode(.template)
                    }
                
                ProfileView()
                    .onAppear { self.isHidden = true }
                    .tabItem {
                        Image("Profile")
                            .renderingMode(.template)
                    }
            }
            .padding(0.0)
            .navigationBarItems(leading:
                Image("IGlogo")
            )
            .foregroundColor(Color.black)
            .navigationBarTitleDisplayMode(.inline)
            .accentColor(.black)
            .onAppear(perform: {
                if #available(iOS 15, *) {
                    UINavigationBar.changeAppearance(clear: false)
                    UITabBar.changeAppearance(clear: false)
                }
            })
            .navigationBarHidden(isHidden)
        }
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
