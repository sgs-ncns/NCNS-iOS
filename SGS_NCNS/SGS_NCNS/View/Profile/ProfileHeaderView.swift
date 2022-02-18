//
//  ProfileHeaderView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/14.
//

import SwiftUI

struct ProfileHeaderView: View {
    
    @EnvironmentObject var isCurrentUser: MySettings
    @Binding var clickedUserName: String
    @Binding var clickedUserProfileModel: ProfileModel
    @Binding var clickedFollowButton: Bool
    @Binding var clickedKkanbuButton: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                ZStack {
                    LinearGradient(gradient: .init(colors: [Color("StoryColorTop"), Color("StoryColorMid"), Color("StoryColorBottom")]), startPoint: .topTrailing, endPoint: .bottomLeading)
                        .mask(Image(systemName: "circle").font(.system(size: 100, weight: .ultraLight)))
                        .frame(width: 96, height: 96)
                    Image("user_default")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 86, height: 86)
                        .clipShape(Circle())
                    
                }.padding(.leading, 11)
                
                
                Spacer()
                HStack(spacing: self.isCurrentUser.checkUser.isMe ? 0 : 16) {
                    // 유저 포스트 수
                    UserStateView(value: clickedUserProfileModel.postCount, title: "Post")
                        .frame(width: 50)
                    if self.isCurrentUser.checkUser.isMe {
                        // 자신일 때 유저 깐부 수
                        NavigationLink(destination: FollowCheckView(selectedTab: 0, selectedTabOthers: 0, isMe: isCurrentUser.checkUser.isMe, clickedUserId: clickedUserProfileModel.userId)) {
                            KkanbuStateView(value: clickedUserProfileModel.subscribingCount ?? 0)
                        }
                        .buttonStyle(.plain)
                        .disabled(clickedUserProfileModel.subscribingCount == 0)
                    }
                    // 팔로워 수
                    NavigationLink(destination: FollowCheckView(selectedTab: 1, selectedTabOthers: 0, isMe: isCurrentUser.checkUser.isMe, clickedUserId: clickedUserProfileModel.userId)) {
                        UserStateView(value: clickedUserProfileModel.followerCount, title: "Followers")
                    }
                    .buttonStyle(.plain)
                    .disabled(clickedUserProfileModel.followerCount == 0)
                    // 팔로잉 수
                    NavigationLink(destination: FollowCheckView(selectedTab: 2, selectedTabOthers: 1, isMe: isCurrentUser.checkUser.isMe, clickedUserId: clickedUserProfileModel.userId)) {
                        UserStateView(value: clickedUserProfileModel.followingCount, title: "Following")
                    }
                    .buttonStyle(.plain)
                    .disabled(clickedUserProfileModel.followingCount == 0)
                    
                }.padding(.trailing, self.isCurrentUser.checkUser.isMe ? 7 : 28)
            }
            
            Text(clickedUserProfileModel.nickname)
                .font(.system(size: 13, weight: .semibold))
                .padding([.leading, .top])
            
            Text(clickedUserProfileModel.introduce ?? "<< Please Add Your Introduce >>")
                .font(.system(size: 13))
                .padding(.leading)
                .padding(.top, 1)
            
            HStack {
                Spacer()
                
                if self.isCurrentUser.checkUser.isMe {
                    // 현재 유저면 Edit Profile
                    Button(action: {
                        
                    }, label: {
                        Text("Edit Profile")
                            .font(.system(size: 15, weight: .semibold))
                            .frame(width: 343, height: 29)
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 3)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    })
                } else {
                    // 다른사람 팔로우 or 다른 버튼
                    HStack {
                        Button(action: {
                            self.clickedFollowButton.toggle()
                        }, label: {
                            Text(clickedUserProfileModel.followStatus ?? false ? "Following" : "Follow")
                                .font(.system(size: 15, weight: .semibold))
                                .frame(width: 172, height: 29)
                                .foregroundColor(clickedUserProfileModel.followStatus ?? false ? .black : .white)
                                .background(clickedUserProfileModel.followStatus ?? false ? Color.white : Color("Follow Color"))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 3)
                                        .stroke(Color.gray, lineWidth: clickedUserProfileModel.followStatus ?? false ? 1 : 0)
                                )
                        }).cornerRadius(3)
                        if clickedUserProfileModel.followStatus ?? false {
                            Button(action: {
                                self.clickedKkanbuButton.toggle()
                            }, label: {
                                Text(clickedUserProfileModel.subscribeStatus ?? false ? "Kkanbuing" :  "Kkanbu")
                                    .font(.system(size: 15, weight: .semibold))
                                    .frame(width: 172, height: 29)
                                    .foregroundColor(.black)
                                    .background(clickedUserProfileModel.subscribeStatus ?? false ? .white : Color("KanbuIndicator"))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 3)
                                            .stroke(Color.gray, lineWidth: clickedUserProfileModel.subscribeStatus ?? false ? 1 : 1)
                                    )
                            }).cornerRadius(3)
                        }
                    }
                }
                
                Spacer()
            }.padding(.top, 15)
        }
        .onAppear {
            let kc = KeyChainUtils()
            if self.clickedUserName == kc.read("login", account: "accountName")! {
                isCurrentUser.checkUser.isMe = true
            } else {
                isCurrentUser.checkUser.isMe = false
            }
        }
    }
}

//struct ProfileHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileHeaderView(clickedUserName: .constant("User"))
//            .environmentObject(isCurrentUser)
//    }
//}
