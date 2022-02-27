//
//  SearchGlobalModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/21.
//

import Foundation

struct SearchGlobalModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case hashtag
        case user
    }
    var hashtag: [SearchHashtagsModel]?
    var user: [SearchUsersModel]?
}
