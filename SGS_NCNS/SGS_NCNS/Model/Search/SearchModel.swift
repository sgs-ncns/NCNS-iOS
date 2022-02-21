//
//  SearchModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/21.
//

import Foundation

struct SearchModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case globals
        case hashtags
        case users
    }
    var globals: [SearchGlobalModel]
    var hashtags: [SearchHashtagsModel]
    var users: [SearchUsersModel]
}
