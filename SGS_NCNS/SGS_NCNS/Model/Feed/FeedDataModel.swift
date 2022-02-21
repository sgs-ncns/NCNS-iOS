//
//  FeedDataModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/20.
//

import SwiftUI

struct FeedDataModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case endOfFeed = "end_of_feed"
        case feeds
        case result
    }
    var endOfFeed: Bool
    var feeds: [FeedModel]
    var result: Bool
}
