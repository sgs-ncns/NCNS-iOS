//
//  FeedCell.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/06.
//

import SwiftUI

/*
 피드를 구성하는 피드 셀 입니다.
 */

struct FeedCell: View {
    @State var viewMore = false
    @State var isLiked = false
    @State private var isPresented = false
    var path: String
    
    init(path: String) {
        self.path = path
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            ImagePageView(path: path)
                
            // Like
            HStack {
                Text("3 Like")
                    .font(.system(size: 13, weight: .semibold))
                    .onTapGesture {
                        print("click like")
                    }
            }
            .padding(.leading, 15)
            .padding(.bottom, 5)
            
            FeedContentView(viewMore: $viewMore)
                .padding([.leading, .trailing], 15)
            
            NavigationLink(destination: CommentView(), label: {
                Text("댓글 ~개 모두 보기")
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

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        FeedCell(path: "test1/")
    }
}
