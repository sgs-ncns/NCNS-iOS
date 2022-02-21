//
//  CommentCreateViewModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/21.
//

import SwiftUI
import Combine

class CommentCreateViewModel: ObservableObject {
    @Published var isCommentCreate: Bool = false
    
    private var bag = Set<AnyCancellable>()
    init() {
        
    }
    
}

extension CommentCreateViewModel {
    func requestCreateComment(data: CommentCreateModel) {
        APIRequest.shared.requestCreateComment(data: data)
            .sink(receiveCompletion: { _ in
                self.isCommentCreate = true
            }, receiveValue: { [weak self] in
                if let response = try?
                    $0.map(ResponseModel<[String: String]>.self) {
                    if response.responseCode == "2000" {
//                        self?.isCommentCreate = true
                        print("CommentCreate Complete")
                    } else {
                        print("CommentCreate ResponseCode Error: \(response.message)")
                    }
                }
            })
            .store(in: &bag)
    }
}
