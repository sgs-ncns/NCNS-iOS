//
//  UploadPostViewModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/11.
//

import Foundation
import Combine
import Moya

class UploadPostViewModel: ObservableObject {
    @Published var uploadPostModel = UploadPostModel(accountName: "", content: "", hashtag: [], imagePath: "")
    @Published var postCreateLoading = true
    
    init() {
        
    }
    
    private var bag = Set<AnyCancellable>()
}

extension UploadPostViewModel {
    func requestCreatePost(data: UploadPostModel) {
        self.postCreateLoading = true
        APIRequest.shared.requestCreatePost(data: data)
            .sink(receiveCompletion: { _ in
                self.postCreateLoading = false
            }, receiveValue: { [weak self] in
                if let response = try?
                    $0.map(ResponseModel<[String:String]>.self) {
                    if response.responseCode == "2000" {
                        print("Post Upload Success")
                    } else {
                        print(response.message)
                        print("Post Upload response Error")
                    }
                } else {
                    print("PostUpload Response Error")
                }
            })
            .store(in: &bag)
    }
}
