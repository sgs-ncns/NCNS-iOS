//
//  FeedDetailView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/16.
//

import SwiftUI

struct FeedDetailCell: View {
    @State var viewMore = false
    @State var isLiked = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // 이미지 + 유저정보 + 좋아요 기타등등
            ImagePageView(userId: 1, accountName: "contea95", path: "test1/")
            
            HStack {
                Text("(Test) Like")
                    .font(.system(size: 13, weight: .semibold))
                    .onTapGesture {
                        print("click like")
                    }
            }
            .padding(.leading, 15)
            .padding(.bottom, 5)
            
            FeedContentView(viewMore: $viewMore, feedContent: "테스트 테스트 @테스트 #테스트", accountName: "contea95")
                .padding([.leading, .trailing], 15)
            
            NavigationLink(destination: CommentView(), label: {
                Text("댓글 (Test) 개 모두 보기")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            })
                .padding([.leading, .trailing], 15)
                .padding([.top, .bottom], 5)
            
            Text("22시간 전")
                .font(.system(size: 13))
                .foregroundColor(.gray)
                .padding([.leading, .trailing], 15)
                .padding([.top, .bottom], 5)
        }
    }
}

struct FeedDetailCell_Previews: PreviewProvider {
    static var previews: some View {
        FeedDetailCell()
    }
}
