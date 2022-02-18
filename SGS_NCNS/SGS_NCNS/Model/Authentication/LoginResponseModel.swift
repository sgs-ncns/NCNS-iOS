//
//  LoginResponseModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/15.
//

import Foundation

struct LoginResponseModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case userId = "user_id"
        case accountName = "account_name"
    }
    var accessToken: String
    var refreshToken: String
    var userId: Int
    var accountName: String
}
