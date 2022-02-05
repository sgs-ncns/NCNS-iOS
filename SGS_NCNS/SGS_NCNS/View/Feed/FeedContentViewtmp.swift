//
//  FeedContentView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/10.
//

import SwiftUI

struct FeedContentViewtmp: View {
    @Binding var viewMore: Bool
    var body: some View {
        if !viewMore {
            // 더 보기 누르기 전 뷰
            HStack {
                { Text("User")
                        .font(.system(size: 13, weight: .semibold)) + Text(" ") +
                    Text("안녕 #인스타 #NCNS @사람 나는 상혁 너는 야무야우먀우먀우야우야우야 @종현 #야무띠 호잇 가 나다라 마바사아자차자야 아먀가아우가 가나달라아럼냥런미아런 ㅇ럼ㄴㅇ러;ㅣㅁㄴ어")
                }()
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 13))
                Text("더 보기")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
        } else {
            // 더 보기 눌렀을 때 뷰
            { Text("User")
                    .font(.system(size: 13, weight: .semibold)) + Text(" ") +
                Text("SmileGate Stove Dev Camp. 스마일게이트 스토브 화이팅!!! SmileGate Stove Dev Camp. 스마일게이트 스토브 화이팅!!!")
            }()
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .font(.system(size: 13))
        }
    }
}

struct FeedContentViewtmp_Previews: PreviewProvider {
    static var previews: some View {
        FeedContentView(viewMore: .constant(false))
    }
}
