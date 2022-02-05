//
//  TagListView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/05.
//

import SwiftUI

struct TagListView: View {
    @EnvironmentObject var isCurrentUser: MySettings
    var body: some View {
        LazyVStack {
            ForEach(0 ..< 6) { _ in
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

struct TagListView_Previews: PreviewProvider {
    static var previews: some View {
        TagListView()
    }
}
