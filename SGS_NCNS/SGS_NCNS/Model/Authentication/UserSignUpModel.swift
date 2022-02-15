//
//  UserSignUpModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/26.
//

import Foundation

struct UserSignUpModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case email
        case nickname
        case accountName = "account_name"
        case password
        case authType = "auth_type"
    }
    var email: String?
    var nickname: String?
    var accountName: String?
    var password: String?
    var authType: String? = "LOCAL"
}
