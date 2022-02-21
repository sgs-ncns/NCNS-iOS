//
//  NotificationGetViewModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/21.
//

import SwiftUI
import Combine

class NotificationGetViewModel: ObservableObject {
    @Published var notificationGetModel = [NotificationGetModel(id: "", targetName: "", postId: 0, category: "", likedName: "", createdAt: "", version: 0)]
    @Published var isLoading = true
    
    private var bag = Set<AnyCancellable>()
    
    init() {
        
    }
}

extension NotificationGetViewModel {
    func requestNotificationGet(accountId: String) {
        self.isLoading = true
        APIRequest.shared.requestNotificationGet(accountName: accountId)
            .sink(receiveCompletion: { _ in
                self.isLoading = false
            }, receiveValue: { [weak self] in
                if let response = try?
                    $0.map([NotificationGetModel].self) {
                    if $0.statusCode == 200 {
                        self?.notificationGetModel = response
                        print(self?.notificationGetModel)
                    } else {
                        print("noti get statuscode error \($0)")
                    }
                } else {
                    print("notiget error")
                }
            })
            .store(in: &bag)
    }
}
