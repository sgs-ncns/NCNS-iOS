//
//  ProfileActionButtonView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/14.
//

import SwiftUI

struct ProfileActionButtonView: View {

    @EnvironmentObject var isCurrentUser: MySettings
    
    // 목업으로 팔로우 안한걸로 체크 -> 나중에 빼기
    var isFollowed = false
    
    var body: some View {
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
                
                Button(action: {
                    
                }, label: {
                    Text("Etc")
                        .font(.system(size: 15, weight: .semibold))
                        .frame(width: 172, height: 29)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                })
            }
        }
    }
}

struct ProfileActionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileActionButtonView()
            .environmentObject(isCurrentUser)
    }
}
