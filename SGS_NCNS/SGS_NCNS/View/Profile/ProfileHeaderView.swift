//
//  ProfileHeaderView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/14.
//

import SwiftUI

struct ProfileHeaderView: View {
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
                
                ProfileActionButtonView()
                
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
