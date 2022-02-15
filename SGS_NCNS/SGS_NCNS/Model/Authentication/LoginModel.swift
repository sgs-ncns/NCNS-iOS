//
//  LoginModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/14.
//

import Foundation

@propertyWrapper
struct NullEncodable<T>: Encodable where T: Encodable {
    
    var wrappedValue: T?

    init(wrappedValue: T?) {
        self.wrappedValue = wrappedValue
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch wrappedValue {
        case .some(let value): try container.encode(value)
        case .none: try container.encodeNil()
        }
    }
}

struct LoginModel: Encodable {
    private enum CodingKeys: String, CodingKey {
        case email
        case accountName = "account_name"
        case password
    }
    
    @NullEncodable var email: String? = nil
    @NullEncodable var accountName: String? = nil
    @NullEncodable var password: String? = nil
}
