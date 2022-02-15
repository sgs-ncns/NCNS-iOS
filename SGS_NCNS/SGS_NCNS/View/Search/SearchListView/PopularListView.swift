//
//  PopularListView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/05.
//

import SwiftUI

/*
 검색창을 눌렀을 때 나오는 인기 ListView입니다.
 */

struct PopularListView: View {
    @EnvironmentObject var isCurrentUser: MySettings
    var body: some View {
        LazyVStack {
            ForEach(0 ..< 2) { _ in
                NavigationLink(
                    destination: ProfileSubView()
                        .onAppear(perform: {
                            isCurrentUser.checkUser.isMe = false
                        }),
                    label: {
                    UserCell()
                        .padding(.leading)
                    })
                NavigationLink(
                    destination: HashTagView(hashtagString: "hi")
                        .onAppear(perform: {
                            isCurrentUser.checkUser.isMe = false
                        }),
                    label: {
                    HashtagCell()
                        .padding(.leading)
                    })
            }
        }
    }
}

struct PopularListView_Previews: PreviewProvider {
    static var previews: some View {
        PopularListView()
    }
}
