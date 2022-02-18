//
//  KkanbuCheckView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/18.
//

import SwiftUI

struct KkanbuCheckView: View {
    var kkanbuCheckModels: [KkanbuCheckModel]
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if kkanbuCheckModels.count != 0 {
                    ForEach(0 ..< kkanbuCheckModels.count, id: \.self) { i in
                        NavigationLink(
                            destination: ProfileSubView(clickedUserName: kkanbuCheckModels[i].accountName),
                            label: {
                                UserCell(accountName: kkanbuCheckModels[i].accountName , nickname: kkanbuCheckModels[i].nickname)
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
