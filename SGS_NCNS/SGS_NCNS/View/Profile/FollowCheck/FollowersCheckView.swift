//
//  FollowersCheckView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/18.
//

import SwiftUI

struct FollowersCheckView: View {
    var followersCheckModels: [FollowersCheckModel]
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if followersCheckModels.count != 0 {
                    ForEach(0 ..< followersCheckModels.count, id: \.self) { i in
                        NavigationLink(
                            destination: ProfileSubView(clickedUserName: followersCheckModels[i].accountName),
                            label: {
                                UserCell(accountName: followersCheckModels[i].accountName , nickname: followersCheckModels[i].nickname)
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


//struct FollowersCheckView_Previews: PreviewProvider {
//    static var previews: some View {
//        FollowersCheckView()
//    }
//}
