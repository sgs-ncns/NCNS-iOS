//
//  CommentDetailModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/20.
//

import Foundation

struct CommentDetailModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case accountName = "account_name"
        case commentList = "comment_list"
        case content
        case createdAt = "created_at"
        case imagePath = "image_path"
        case likeCount = "like_count"
        case liking
        case postId = "post_id"
        case userId = "user_id"
    }
    var accountName: String
    var commentList: [CommentListModel]
    var content: String
    var createdAt: String
    var imagePath: String
    var likeCount: Int
    var liking: Bool
    var postId: Int = 0
    var userId: Int = 0
}
