//
//  APIRequest.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/24.
//

import Foundation
import Moya
import Combine

final class APIRequest {
    init() {
        
    }
    
    static let shared = APIRequest()
    
    
    private let provider = MoyaProvider<API>.init(session: DefaultAlamofireSession.sharedSession,
                                                  plugins: [AccessTokenPlugin { _ in
        let kc = KeyChainUtils()
        let accessToken = kc.read("login", account: "accessToken") ?? ""
        return "\(accessToken)" }])
    
    private func request(_ api: API) -> Future<Response, Error> {
        Future<Response, Error> { [weak self] promise in
            guard let self = self else { return }
            self.provider.request(api) { result in
                switch result {
                case let .success(response):
                    promise(.success(response))
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
    }
}

final class DefaultAlamofireSession: Session {
    static let sharedSession: DefaultAlamofireSession = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Session.default.session.configuration.httpAdditionalHeaders
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 50
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return DefaultAlamofireSession(configuration: configuration)
    }()
}

extension APIRequest {
    func requestReissueToken() -> Future<Response, Error> {
        request(.requestReissueToken)
    }
    func requestAccountLogin(data: LoginModel) -> Future<Response, Error> {
        request(.requestAccountLogin(data: data))
    }
    func requestLocalLogin(data: LoginModel) -> Future<Response, Error> {
        request(.requestLocalLogin(data: data))
    }
    func requestSocialLogin(data: SocialSignInModel) -> Future<Response, Error> {
        request(.requestSocialLogin(data: data))
    }
    func requestSignUp(data: UserSignUpModel) -> Future<Response, Error> {
        request(.requestSignUp(data: data))
    }
    func requestEmailDuplicate(email: String) -> Future<Response, Error> {
        request(.requestEmailDuplicate(email: email))
    }
    func requestAccountDuplicate(account: String) -> Future<Response, Error> {
        request(.requestAccountDuplicate(account: account))
    }
    func requestFeedList(page: Int) -> Future<Response, Error> {
        request(.requestFeedList(page: page))
    }
    func requestSubscribingFeed() -> Future<Response, Error> {
        request(.requestSubscribingFeed)
    }
    func requestProfile(accountName: String) -> Future<Response, Error> {
        request(.requestProfile(accountName: accountName))
    }
    func requestFollow(targetId: Int) -> Future<Response, Error> {
        request(.requestFollow(targetId: targetId))
    }
    func requestKkanbu(targetId: Int) -> Future<Response, Error> {
        request(.requestKkanbu(targetId: targetId))
    }
    func requestFollowersList(userId: Int) -> Future<Response, Error> {
        request(.requestFollowersList(userId: userId))
    }
    func requestFollowingList(userId: Int) -> Future<Response, Error> {
        request(.requestFollowingList(userId: userId))
    }
    func requestKkanbuList() -> Future<Response, Error> {
        request(.requestKkanbuList)
    }
    func requestCreatePost(data: UploadPostModel) -> Future<Response, Error> {
        request(.requestCreatePost(data: data))
    }
    func requestUserPost(userId: Int) -> Future<Response, Error> {
        request(.requestUserPost(userId: userId))
    }
    func requestPostDetail(postId: Int) -> Future<Response, Error> {
        request(.requestPostDetail(postId: postId))
    }
    func requestLikePost(postId: Int) -> Future<Response, Error> {
        request(.requestLikePost(postId: postId))
    }
    func requestCreateComment(data: CommentCreateModel) -> Future<Response, Error> {
        request(.requestCreateComment(data: data))
    }
    func requestNotificationGet(accountName: String) -> Future<Response, Error> {
        request(.requestNotificationGet(accountName: accountName))
    }
    func requestNotificationPost(data: NotificationPostModel, category: String) -> Future<Response, Error> {
        request(.requestNotificationPost(data: data, categoriy: category))
    }
    func requestSearchAll(keyword: String) -> Future<Response, Error> {
        request(.requestSearchAll(keyword: keyword))
    }
}
