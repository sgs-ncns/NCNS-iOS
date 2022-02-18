//
//  ProfileViewModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/17.
//

import SwiftUI
import Combine
import Moya

class ProfileViewModel: ObservableObject {
    @Published var profileModel = ProfileModel(accountName: "", followerCount: 0, followingCount: 0, userId: 0, nickname: "", postCount: 0)
    @Published var isLoading = true
    @Published var isLoadingFollow = true
    @Published var isLoadingKkanbu = true
    
    private var bag = Set<AnyCancellable>()
}

extension ProfileViewModel {
    func requestReissueToken() {
        APIRequest.shared.requestReissueToken()
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] in
                if let response = try?
                    $0.map(ResponseModel<TokenModel>.self) {
                    if response.responseCode == "0000" {
                        let kc = KeyChainUtils()
                        kc.create("login", account: "accessToken", value: response.data!.accessToken)
                        kc.create("login", account: "refreshToken", value: response.data!.refreshToken)
                    }
                }
            })
            .store(in: &bag)
    }
    
    func requestProfile(accountName: String) {
        self.isLoading = true
        APIRequest.shared.requestProfile(accountName: accountName)
            .sink(receiveCompletion: { _ in
                self.isLoading = false
            }, receiveValue: { [weak self] in
                if let response = try?
                    $0.map(ResponseModel<ProfileModel>.self) {
                    if response.responseCode == "1000" {
                        self?.profileModel = response.data!
                    }
                } else {
                    print("requestProfile Response Error")
                }
            })
            .store(in: &bag)
    }
    
    func requestFollow(targetId: Int) {
        self.isLoadingFollow = true
        APIRequest.shared.requestFollow(targetId: targetId)
            .sink(receiveCompletion: { _ in
                // loading
                self.isLoadingFollow = false
            }, receiveValue: { [weak self] in
                if let response = try?
                    $0.map(ResponseModel<FollowRequestModel>.self) {
                    if response.responseCode == "1000" {
                        // 팔로우 하기
                        if response.data!.status == true {
                            self?.profileModel.followStatus = true
                            self?.profileModel.followerCount += 1
                        } else {
                            self?.profileModel.followStatus = false
                            self?.profileModel.followerCount -= 1
                        }
                    } else {
                        print("RequestFollow error")
                    }
                } else {
                    print("RequestFollow Response Error")
                }
            })
            .store(in: &bag)
    }
    
    func requestKkanbu(targetId: Int) {
        self.isLoadingKkanbu = true
        APIRequest.shared.requestKkanbu(targetId: targetId)
            .sink(receiveCompletion: { _ in
                // loading
                self.isLoadingKkanbu = false
            }, receiveValue: { [weak self] in
                if let response = try?
                    $0.map(ResponseModel<KkanbuRequestModel>.self) {
                    if response.responseCode == "1000" {
                        // 깐부 하기
                        if response.data!.status == true {
                            self?.profileModel.subscribeStatus = true
                        } else {
                            self?.profileModel.subscribeStatus = false
                        }
                    } else {
                        print("Request Kkanbu error")
                    }
                } else {
                    print("RequestKkanbu Response Error")
                }
            })
            .store(in: &bag)
    }
}
