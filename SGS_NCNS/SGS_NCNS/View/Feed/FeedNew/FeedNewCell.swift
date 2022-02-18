//
//  FeedNewCell.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/16.
//

import SwiftUI

struct FeedNewCell: View {
    var body: some View {
        HStack {
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
                
                Text("AccountId")
                    .font(.system(size: 13, weight: .semibold))
            }
            .padding(.leading, 11)
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 40) {
                    NavigationLink(destination: {
                        FeedDetailView()
                    }, label: {
                        PicTest(postId: "1", userId: "123", accountName: "contea95", imagePath: "/hi")
                    }).buttonStyle(.plain)
                    NavigationLink(destination: {
                        FeedDetailView()
                    }, label: {
                        PicTest(postId: "1", userId: "123", accountName: "contea95", imagePath: "/hi")
                    }).buttonStyle(.plain)
                    NavigationLink(destination: {
                        FeedDetailView()
                    }, label: {
                        PicTest(postId: "1", userId: "123", accountName: "contea95", imagePath: "/hi")
                    }).buttonStyle(.plain)
                }
            }.padding(.trailing, 11)
        }
        .frame(height: UIScreen.screenWidth / 3)
    }
}

struct FeedNewCell_Previews: PreviewProvider {
    static var previews: some View {
        FeedNewCell()
    }
}
