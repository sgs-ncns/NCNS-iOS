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
    @Published var url: URL? = URL(string: "")
    @Published var isUploadLoading: Bool = false
    @Published var isListingFile: Bool = false
    @Published var LoadUrl: Bool = true
    @Published var isMulitListLoading: Bool = true
    var resultSink: AnyCancellable?
    var progressSink: AnyCancellable?
    
    private var bag = Set<AnyCancellable>()
    
    func listFilesLastOne(paths: [String]) {
        self.isMulitListLoading = true
        self.urls = []
        var finishCount = 1
        for path in paths {
            var imageList: [String] = []
            let sink =
            Amplify.Storage.list(options: .init(path: path))
                .resultPublisher
                .receive(on: DispatchQueue.main)
                .sink {
                    if case let .failure(storageError) = $0 {
                        print("Failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
                    }
                    
                    self.urls.append(URL(string: "https://sgsncns130837-dev.s3.ap-northeast-2.amazonaws.com/public/\(imageList[0])")!)
                    if finishCount == paths.count {
                        self.isMulitListLoading = false
                    } else {
                        finishCount += 1
                    }
                }
        receiveValue: { listResult in
            print(listResult)
            listResult.items.forEach { item in
                imageList.append("\(item.key)")            }
        }
        .store(in: &bag)
        }
    }
    
    func loadOneImage(path: String) {
        self.LoadUrl = true
        self.url = URL(string: "")
        print("path: \(path)")
        resultSink = Amplify.Storage.list(options: .init(path: path))
            .resultPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let storageError) = completion {
                    print("Failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
                }
                self.LoadUrl = false
            }, receiveValue: { listResult in
                print("listResult: \(listResult)")
                listResult.items.forEach { item in
                    self.url = (URL(string: "https://sgsncns130837-dev.s3.ap-northeast-2.amazonaws.com/public/\(item.key)")!)
                }
            })
    }
    
    func listFileOnlyOne(path: String) {
        self.isListingFile = true
//        self.urls = []
        print("path: \(path)")
        resultSink = Amplify.Storage.list(options: .init(path: path))
            .resultPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let storageError) = completion {
                    print("Failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
                }
                self.isListingFile = false
            }, receiveValue: { listResult in
                print("listResult: \(listResult)")
                listResult.items.forEach { item in
                    self.urls.append(URL(string: "https://sgsncns130837-dev.s3.ap-northeast-2.amazonaws.com/public/\(item.key)")!)
                }
            })
    }
    
    func listFile(path: String) {
        self.isListingFile  = true
        self.urls = []
        resultSink = Amplify.Storage.list(options: .init(path: path))
            .resultPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let storageError) = completion {
                    print("Failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
                }
                self.isListingFile = false
            }, receiveValue: { [weak self] in
                print(path)
                $0.items.forEach { item in
                    self?.urls.append(URL(string: "https://sgsncns130837-dev.s3.ap-northeast-2.amazonaws.com/public/\(item.key)")!)
                }
                print(self?.urls)
            })
    }
    // Amplify를 통한 이미지 업로드
    func uploadImage(_ image: UIImage, dateNow: String) {
        self.isUploadLoading = true
        guard let imageData = image.jpegData(compressionQuality: 1) else { return }
        let currentUser = KeyChainUtils().read("login", account: "userId")!
        let key = "\(currentUser)/\(dateNow)/\(UUID().uuidString).jpg"
        
        resultSink = Amplify.Storage.uploadData(key: key, data: imageData)
            .resultPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let storageError) = completion {
                    print("Failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
                }
                self.isUploadLoading = false
            }, receiveValue: { data in
                print("Completed: \(data)")
            })
    }
}
