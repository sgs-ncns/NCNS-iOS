//
//  ProfileModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/17.
//

import Foundation

struct ProfileModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case accountName = "account_name"
        case followerCount = "follower_count"
        case followingCount = "following_count"
        case userId = "user_id"
        case introduce
        case nickname
        case postCount = "post_count"
        case subscribingCount = "subscribing_count"
        case followStatus = "follow_status"
        case subscribeStatus = "subscribe_status"
    }
    var accountName: String
    var followerCount: Int
    var followingCount: Int
    var userId: Int
    var introduce: String?
    var nickname: String
    var postCount: Int
    var subscribingCount: Int?
    var followStatus: Bool?
    var subscribeStatus: Bool?
}
