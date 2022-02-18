//
//  FollowingCheckView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/18.
//

import SwiftUI

struct FollowingCheckView: View {
    var followingCheckModels: [FollowingCheckModel]
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if followingCheckModels.count != 0 {
                    ForEach(0 ..< followingCheckModels.count, id: \.self) { i in
                        NavigationLink(
                            destination: ProfileSubView(clickedUserName: followingCheckModels[i].accountName),
                            label: {
                                UserCell(accountName: followingCheckModels[i].accountName , nickname: followingCheckModels[i].nickname)
                                    .padding(.leading)
                            })
                    }
                } else {
                    VStack(alignment: .center) {
                        Text("")
                    }.frame(width: geometry.size.width)
                }
            }
        }
    }
}
