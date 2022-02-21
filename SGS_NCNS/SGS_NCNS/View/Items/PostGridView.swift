//
//  PostGridView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/14.
//

import SwiftUI
import Kingfisher

struct PostGridView: View {
    @StateObject var profilePostViewModel = ProfilePostViewModel()
    @StateObject var imagePageViewModel = ImagePageViewModel()
    @State private var profilePostComplete = false
    @State private var urlPathArrayComplete = false
    @State private var isPostZero = false
    @State var urlPathArray: [URL] = []
    
    var isPostGridViewLoad: Bool = false
    
    var userId: Int
    // 한 화면에 3개
    private let items = [
        GridItem(.flexible(minimum: 40)),
        GridItem(.flexible(minimum: 40)),
        GridItem(.flexible(minimum: 40)),]
    private let width = (UIScreen.screenWidth - 4) / 3
    
    var body: some View {
        ZStack {
            if isPostZero {
                Text("Write the first post. 🥰")
            } else {
                // if self.profilePostViewModel
                LazyVGrid(columns: items, alignment: .center) {
                    if urlPathArrayComplete {
                        ForEach(0 ..< self.profilePostViewModel.profilePostModels.count, id:\.self) { i in
                            NavigationLink(destination: FeedCell(feedModel: FeedModel(postId: profilePostViewModel.profilePostModels[i].postId, userId: profilePostViewModel.profilePostModels[i].userId, accountName: profilePostViewModel.profilePostModels[i].accountName, imagePath: profilePostViewModel.profilePostModels[i].imagePath, content: profilePostViewModel.profilePostModels[i].content, createdAt: profilePostViewModel.profilePostModels[i].createdAt, likeCount: profilePostViewModel.profilePostModels[i].likeCount, commentCount: profilePostViewModel.profilePostModels[i].commentCount)), label: {
                                var _ = print(urlPathArray[i])
                                KFImage(urlPathArray[i])
                                    .cancelOnDisappear(true)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: width, height: width)
                                    .clipped()
                                //                            Text("hi")
                            }).buttonStyle(.plain)
                        }
                    } else {
                        ProgressView()
                    }
                }
            }
        }
        .onAppear {
            // 게시물이 0개일 때는 불러오지 않습니다.
            if isPostGridViewLoad {
                self.profilePostViewModel.requestUserPost(userId: self.userId)
            } else {
                self.isPostZero = true
            }
        }
        // 서버에서 피드 받아오는것 체크
        .onReceive(self.profilePostViewModel.$isProfilePostLoading, perform: {
            if $0 {
                self.profilePostComplete = false
            } else {
                // 서버에서 프로필 피드 받아오기 완료
                imagePageViewModel.listFilesLastOne(paths:profilePostViewModel.imageDownloadPath)
            }
        })
        // Amplify를 통한 S3내 리스트 받아오기
        .onReceive(self.imagePageViewModel.$isMulitListLoading, perform: {
            if !$0 {
                self.urlPathArray = self.imagePageViewModel.urls
//                    .sorted(by: { $0, $1 in
//                    return String($0) > String($1)
//                })
                self.urlPathArrayComplete = true
            }
        })
    }
}
//
//struct PostGridView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostGridView()
//    }
//}
