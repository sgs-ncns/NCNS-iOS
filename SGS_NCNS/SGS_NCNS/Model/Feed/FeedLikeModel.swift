//
//  FeedLikeModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/21.
//

import Foundation

struct FeedLikeModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case status
    }
    var status: Bool
}
