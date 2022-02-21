//
//  FeedSubscribingModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/21.
//

import Foundation

struct FeedSubscribingModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case recentFeeds = "recent_feeds"
        case userId = "user_id"
    }
    var recentFeeds: [FeedRecentFeedsModel]
    var userId: Int
}
