//
//  FollowCheckModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/18.
//

import Foundation

struct FollowersCheckModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case accountName = "account_name"
        case id
        case nickname
    }
    var accountName: String
    var id: Int
    var nickname: String
}

struct FollowingCheckModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case accountName = "account_name"
        case id
        case nickname
    }
    var accountName: String
    var id: Int
    var nickname: String
}

struct KkanbuCheckModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case accountName = "account_name"
        case id
        case nickname
    }
    var accountName: String
    var id: Int
    var nickname: String
}
