//
//  TokenModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/17.
//

import Foundation

struct TokenModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
    var accessToken: String
    var refreshToken: String
}
