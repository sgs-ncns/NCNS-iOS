//
//  FeedNewCell.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/16.
//

import SwiftUI
import Kingfisher

struct FeedNewCell: View {
    @StateObject var feedNewViewModel = FeedNewViewModel()
    @StateObject var imagePageViewModel = ImagePageViewModel()
    @State var isSubLoadComplete = false
    @State var isStorageListComplete = false
    var path: String = ""
    var body: some View {
        VStack (alignment: .leading) {
            // 서버로부터 데이터 로딩 완료
            if isSubLoadComplete {
                // 깐부 수대로 반복
                ForEach(0 ..< feedNewViewModel.feedSubscribingModel.count) { i in
                    VStack {
                        ZStack {
                            LinearGradient(gradient: .init(colors: [Color("StoryColorTop"), Color("StoryColorMid"), Color("StoryColorBottom")]), startPoint: .topTrailing, endPoint: .bottomLeading)
                                .mask(Image(systemName: "circle").font(.system(size: 100, weight: .ultraLight)))
                                .frame(width: 96, height: 96)
                            Image("Exprofile_reflect")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 86, height: 86)
                                .clipShape(Circle())
                        }
                        
                        Text(feedNewViewModel.feedSubscribingModel[i].recentFeeds[0].accountName)
                            .font(.system(size: 13, weight: .semibold))
                    }
                    .padding(.leading, 11)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 40) {
                            ForEach(0 ..< feedNewViewModel.feedSubscribingModel[i].recentFeeds.count, id: \.self) { j in
                                NavigationLink(destination: {
                                    FeedCell(feedModel: FeedModel(postId: feedNewViewModel.feedSubscribingModel[i].recentFeeds[j].postId, userId: feedNewViewModel.feedSubscribingModel[i].recentFeeds[j].userId, accountName: feedNewViewModel.feedSubscribingModel[i].recentFeeds[j].accountName, imagePath: feedNewViewModel.feedSubscribingModel[i].recentFeeds[j].imagePath, content: feedNewViewModel.feedSubscribingModel[i].recentFeeds[j].content, createdAt: feedNewViewModel.feedSubscribingModel[i].recentFeeds[j].createdAt, likeCount: feedNewViewModel.feedSubscribingModel[i].recentFeeds[j].likeCount, commentCount: feedNewViewModel.feedSubscribingModel[i].recentFeeds[j].commentCount))
                                }, label: {
                                    // 이미지
                                    if self.isStorageListComplete {
                                        KFImage(imagePageViewModel.url)
                                            .cancelOnDisappear(true)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenWidth / 3, height: UIScreen.screenWidth / 3)
                                            .clipped()
                                    } else {
                                        ProgressView()
                                    }
                                })
                                    .buttonStyle(.plain)
                                    .onAppear {
                                        imagePageViewModel.loadOneImage(path: "\(feedNewViewModel.feedSubscribingModel[i].recentFeeds[j].userId)/\(feedNewViewModel.feedSubscribingModel[i].recentFeeds[j].imagePath)/")
                                    }
                                    .onReceive(imagePageViewModel.$LoadUrl, perform: {
                                        // amplify 성공
                                        if !$0 {
                                            self.isStorageListComplete = true
                                        } else {
                                            self.isStorageListComplete = false
                                        }
                                    })
                            }
                        }
                    }.padding([.leading, .trailing], 10)
                        .padding([.top, .bottom], 5)
                }
            } else {
                VStack {
                    ProgressView()
                }.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight*2/3)
            }
            
        }
        .onAppear(perform: {
            feedNewViewModel.requestSubscribingFeed()
        })
        .onReceive(feedNewViewModel.$isSubFeedLoading, perform: {
            if !$0 {
                self.isSubLoadComplete = true
            } else {
                self.isSubLoadComplete = false
            }
        })
    }
}

struct FeedNewCell_Previews: PreviewProvider {
    static var previews: some View {
        FeedNewCell()
    }
}
