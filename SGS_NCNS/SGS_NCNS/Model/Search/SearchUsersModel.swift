//
//  SearchUsersModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/21.
//

import Foundation

struct SearchUsersModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case accountName = "account_name"
        case nickname
        case userId = "user_id"
    }
    var accountName: String
    var nickname: String
    var userId: Int
}
