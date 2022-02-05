//
//  CommentViewModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/03.
//

import SwiftUI

class CommentViewModel: ObservableObject {
    @Published var feedContent: [Comment<Text>] = []
    @EnvironmentObject var isCurrentUser: MySettings
    private var splitText: [String]
    
    /// 전체 String 받아와서 split 진행
    init(_ text: String, user: String) {
        self.splitText = text.split(separator: " ", omittingEmptySubsequences: false).map { "\($0) " }
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
                feedContent.append(.humantag(NavigationLink(destination: ProfileSubView(), label: { Text("\(humantag)")
                        .font(.system(size: 13))
                        .foregroundColor(.blue)
                })))
            } else {
                let content = $1
                feedContent.append(.content(Text("\(content)")
                        .font(.system(size: 13))
                        .foregroundColor(.black)
                ))
            }
        }
    }
}
