//
//  SearchViewModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/21.
//

import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchModel = SearchModel(globals: [SearchGlobalModel](), hashtags: [SearchHashtagsModel](), users: [SearchUsersModel]())
    @Published var tmp: String = ""
    
    private var bag = Set<AnyCancellable>()
    
    init() {
        
    }
}

extension SearchViewModel {
    func requestSearchAll(keyword: String) {
        APIRequest.shared.requestSearchAll(keyword: keyword)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] in
                if let response = try?
                    $0.map(ResponseModel<String>.self) {
                    
                    if response.responseCode == "4000" {
                        self?.tmp = response.data!
                        print("성공!")
                        print("\(response.data)")
                    } else {
                        print("search response error \(response.message)")
                    }
                } else {
                    print("search error")
                }
            })
            .store(in: &bag)
    }
}
