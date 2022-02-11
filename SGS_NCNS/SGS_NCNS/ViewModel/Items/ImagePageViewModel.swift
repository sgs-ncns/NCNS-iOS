//
//  ImagePageViewModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/09.
//

import SwiftUI
import Combine
import Amplify

class ImagePageViewModel: ObservableObject {
    @Published var urls: [URL] = []
    var resultSink: AnyCancellable?
    var progressSink: AnyCancellable?
    
    init(path: String) {
        self.listFile(path: path)
    }
    
    func listFile(path: String) {
        resultSink = Amplify.Storage.list(options: .init(path: path))
            .resultPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let storageError) = completion {
                    print("Failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
                }
            }, receiveValue: { [weak self] in
                $0.items.forEach { item in
                    self?.urls.append(URL(string: "https://sgsncns130837-dev-resized.s3.ap-northeast-2.amazonaws.com/public/\(item.key)")!)
                }
            })
    }
}
