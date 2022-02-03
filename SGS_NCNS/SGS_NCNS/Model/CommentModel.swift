//
//  CommentModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/02.
//

import SwiftUI

enum Comment<T: View> {
    case user(NavigationLink<T, ProfileSubView>)
    case content(T)
    case hashtag(NavigationLink<T, HashTagView>)
    case humantag(NavigationLink<T, ProfileSubView>)
}
