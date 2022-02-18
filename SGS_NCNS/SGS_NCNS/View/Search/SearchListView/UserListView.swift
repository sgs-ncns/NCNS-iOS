//
//  UserListView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/14.
//

import SwiftUI

/*
 검색창을 눌렀을 때 나오는 유저 ListView입니다.
 */

struct UserListView: View {
    @EnvironmentObject var isCurrentUser: MySettings
    var body: some View {
        LazyVStack {
            ForEach(0 ..< 4) { _ in
                NavigationLink(
                    destination: ProfileSubView(clickedUserName: "User"),
                    label: {
                    UserCell()
                        .padding(.leading)
                })
            }
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
