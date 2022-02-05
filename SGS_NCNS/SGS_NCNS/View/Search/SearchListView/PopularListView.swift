//
//  PopularListView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/05.
//

import SwiftUI

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
            }
        }
    }
}

struct PopularListView_Previews: PreviewProvider {
    static var previews: some View {
        PopularListView()
    }
}
