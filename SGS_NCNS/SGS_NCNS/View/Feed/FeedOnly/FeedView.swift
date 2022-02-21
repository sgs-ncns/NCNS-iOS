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
    @State var isLoadingComplete: Bool = false
    @State var nextPage = 2
    
    init() {
        
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                if !viewSwitch {
                    // 피드로 보기 뷰
                    if isLoadingComplete {
                        if feedViewModel.feedModels.count != 0 {
                            VStack {
                                ForEach(0 ..< feedViewModel.feedModels.count, id: \.self) { i in
                                    FeedCell(feedModel: feedViewModel.feedModels[i])
                                }
                            }
                        } else {
                            VStack {
                                Text("Please Add First Follow! ")
                            }
                        }
                    } else {
                        ProgressView()
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
                feedViewModel.requestFeedList(page: 1)
                self.firstAppear = false
            })
            .onReceive(feedViewModel.$isLoading, perform: {
                if !$0 {
                    self.isLoadingComplete = true
                }
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
