//
//  SearchHashtagsModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/21.
//

import Foundation

struct SearchHashtagsModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case content
        case count
        case postIdList = "post_id_list"
    }
    var content: String
    var count: Int
    var postIdList: [Int]
}
