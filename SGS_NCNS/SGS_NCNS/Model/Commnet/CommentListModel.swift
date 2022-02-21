//
//  CommentListModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/20.
//

import Foundation

struct CommentListModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case accountName = "account_name"
        case content
        case createdAt = "created_at"
        case id
        case parentId = "parent_id"
        case userId = "user_id"
    }
    var accountName: String
    var content: String
    var createdAt: String
    var id: Int = 0
    var parentId: Int = 0
    var userId: Int = 0
}
