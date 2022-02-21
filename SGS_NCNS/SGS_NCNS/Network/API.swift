//
//  API.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/24.
//

import Foundation
import Moya

enum API {
    case requestReissueToken
    case requestAccountLogin(data: LoginModel)
    case requestLocalLogin(data: LoginModel)
    case requestSocialLogin(data: SocialSignInModel)
    case requestSignUp(data: UserSignUpModel)
    case requestEmailDuplicate(email: String)
    case requestAccountDuplicate(account: String)
    case requestFeedList(page: Int)
    case requestSubscribingFeed
    case requestProfile(accountName: String)
    case requestUserPost(userId: Int)
    case requestFollow(targetId: Int)
    case requestKkanbu(targetId: Int)
    case requestFollowersList(userId: Int)
    case requestFollowingList(userId: Int)
    case requestKkanbuList
    case requestCreatePost(data: UploadPostModel)
    case requestPostDetail(postId: Int)
    case requestCreateComment(data: CommentCreateModel)
    case requestLikePost(postId: Int)
    case requestSearchAll(keyword: String) // 리퀘스트 만들어야함
    case requestNotificationGet(accountName: String)
    case requestNotificationPost(data: NotificationPostModel, categoriy: String)
    
}

extension API: TargetType, AccessTokenAuthorizable {
    // 접속할 Domain 설정
    var baseURL: URL {
//                return URL(string: "http://15.165.120.145:9000")!
        switch self {
        case .requestNotificationGet, .requestNotificationPost:
            return URL(string: "http://localhost:8000")!
        case .requestReissueToken, .requestEmailDuplicate, .requestAccountDuplicate, .requestAccountLogin, .requestLocalLogin, .requestSignUp, .requestSocialLogin, .requestProfile, .requestUserPost, .requestFollow, .requestKkanbu, .requestFollowersList, .requestFollowingList, .requestKkanbuList, .requestCreatePost, .requestSubscribingFeed, .requestPostDetail, .requestCreateComment, .requestLikePost, .requestSearchAll, .requestFeedList:
            return URL(string: "http://15.165.120.145:9000")!
        }
    }
    
    // 뒤에 붙을 Path 정의
    var path: String {
        switch self {
        case .requestReissueToken:
            return "/api/auth"
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
            return "/api/feed"
        case .requestSubscribingFeed:
            return "/api/feed/subscribing"
        case let .requestProfile(accountName):
            return "/api/user/\(accountName)"
        case let .requestUserPost(userId):
            return "/api/post"
        case let .requestFollow(targetId):
            return "/api/user/follow/\(targetId)"
        case let .requestKkanbu(targetId):
            return "/api/user/subscribe/\(targetId)"
        case let .requestFollowersList(userId):
            return "/api/user/\(userId)/followers"
        case let .requestFollowingList(userId):
            return "/api/user/\(userId)/following"
        case .requestKkanbuList:
            return "/api/user/subscribing"
        case .requestCreatePost:
            return "/api/post"
        case let .requestPostDetail(postId):
            return "/api/post/\(postId)"
        case let .requestCreateComment:
            return "/api/post/comment"
        case let .requestLikePost(postId):
            return "api/post/like/\(postId)"
        case .requestSearchAll:
            return "/api/search/type/all"
        case let .requestNotificationGet(accountName):
            return "/api/notify/\(accountName)"
        case let .requestNotificationPost(_, category):
            return "/api/notify/\(category)"
        }
    }
    
    // get, post, delete, fetch 작업 선언
    var method: Moya.Method {
        switch self {
        case .requestReissueToken:
            return .get
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
        case .requestSubscribingFeed:
            return .get
        case .requestProfile:
            return .get
        case .requestUserPost:
            return .get
        case .requestFollow:
            return .post
        case .requestKkanbu:
            return .post
        case .requestFollowersList:
            return .get
        case .requestFollowingList:
            return .get
        case .requestKkanbuList:
            return .get
        case .requestCreatePost:
            return .post
        case .requestPostDetail:
            return .get
        case .requestCreateComment:
            return .post
        case .requestLikePost:
            return .post
        case .requestSearchAll:
            return .get
        case .requestNotificationGet:
            return .get
        case .requestNotificationPost:
            return .post
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
        case .requestReissueToken:
            return .requestPlain
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
        case let .requestFeedList(page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.queryString)
        case let .requestSubscribingFeed:
            return .requestPlain
        case .requestProfile:
            return .requestPlain
        case let .requestUserPost(userId):
            return .requestParameters(parameters: ["userId": userId], encoding: URLEncoding.queryString)
        case .requestFollow:
            return .requestPlain
        case.requestKkanbu:
            return .requestPlain
        case .requestFollowersList:
            return .requestPlain
        case .requestFollowingList:
            return .requestPlain
        case .requestKkanbuList:
            return .requestPlain
        case let .requestCreatePost(data):
            return .requestJSONEncodable(data)
        case .requestPostDetail:
            return .requestPlain
        case let .requestCreateComment(data):
            let parameters: [String: Any] = [
                "account_name": data.accountName,
                "content" : data.content,
                "parent_id" : 0,
                "post_id" : data.postId
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .requestLikePost:
            return .requestPlain
        case let .requestSearchAll(keyword):
            return .requestParameters(parameters: ["keyword": keyword], encoding: URLEncoding.queryString)
        case .requestNotificationGet:
            return .requestPlain
        case let .requestNotificationPost(data, _):
            return .requestJSONEncodable(data)
        }
        
    }
    
    // 토큰만 추가하기, 로그인 제외하고
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    // return .barear
    // return .none
    var authorizationType: AuthorizationType? {
        switch self {
        case .requestReissueToken,
                .requestLocalLogin(_),
                .requestAccountLogin(_),
                .requestSocialLogin(_),
                .requestSignUp(_),
                .requestEmailDuplicate(_),
                .requestAccountDuplicate(_),
                .requestNotificationGet(_),
                .requestNotificationPost(_, _):
            return .none
        case .requestFeedList, .requestSubscribingFeed, .requestProfile(_), .requestUserPost, .requestFollow(_), .requestKkanbu(_), .requestFollowersList, .requestFollowingList, .requestKkanbuList, .requestCreatePost(_), .requestPostDetail(_), .requestCreateComment(_), .requestSearchAll(_), .requestLikePost(_):
            // 나중에 .bearer로 바꿔야함
            return .bearer
        }
    }
}
