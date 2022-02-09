//
//  ProfileHeaderView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/14.
//

import SwiftUI

struct ProfileHeaderView: View {
    
    @EnvironmentObject var isCurrentUser: MySettings
    
    // 목업으로 팔로우 안한걸로 체크 -> 나중에 빼기
    @State var isFollowed = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                ZStack {
                    LinearGradient(gradient: .init(colors: [Color("StoryColorTop"), Color("StoryColorMid"), Color("StoryColorBottom")]), startPoint: .topTrailing, endPoint: .bottomLeading)
                        .mask(Image(systemName: "circle").font(.system(size: 100, weight: .ultraLight)))
                        .frame(width: 96, height: 96)
                    Image("Exprofile_reflect")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 86, height: 86)
                        .clipShape(Circle())
                        
                }.padding(.leading, 11)
                
                
                Spacer()
                HStack(spacing: 16) {
                    UserStateView(value: 1, title: "Post")
                    UserStateView(value: 10, title: "Followers")
                    UserStateView(value: 13, title: "Following")
                }.padding(.trailing, 28)
            }
            
            Text("한상혁")
                .font(.system(size: 13, weight: .semibold))
                .padding([.leading, .top])
            
            Text("information")
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
                            
                        }, label: {
                            Text(isFollowed ? "Following" : "Follow")
                                .font(.system(size: 15, weight: .semibold))
                                .frame(width: 172, height: 29)
                                .foregroundColor(isFollowed ? .black : .white)
                                .background(isFollowed ? Color.white : Color("Follow Color"))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 3)
                                        .stroke(Color.gray, lineWidth: isFollowed ? 1 : 0)
                                )
                        }).cornerRadius(3)
                        if isFollowed {
                            Button(action: {
                                
                            }, label: {
                                Text("KKanbu")
                                    .font(.system(size: 15, weight: .semibold))
                                    .frame(width: 172, height: 29)
                                    .foregroundColor(.black)
                                    .background(Color("KanbuIndicator"))
                                    .cornerRadius(3)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 3)
                                            .stroke(Color.gray, lineWidth: isFollowed ? 1 : 1)
                                    )
                            })
                                .disabled(isFollowed ? false : true)
                        }
                    }
                }
                
                Spacer()
            }.padding(.top, 15)
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView()
            .environmentObject(isCurrentUser)
    }
}
