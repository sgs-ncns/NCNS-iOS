//
//  NotificationPostViewModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/21.
//

import SwiftUI
import Combine

class NotificationPostViewModel: ObservableObject {
    @Published var notificationPostModel = NotificationPostModel(accountName: "", postId: 0, targetAccountName: "")
    
    private var bag = Set<AnyCancellable>()
    init() {
        
    }
}

extension NotificationPostViewModel {
    func requsetNotificationPost(data: NotificationPostModel, category: String) {
        APIRequest.shared.requestNotificationPost(data: data, category: category)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] in
                if let response = try?
                    $0 {
                    if $0.statusCode == 200 {
                        print("보내기 완료")
                    } else {
                        print("status Code Error \($0.response)")
                    }
                } else {
                    print("아예 못받아옴")
                }
            })
            .store(in: &bag)
    }
}
