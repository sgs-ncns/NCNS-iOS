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
    
    private var bag = Set<AnyCancellable>()
    
    init() {
        
    }
    
}

extension FeedViewModel {
    func requestFeedList() {
        APIRequest.shared.requestFeedList()
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] in
                if let response = try?
                    $0.map(ResponseModel<[FeedModel]>.self) {
                    if response.responseCode == "2000" {
                        print("JSON 파싱 성공")
                        self?.feedModels = response.data!
                        print(self?.feedModels)
                    }
                }
            })
            .store(in: &bag)
    }
}

