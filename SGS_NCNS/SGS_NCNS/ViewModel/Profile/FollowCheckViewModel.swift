//
//  FollowCheckViewModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/18.
//

import SwiftUI
import Combine
import Moya

class FollowCheckViewModel: ObservableObject {
    @Published var followersCheckModels = [FollowersCheckModel(accountName: "", id: 0, nickname: "")]
    @Published var followingCheckModels = [FollowingCheckModel(accountName: "", id: 0, nickname: "")]
    @Published var kanbuCheckModels = [KkanbuCheckModel(accountName: "", id: 0, nickname: "")]
    @Published var isAllListLoad = false
    @Published var isFollowingLoading = true
    @Published var isFollowersLoading = true
    @Published var isKkanbuLoading = true
    
    private var bag = Set<AnyCancellable>()
    
    var isLoadingComplete: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest3(self.$isFollowersLoading, self.$isFollowingLoading, self.$isKkanbuLoading)
            .map { return !$0 && !$1 && !$2 }
            .eraseToAnyPublisher()
    }
    
}

extension FollowCheckViewModel {
    func requestFollowersList(userId: Int) {
        self.isFollowersLoading = true
        APIRequest.shared.requestFollowersList(userId: userId)
            .sink(receiveCompletion: { _ in
                self.isFollowersLoading = false
            }, receiveValue: { [weak self] in
                if let response = try?
                    $0.map(ResponseModel<[FollowersCheckModel]>.self) {
                    if response.responseCode == "1000" {
                        self?.followersCheckModels = response.data!
                    }
                }
            })
            .store(in: &bag)
    }
    func requestFollowingList(userId: Int) {
        self.isFollowersLoading = true
        APIRequest.shared.requestFollowingList(userId: userId)
            .sink(receiveCompletion: { _ in
                self.isFollowingLoading = false
            }, receiveValue: { [weak self] in
                if let response = try?
                    $0.map(ResponseModel<[FollowingCheckModel]>.self) {
                    if response.responseCode == "1000" {
                        self?.followingCheckModels = response.data!
                    }
                }
            })
            .store(in: &bag)
    }
    func requestKkanbusList() {
        self.isKkanbuLoading = true
        APIRequest.shared.requestKkanbuList()
            .sink(receiveCompletion: { _ in
                self.isKkanbuLoading = false
            }, receiveValue: { [weak self] in
                if let response = try?
                    $0.map(ResponseModel<[KkanbuCheckModel]>.self) {
                    if response.responseCode == "1000" {
                        self?.kanbuCheckModels = response.data!
                    }
                }
            })
            .store(in: &bag)
    }
}
