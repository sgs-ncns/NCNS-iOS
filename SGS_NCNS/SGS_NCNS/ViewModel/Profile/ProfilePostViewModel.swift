//
//  ProfilePostViewModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/19.
//

import SwiftUI
import Combine
import Moya

class ProfilePostViewModel: ObservableObject {
    @Published var profilePostModels = [ProfilePostModel(postId: 0, userId: 0, accountName: "", imagePath: "", content: "", createdAt: "", likeCount: 0, commentCount: 0)]
    @Published var imageDownloadPath: [String] = []
    @Published var isProfilePostLoading = true
    
    init() {
        
    }
    
    private var bag = Set<AnyCancellable>()
}

extension ProfilePostViewModel {
    func requestUserPost(userId: Int) {
        self.isProfilePostLoading = true
        APIRequest.shared.requestUserPost(userId: userId)
            .sink(receiveCompletion: { _ in
                self.isProfilePostLoading = false
            }, receiveValue: { [weak self] in
                if let response = try?
                    $0.map(ResponseModel<[ProfilePostModel]>.self) {
                    if response.responseCode == "2000" {
                        print("UserPost Success")
                        self?.profilePostModels = response.data ?? []
                        for i in response.data!.indices {
                            self?.imageDownloadPath.append("\(response.data![i].userId)/\(response.data![i].imagePath)")
                        }
                    } else {
                        print("UserPost Request Success")
                    }
                } else {
                    print("UserPost Response Error")
                }
            })
            .store(in: &bag)
    }
}
