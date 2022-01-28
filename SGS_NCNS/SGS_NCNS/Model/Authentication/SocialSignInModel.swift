//
//  GoogleUserSignInModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/26.
//

import Foundation

struct SocialSignInModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case authType = "auth_type"
        case email
    }
    var authType: String
    var email: String
}
