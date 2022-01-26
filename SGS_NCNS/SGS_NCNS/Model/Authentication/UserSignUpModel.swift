//
//  UserSignUpModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/26.
//

import Foundation

struct UserSignUpModel: Codable {
    var email: String
    var profileName: String
    var nickname: String
    var password: String
}
