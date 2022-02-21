//
//  UploadPostModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/11.
//

import Foundation

struct UploadPostModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case accountName = "account_name"
        case content
        case hashtag
        case imagePath = "image_path"
        case usertag
    }
    var accountName: String
    var content: String
    var hashtag: [String]
    var imagePath: String
    var usertag: [Int] = []
}
