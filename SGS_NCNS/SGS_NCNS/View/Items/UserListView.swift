//
//  UserListView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/14.
//

import SwiftUI

struct UserListView: View {
    @EnvironmentObject var isCurrentUser: MySettings
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0 ..< 20) { _ in
                    NavigationLink(
                        destination: ProfileSubView()
                            .onAppear(perform: {
                                isCurrentUser.checkUser.isMe = false
                            }),
                        label: {
                        UserCell()
                            .padding(.leading)
                    })
                }
            }
        }
        
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
