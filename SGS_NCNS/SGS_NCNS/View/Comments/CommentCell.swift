//
//  CommentCell.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/31.
//

import SwiftUI

struct CommentCell: View {
    @State private var height: CGFloat = 0
    var body: some View {
        HStack(alignment: .top) {
            Image("Exprofile_aim")
                .resizable()
                .frame(width: 32, height: 32)
                .clipShape(Circle())
                .padding(.leading, 10)
            VStack(alignment: .leading, spacing: 0) {
//                { Text("User")
//                        .font(.system(size: 13, weight: .semibold)) + Text(" ") +
//                Text("SmileGate Stove Dev Camp. 스마일게이트 스토브 화이팅!!! SmileGate Stove Dev Camp. 스마일게이트 스토브 화이팅!!!")
//                }()
//                    .lineLimit(nil)
//                    .multilineTextAlignment(.leading)
//                    .font(.system(size: 13))
//
//                Text("22시간 전")
//                    .font(.system(size: 13))
//                    .foregroundColor(.gray)
////                    .padding([.leading, .trailing], 10)
//                    .padding([.top, .bottom], 5)
//            }
                CommentContentFilterView(vm: CommentViewModel("하이하이 가나다 라마바 아자차카타파하 쓰뜨링~ #하이 @나나", user: "starshan9555"), height: $height)
                Text("22시간 전")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
//                    .padding([.leading, .trailing], 10)
                    .padding([.top, .bottom], 5)
            }.padding([.top, .bottom], 5)
                .padding(.trailing, 5)
        }
    }
}

struct CommentCell_Previews: PreviewProvider {
    static var previews: some View {
        CommentCell()
    }
}
