//
//  FollowCheckView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/14.
//

import SwiftUI

struct FollowCheckView: View {
    @StateObject var followcheckViewModel = FollowCheckViewModel()
    @State private var tabsContainKkanbu = ["Kkanbu", "Follower", "Following"]
    @State private var tabsOthers = ["Follower", "Following"]
    @State var selectedTab: Int
    @State private var preSelection = 0
    @State var selectedTabOthers: Int
    @State private var preSelectionOthers = 0
    @State private var isFirstLoad = true
    @State private var isAllListLoad = false
    @State var isMe: Bool
    var clickedUserId: Int
    
    var body: some View {
        VStack(spacing:0) {
            if isAllListLoad {
                VStack(spacing: 0) {
                    TabsView(tabs: isMe ? $tabsContainKkanbu : $tabsOthers, preSelection: isMe ? $preSelection : $preSelectionOthers, selection: isMe ? $selectedTab : $selectedTabOthers, underlineColor: .black) { title, isSelected in
                        Text(title.uppercased())
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(isSelected ? .black : .gray)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }.padding(.bottom, 0)
                    
                    Divider()
                        .padding(0)
                }.transition(AnyTransition.opacity.animation(.easeInOut))
                    .animation(.easeIn, value: selectedTab)
                GeometryReader { geometry in
                    ScrollView {
                        if isMe {
                            if selectedTab == 0 {
                                KkanbuCheckView(kkanbuCheckModels: followcheckViewModel.kanbuCheckModels)
                                    .padding(.top, 10)
                                    .transition(.asymmetric(insertion: AnyTransition.move(edge: .leading), removal: AnyTransition.move(edge: .trailing)))
                            } else if selectedTab == 1 {
                                FollowersCheckView(followersCheckModels: followcheckViewModel.followersCheckModels)
                                    .padding(.top, 10)
                                    .transition( (preSelection != 0) ? .asymmetric(insertion: AnyTransition.move(edge: .leading), removal: AnyTransition.move(edge: .trailing)) : .asymmetric(insertion: AnyTransition.move(edge: .trailing), removal: AnyTransition.move(edge: .leading)) )
                            } else if selectedTab == 2 {
                                FollowingCheckView(followingCheckModels: followcheckViewModel.followingCheckModels)
                                    .padding(.top, 10)
                                    .transition(.asymmetric(insertion: AnyTransition.move(edge: .trailing), removal: AnyTransition.move(edge: .leading)))
                            } else {
                                var _ = print("잘못된 탭 클릭입니다.")
                            }
                        } else {
                            if selectedTabOthers == 0 {
                                FollowersCheckView(followersCheckModels: followcheckViewModel.followersCheckModels)
                                    .padding(.top, 10)
                                    .transition(.asymmetric(insertion: AnyTransition.move(edge: .leading), removal: AnyTransition.move(edge: .trailing)))
                            } else if selectedTabOthers == 1 {
                                FollowingCheckView(followingCheckModels: followcheckViewModel.followingCheckModels)
                                    .padding(.top, 10)
                                    .transition(.asymmetric(insertion: AnyTransition.move(edge: .trailing), removal: AnyTransition.move(edge: .leading)))
                            } else {
                                var _ = print("잘못된 탭 클릭입니다.")
                            }
                        }
                    }
                    .transition(AnyTransition.opacity.animation(.easeInOut))
                    .animation(.easeIn, value: selectedTab)
                    .padding(.top, 1)
                    .navigationBarTitleDisplayMode(.inline)
//                    .frame(height: geometry.size.height)
                }
            } else {
                ProgressView()
            }
            
        }
        .onAppear {
            // 팔로우 목록 조회
            if isFirstLoad{
                self.followcheckViewModel.requestFollowersList(userId: clickedUserId)
                self.followcheckViewModel.requestFollowingList(userId: clickedUserId)
                self.followcheckViewModel.requestKkanbusList()
                
                isFirstLoad = false
            }
        }
        .onReceive(self.followcheckViewModel.isLoadingComplete, perform: {
            self.isAllListLoad = $0
        })
    }
}
