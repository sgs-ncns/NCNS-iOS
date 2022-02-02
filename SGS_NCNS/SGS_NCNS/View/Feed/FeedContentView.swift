//
//  FeedContentView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/10.
//

import SwiftUI

struct FeedContentView: View {
    @Binding var viewMore: Bool
    var body: some View {
        if !viewMore {
            // 더 보기 누르기 전 뷰
            HStack {
                { Text("User")
                    .font(.system(size: 13, weight: .semibold)) + Text(" ") +
                Text("SmileGate Stove Dev Camp. 스마일게이트 스토브 화이팅!!! SmileGate Stove Dev Camp. 스마일게이트 스토브 화이팅!!!")
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

struct FeedContentView_Previews: PreviewProvider {
    static var previews: some View {
        FeedContentView(viewMore: .constant(true))
    }
}
