//
//  ImagePageViewModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/09.
//

import SwiftUI
import Combine
import Amplify

/*
 S3에 있는 이미지를 받아서 PageTabView Style로 보여주는 이미지 스크롤뷰에 이미지를 바인딩합니다.
 Amplify를 사용해 Path만 서버에서 받아오면 해당 폴더 내 모든 이미지를 리스트로 받아서 URL 객체를 배열로 저장해 다운받을 이미지들을 설정합니다.
 */

class ImagePageViewModel: ObservableObject {
    // 이미지 URL 객체 주소가 담기는 배열
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
