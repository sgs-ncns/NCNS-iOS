//
//  MainTabView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/06.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        NavigationView {
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
            .padding(0.0)
            .navigationBarItems(leading:
                Image("IGlogo")
            )
            .foregroundColor(Color.black)
            .navigationBarTitleDisplayMode(.inline)
            .accentColor(.black)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainTabView()
                .previewInterfaceOrientation(.portrait)
            MainTabView()
                .previewInterfaceOrientation(.portrait)
        }
    }
}
