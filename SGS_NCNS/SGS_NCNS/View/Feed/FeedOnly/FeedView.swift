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
    @State var viewSwitch: Bool = false
    
    init() {
        
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                if !viewSwitch {
                    // 피드로 보기 뷰
                    VStack {
                        ForEach(0 ..< feedViewModel.feedModels.count, id: \.self) { i in
                            FeedCell(feedModel: feedViewModel.feedModels[i])
                        }
                    }
                } else {
                    // 사람으로 보기 뷰
                    withAnimation {
                        VStack(spacing: 30) {
                            FeedNewCell()
                        }
                    }
                    .transition(.opacity)
                }
            }
            .onAppear(perform: {
                if !self.firstAppear { return }
                feedViewModel.requestFeedList()
                self.firstAppear = false
            })
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.viewSwitch.toggle()
                    }, label: {
                        Text(self.viewSwitch ? "피드로 보기" : "사람으로 보기")
                    })
                }
            }
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
