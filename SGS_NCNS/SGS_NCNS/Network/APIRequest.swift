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
    private init() { }
    
    static let shared = APIRequest()
    
    private let provider = MoyaProvider<API>.init(session: DefaultAlamofireSession.sharedSession,
                                                  plugins: [AccessTokenPlugin { _ in return "bear-access-token-sample" }])
    
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
    func requestSocialLogin(data: SocialSignInModel) -> Future<Response, Error> {
        request(.requestSocialLogin(data: data))
    }
    func requestLogin(data: UserSignUpModel) -> Future<Response, Error> {
        request(.requestLogin(data: data))
    }
}
