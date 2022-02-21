//
//  CommentDetailViewModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/20.
//

import SwiftUI
import Combine
import Moya

class CommentDetailViewModel: ObservableObject {
    @Published var commentLists = CommentDetailModel(accountName: "", commentList: [CommentListModel(accountName: "", content: "", createdAt: "")], content: "", createdAt: "", imagePath: "", likeCount: 0, liking: false)
    @Published var isCommentLoading = true
    
    private var bag = Set<AnyCancellable>()
    init() {
        
    }
    
}

extension CommentDetailViewModel {
    func requestPostDetail(postId: Int) {
        self.isCommentLoading = true
        APIRequest.shared.requestPostDetail(postId: postId)
            .sink(receiveCompletion: { _ in
                self.isCommentLoading = false
            }, receiveValue: { [weak self] in
                if let response = try?
                    $0.map(ResponseModel<CommentDetailModel>.self) {
                    if response.responseCode == "2000" {
                        self?.commentLists = response.data ?? CommentDetailModel(accountName: "", commentList: [CommentListModel(accountName: "", content: "", createdAt: "")], content: "", createdAt: "", imagePath: "", likeCount: 0, liking: false)
                        print("requestPostDetailModel: \(response.data)")
                        
                    } else {
                        print("requestPostDetail Response Error : \(response.message)")
                    }
                } else {
                    print("responsePostDetail Error")
                }
            })
            .store(in: &bag)
    }
}

