//
//  FeedNewModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/16.
//

import SwiftUI
import Combine
import Moya

class FeedNewViewModel: ObservableObject {
    @Published var feedSubscribingModel = [FeedSubscribingModel]()
    @Published var isSubFeedLoading = true
    
    private var bag = Set<AnyCancellable>()
    
    init() {
        
    }
    
}

extension FeedNewViewModel {
    func requestSubscribingFeed() {
        self.isSubFeedLoading = true
        APIRequest.shared.requestSubscribingFeed()
            .sink(receiveCompletion: { _ in
                self.isSubFeedLoading = false
            }, receiveValue: { [weak self] in
                if let response = try?
                    $0.map(ResponseModel<[FeedSubscribingModel]>.self) {
                    if response.responseCode == "3000" {
                        self?.feedSubscribingModel = response.data ?? []
                    } else {
                        print("requestSubscribingFeed ResponseCode Error: \(response.message)")
                    }
                } else {
                    print("requestSubscribingFeed Error")
                }
            })
            .store(in: &bag)
    }
}
