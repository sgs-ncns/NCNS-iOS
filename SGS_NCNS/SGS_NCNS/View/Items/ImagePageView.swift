//
//  PageView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/05.
//

import SwiftUI
import Kingfisher

/*
 피드에서 여러 이미지를 보여주는 ImagePageView입니다.
 ImagePageViewModel에서 저장한 이미지 객체 URL 배열인 urls를 받아와 이미지를 스크롤뷰로 보여줍니다.
 KingFisher 라이브러리를 통해 이미지를 불러옴과 동시에 url을 캐시에 저장합니다.
 불러온 적이 있는 url이면 캐시에 저장된 이미지를 가져오고, 없으면 url을 통해 이미지를 다운로드합니다.
 */
struct PageViewCell: View {
    @StateObject var imagePageViewModel = ImagePageViewModel()
    @StateObject var feedViewModel = FeedViewModel()
    @StateObject var notificationPostViewModel = NotificationPostViewModel()
    @State var isLoading = true
    @State var firstLoading = true
    @State var isLiked = false
    var userId: Int
    var accountName: String
    var path: String
    var postId: Int
    let kcAccountName = KeyChainUtils().read("login", account: "accountName")!
    // 인디케이터 색 바꾸기
    init(userId: Int, accountName: String, path: String, postId: Int) {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(named: "FeedIndicator")
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(named: "FeedIndicatorReady")
//        _imagePageViewModel = StateObject(wrappedValue: ImagePageViewModel(path: path))
        self.userId = userId
        self.accountName = accountName
        self.path = path
        self.postId = postId
        self.isLiked = isLiked
    }
    
    var body: some View {
        HStack {
            VStack() {
                // isListingFile이걸 onReceive로 받아서 처리해야 들어감
                if !self.isLoading {
                    TabView {
                        ForEach(0 ..< imagePageViewModel.urls.count) { i in
                            KFImage(imagePageViewModel.urls[i])
                                .cancelOnDisappear(true)
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: (UIScreen.main.bounds.width / 4) * 5)
                                .clipped()
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.width / 4) * 5 + 100)
                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: (UIScreen.main.bounds.width / 4) * 5 + 100)
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(.page)
                    .overlay(
                        ZStack {
                            Rectangle()
                                .foregroundColor(.white)
                            NavigationLink(destination: ProfileSubView(clickedUserName: accountName)) {
                                VStack {
                                    HStack {
                                        Image("user_default")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 32, height: 32)
                                            .clipShape(Circle())
                                            .padding(.leading, 10)
                                        
                                        Text(accountName)
                                            .font(.system(size: 13, weight: .semibold))
                                            .padding(.leading, 4)
                                        
                                        Spacer()
                                        
                                        Button(action: {}, label: {
                                            Image("More")
                                        })
                                        Spacer()
                                            .frame(width: 15)
                                    }
                                    
                                    Divider()
                                        .frame(height: 1)
                                        .background(Color(.systemGray6))
                                }
                            }.buttonStyle(FlatLinkStyle())
                        }
                            .frame(height: 54), alignment: .top
                    )
                    .overlay(
                        // button
                        HStack() {
                            Spacer()
                                .frame(width: 15)
                            
                            Button(action: {
                                feedViewModel.requestLikePost(postId: self.postId)
                                notificationPostViewModel.requsetNotificationPost(data: NotificationPostModel(accountName: self.accountName, postId: self.postId, targetAccountName: kcAccountName), category: "like")
//                                self.isLiked.toggle()
                            }, label: {
                                Image(systemName: feedViewModel.likeStatus ? "heart.fill" : "heart")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 23, height: 23)
                                    .padding(4)
                                    .font(.system(size: 23,weight: .light))
                                    .foregroundColor(feedViewModel.likeStatus ? Color("FeedLikeColor") : .black)
                            })
                            
                            Button(action: {}, label: {
                                Image("Comment")
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 23, height: 23)
                                    .padding(4)
                                    .foregroundColor(.black)
                            })
                            
                            Button(action: {}, label: {
                                Image("Messanger")
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 23, height: 23)
                                    .padding(4)
                                    .foregroundColor(.black)
                            })
                            
                            Spacer()
                            
                            Button(action: {}, label: {
                                Image("Save")
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 23, height: 23)
                                    .padding(4)
                                    .foregroundColor(.black)
                            })
                            
                            Spacer()
                                .frame(width: 15)
                        }
                            .frame(height: 50), alignment: .bottom)
                } else {
                    VStack {
                        ProgressView()
                    }.frame(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.width / 4) * 5 + 100)
                        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: (UIScreen.main.bounds.width / 4) * 5 + 100)
                }
            }
        }
        .scaledToFit()
        .onAppear(perform: {
            if self.firstLoading == true {
                imagePageViewModel.listFile(path: path)
                self.firstLoading.toggle()
            }
            
        })
        .onReceive(imagePageViewModel.$isListingFile, perform: {
            if !$0 {
                self.isLoading = false
            } else {
                self.isLoading = true
            }
        })
    }
}
