//
//  FeedView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/06.
//

import SwiftUI

struct FeedView: View {
    @StateObject var feedViewModel = FeedViewModel()
    @State var firstAppear: Bool = true
    
    init() {
        
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(0 ..< feedViewModel.feedModels.count, id: \.self) { i in
                        FeedCell(feedModel: feedViewModel.feedModels[i])
                    }
//                    FeedCell(path: "contea95/e/")
//                    FeedCell(path: "test2/")
                }
            }
            .onAppear(perform: {
                if !self.firstAppear { return }
                feedViewModel.requestFeedList()
                self.firstAppear = false
            })
            .navigationTitle("")
            .padding(0.0)
            .navigationBarItems(leading:Image("IGlogo"))
            .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
