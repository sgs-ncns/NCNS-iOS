//
//  ResponseModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/27.
//

import Foundation

struct ResponseModel<T: Decodable>: Decodable {
    // required, 임의의 코드
    let responseCode: String!
    // optional, 상태에 대한 메시지
    let message: String?
    // optional, 응답 객체
    let data: T?
    
    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case message
        case data
    }
    
}
