//
//  FeedRecentFeedsModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/21.
//

import Foundation

struct FeedRecentFeedsModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case accountName = "account_name"
        case commentCount = "comment_count"
        case content
        case createdAt = "created_at"
        case imagePath = "image_path"
        case likeCount = "like_count"
        case liking
        case postId = "post_id"
        case userId = "user_id"
    }
    
    var accountName: String
    var commentCount: Int
    var content: String
    var createdAt: String
    var imagePath: String
    var likeCount: Int
    var liking: Bool = false
    var postId: Int
    var userId: Int
}
