//
//  NotificationModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/21.
//

import Foundation

struct NotificationGetModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case targetName
        case postId
        case category
        case likedName
        case createdAt = "created_at"
        case version = "__v"
    }
    var id: String
    var targetName: String
    var postId: Int
    var category: String
    var likedName: String
    var createdAt: String
    var version: Int
}

struct NotificationPostModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case accountName = "account_name"
        case postId = "post_id"
        case targetAccountName = "target_account_name"
    }
    var accountName: String
    var postId: Int
    var targetAccountName: String
}
