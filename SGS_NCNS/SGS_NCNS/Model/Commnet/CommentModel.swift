//
//  CommentModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/02.
//

import SwiftUI
// 자른 Feed Content를 뷰로 만들어 이벤트 처리하기 위한 모델
enum Comment<T: View> {
    case user(NavigationLink<T, ProfileSubView>)
    case content(T)
    case hashtag(NavigationLink<T, HashTagView>)
    case humantag(NavigationLink<T, ProfileSubView>)
}
