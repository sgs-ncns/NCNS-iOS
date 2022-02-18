//
//  TagListView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/05.
//

import SwiftUI

/*
 검색창을 눌렀을 때 나오는 태그 ListView입니다.
 */

struct TagListView: View {
    @EnvironmentObject var isCurrentUser: MySettings
    var body: some View {
        LazyVStack {
            ForEach(0 ..< 6) { _ in
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

struct TagListView_Previews: PreviewProvider {
    static var previews: some View {
        TagListView()
    }
}
