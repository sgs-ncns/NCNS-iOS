//
//  FeedViewModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/14.
//

import Foundation

struct FeedModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case postId = "post_id"
        case userId = "user_id"
        case accountName = "account_name"
        case imagePath = "image_path"
        case content
        case createdAt = "created_at"
        case likeCount = "like_count"
        case commentCount = "comment_count"
    }
    
    var postId: Int
    var userId: Int
    var accountName: String
    var imagePath: String
    var content: String
    var createdAt:String
    var likeCount: Int = 0
    var commentCount: Int = 0
}
