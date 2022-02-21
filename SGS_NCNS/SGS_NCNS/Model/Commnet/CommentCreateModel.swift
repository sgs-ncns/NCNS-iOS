//
//  CommentCreateModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/21.
//

import SwiftUI

struct CommentCreateModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case accountName = "account_name"
        case content
        case parentId = "parent_id"
        case postId = "post_id"
    }
    var accountName: String
    var content: String
    var parentId: Int = 0
    var postId: Int
}
