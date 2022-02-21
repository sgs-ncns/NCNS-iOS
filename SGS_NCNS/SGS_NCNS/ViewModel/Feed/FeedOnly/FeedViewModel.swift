//
//  FeedViewModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/14.
//

import SwiftUI
import Combine
import Moya

class FeedViewModel: ObservableObject {
    @Published var feedModels = [FeedModel]()
    @Published var feedDataModels = FeedDataModel(endOfFeed: false, feeds: [FeedModel](), result: true)
    @Published var result = true
    @Published var isLoading = true
    @Published var likeStatus = false
    
    private var bag = Set<AnyCancellable>()
    
    init() {
        
    }
    
}

extension FeedViewModel {
    func requestFeedList(page: Int) {
        self.isLoading = true
        APIRequest.shared.requestFeedList(page: page)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] in
                if let response = try?
                    $0.map(ResponseModel<FeedDataModel>.self) {
                    if response.responseCode == "3000" {
                        if page == 1 {
                            self?.feedDataModels = response.data ?? FeedDataModel(endOfFeed: false, feeds: [FeedModel](), result: true)
                            self?.feedModels = response.data?.feeds ?? [FeedModel(postId: 0, userId: 0, accountName: "", imagePath: "", content: "", createdAt: "")]
                        } else {
                            if response.data?.endOfFeed == false {
                                self?.feedModels += response.data!.feeds
                            } else {
                                
                            }
                        }
                        
                        self?.isLoading = false
                    } else {
                        print("requestFeedList Response Error : \(response.message)")
                    }
                } else {
                    print("requestFeedList Error")
                }
            })
            .store(in: &bag)
    }
    
    func requestLikePost(postId: Int) {
        APIRequest.shared.requestLikePost(postId: postId)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] in
                if let response = try?
                    $0.map(ResponseModel<FeedLikeModel>.self) {
                    if response.responseCode == "2000" {
                        print(response)
                        self?.likeStatus = ((response.data?.status) != nil)
                        print(self?.likeStatus)
                    } else {
                        print("requestLike Response Code Error: \(response.message)")
                    }
                } else {
                    print("requestLike Response Error")
                }
            })
            .store(in: &bag)
    }
}

