//
//  FeedContentViewModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/02.
//

import SwiftUI

class FeedContentViewModel: ObservableObject {
    @Published var feedContent: [FeedContent<Text>] = []
    @EnvironmentObject var isCurrentUser: MySettings
    private var splitText: [String]
    
    /// 전체 String 받아와서 split 진행
    init(_ text: String, user: String) {
        self.splitText = text.split(separator: " ", omittingEmptySubsequences: false).map { "\($0) " }
        /// 유저이름에도 프로필로 이동하는 이벤트를 달기 위해 합침
        self.splitText.insert("\(user) ", at: 0)
        
        if text.hasPrefix(" ") {
            self.splitText = [" "] + self.splitText
        }
        
        splitText.enumerated().forEach {
            if $0 == 0 {
                let user = $1
                feedContent.append(.user(NavigationLink(destination: ProfileSubView(), label: { Text("\(user)")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.black)
                })))
            } else if $1.hasPrefix("#") {
                let hashtag = $1
                let dropPrefix = $1.deletingPrefix("#")
                feedContent.append(.hashtag(NavigationLink(destination: HashTagView(hashtagString: dropPrefix), label: { Text("\(hashtag)")
                        .font(.system(size: 13))
                        .foregroundColor(.blue)
                })))
            } else if $1.hasPrefix("@") {
                let humantag = $1
                let dropPrefix = $1.deletingPrefix("@")
                feedContent.append(.humantag(NavigationLink(destination: ProfileSubView(), label: { Text("\(humantag)")
                        .font(.system(size: 13))
                        .foregroundColor(.blue)
                })))
            } else {
                let content = $1
                feedContent.append(.content(NavigationLink(destination: CommentView(), label: { Text("\(content)")
                        .font(.system(size: 13))
                        .foregroundColor(.black)
                })))
            }
        }
    }
}

