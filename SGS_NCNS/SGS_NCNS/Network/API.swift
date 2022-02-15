//
//  API.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/24.
//

import Foundation
import Moya

enum API {
    case requestAccountLogin(data: LoginModel)
    case requestLocalLogin(data: LoginModel)
    case requestSocialLogin(data: SocialSignInModel)
    case requestSignUp(data: UserSignUpModel)
    case requestEmailDuplicate(email: String)
    case requestAccountDuplicate(account: String)
    case requestFeedList
}

extension API: TargetType, AccessTokenAuthorizable {
    // 접속할 Domain 설정
    var baseURL: URL {
//        return URL(string: "http://15.165.120.145:9000")!
        switch self {
        case .requestFeedList:
            return URL(string: "https://864aedf4-9033-4ea5-ad3c-736b182d96e2.mock.pstmn.io")!
        case .requestEmailDuplicate, .requestAccountDuplicate, .requestAccountLogin, .requestLocalLogin, .requestSignUp, .requestSocialLogin :
            return URL(string: "http://15.165.120.145:9000")!
        }
    }
    
    // 뒤에 붙을 Path 정의
    var path: String {
        switch self {
        case .requestAccountLogin:
            return "/api/auth/account"
        case .requestLocalLogin:
            return "/api/auth/local"
        case .requestSocialLogin:
            return "/api/auth/social"
        case .requestSignUp:
            return "/api/user"
        case .requestEmailDuplicate:
            return "/api/user/email"
        case .requestAccountDuplicate:
            return "/api/user/account"
        case .requestFeedList:
            return "/api/post"
        }
    }
    
    // get, post, delete, fetch 작업 선언
    var method: Moya.Method {
        switch self {
        case .requestAccountLogin:
            return .post
        case .requestLocalLogin:
            return .post
        case .requestSocialLogin:
            return .post
        case .requestSignUp:
            return .post
        case .requestEmailDuplicate:
            return .post
        case .requestAccountDuplicate:
            return .post
        case .requestFeedList:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    // 파라미터 안쓰고 사용: .requestPlain
    // 파라미터를 사용해서 통신: .requestParameters(parameters:, encoding:)
    // 파라미터 중 Encodable 타입을 JSON으로 바꿔서 전송한다: .requestJSONEncodable(Encodable)
    var task: Task {
        switch self {
        case let .requestAccountLogin(data):
            return .requestJSONEncodable(data)
        case let .requestLocalLogin(data):
            return .requestJSONEncodable(data)
        case let .requestSocialLogin(data):
            return .requestJSONEncodable(data)
        case let .requestSignUp(data):
            return .requestJSONEncodable(data)
        case let .requestEmailDuplicate(email):
            let parameters: [String: Any] = [
                "email" : email
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case let .requestAccountDuplicate(account):
            let parameters: [String: Any] = [
                "account_name" : account
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .requestFeedList:
            return .requestPlain
        }
    }
    
    // 토큰만 추가하기, 로그인 제외하고
    var headers: [String : String]? {
        return ["Content-type": "application/json; charset=UTF-8"]
    }
    
    // return .barear
    // return .none
    var authorizationType: AuthorizationType? {
        switch self {
        case .requestLocalLogin(_),
                .requestAccountLogin(_),
                .requestSocialLogin(_),
                .requestSignUp(_),
                .requestEmailDuplicate(_),
                .requestAccountDuplicate(_):
            return .none
        case .requestFeedList:
            // 나중에 .bearer로 바꿔야함
            return .none
        }
    }
}
