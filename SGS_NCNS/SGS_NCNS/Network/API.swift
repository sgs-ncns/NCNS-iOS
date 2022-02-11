//
//  API.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/24.
//

import Foundation
import Moya

enum API {
    case requestSocialLogin(data: SocialSignInModel)
    case requestLogin(data: UserSignUpModel)
}

extension API: TargetType, AccessTokenAuthorizable {
    /// 접속할 Domain 설정
    var baseURL: URL {
        switch self {
        case .requestSocialLogin:
            return URL(string: "https://864aedf4-9033-4ea5-ad3c-736b182d96e2.mock.pstmn.io")!
        case .requestLogin:
            return URL(string: "http://15.165.120.145:9000")!
        }
        
    }
    
    /// 뒤에 붙을 Path 정의
    var path: String {
        switch self {
        case .requestSocialLogin:
            return "/auth/social"
        case .requestLogin:
            return "/api/user"
        }
    }
    
    /// get, post, delete, fetch 등등 작업 선언
    var method: Moya.Method {
        switch self {
        case .requestSocialLogin:
            return .post
        case .requestLogin(data: let data):
            return .post
        }
    }
    
    var sampleData: Data {
        switch self {
        case .requestSocialLogin:
            return Data()
        case .requestLogin:
            return Data()
        }
    }
    // 파라미터 안쓰고 사용: .requestPlain
    // 파라미터를 사용해서 통신: .requestParameters(parameters:, encoding:)
    // 파라미터 중 Encodable 타입을 JSON으로 바꿔서 전송한다: .requestJSONEncodable(Encodable)
    var task: Task {
        switch self {
        case let .requestSocialLogin(data):
            print(data)
            return .requestJSONEncodable(data)
        case let .requestLogin(data):
            return .requestJSONEncodable(data)
        }
    }
    
    // 토큰만 추가하기, 로그인 제외하고
    var headers: [String : String]? {
        return ["Content-type": "application/json; charset=UTF-8"]
    }
    
    /// return .barear
    /// return .none
    var authorizationType: AuthorizationType? {
        switch self {
        case .requestSocialLogin(_), .requestLogin(_):
            return .none
        }
    }
}
