//
//  ProfileSubView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/17.
//

import SwiftUI

struct ProfileSubView: View {
    @StateObject var profileViewModel = ProfileViewModel()
    @State private var isFirstLoad = true
    @State var clickedFollowButton = false
    @State var clickedKkanbuButton = false
    @State var clickedUserName: String
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
            if !profileViewModel.isLoading {
                    VStack(spacing: 32) {
                        ProfileHeaderView(clickedUserName: $clickedUserName, clickedUserProfileModel: $profileViewModel.profileModel, clickedFollowButton: $clickedFollowButton, clickedKkanbuButton: $clickedKkanbuButton)
                            .onChange(of: clickedFollowButton) { newValue in
                                profileViewModel.requestFollow(targetId: profileViewModel.profileModel.userId)
                            }
                            .onChange(of: clickedKkanbuButton) { newValue in
                                profileViewModel.requestKkanbu(targetId: profileViewModel.profileModel.userId)
                            }
                        
                        PostGridView()
                            .frame(width: UIScreen.screenWidth)
                    }.padding(.top)
                } else {
                    // 서버와 통신 싱크를 맞추기위해 isLoading을 통한 로딩 인디케이터
                    VStack {
                        ProgressView()
                            .frame(minHeight: geometry.size.height)
                    }
                }
            }
            .frame(width: geometry.size.width)
            .frame(minHeight: geometry.size.height)
        }
        .navigationTitle(clickedUserName)
        .onAppear {
            // 사용자 프로필 조회하기
            self.profileViewModel.requestProfile(accountName: clickedUserName)
            if isFirstLoad{
                
                isFirstLoad = false
            }
        }
    }
}

struct ProfileSubView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSubView(clickedUserName: "aaa")
//            .environmentObject(isCurrentUser)
    }
}
