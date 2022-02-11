//
//  PageView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/05.
//

import SwiftUI
import Kingfisher

struct ImagePageView: View {
    var path: String
    
    init(path: String) {
        self.path = path
    }
    var body: some View {
        LazyHStack {
            PageViewCell(path: path)
        }.scaledToFit()
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePageView(path: "test/")
    }
}

struct PageViewCell: View {
    @StateObject var imagePageViewModel: ImagePageViewModel
    @State var isLiked = false
    // 인디케이터 색 바꾸기
    init(path: String) {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(named: "FeedIndicator")
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(named: "FeedIndicatorReady")
        _imagePageViewModel = StateObject(wrappedValue: ImagePageViewModel(path: path))
    }
    
    var body: some View {
        VStack() {
            if !imagePageViewModel.urls.isEmpty {
                TabView {
                    ForEach(1 ..< imagePageViewModel.urls.count) { i in
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
                        NavigationLink(destination: ProfileSubView()) {
                            VStack {
                                HStack {
                                    Image("img3")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 32, height: 32)
                                        .clipShape(Circle())
                                        .padding(.leading, 10)
                                    
                                    Text("User ID")
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
                        
                        HeartButton(isLiked: $isLiked)
                        
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
                        Text("Loading")
                    }
                    
                
            }
        }
    }
}
