//
//  FeedCell.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/06.
//

import SwiftUI

struct FeedCell: View {
    @State var viewMore = false
    @State var isLiked = false
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // profile
            HStack {
                Image("Exprofile_aim")
                    .resizable()
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
            .frame(height: 54)
            
            Divider()
                .frame(height: 1)
                .background(Color(.systemGray6))
            
            // feed
            Image("Exprofile_reflect")
                .resizable()
                .scaledToFill()
                .frame(maxHeight: 440)
                .clipped()
            
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
            .frame(height: 50)
            
            // Like
            HStack {
                Text("3 Like")
                    .font(.system(size: 13, weight: .semibold))
                    .onTapGesture {
                        print("click like")
                    }
            }
            .padding(.leading, 15)
            .padding(.bottom, 5)
            
            // comment
            ZStack (alignment: .topLeading) {
                Button(action: {
                    self.viewMore = true
                }, label: {
                    FeedContentView(viewMore: $viewMore)
                })
                    .foregroundColor(.black)
                
            }
            .padding([.leading, .trailing], 15)
            
            NavigationLink(destination: CommentView(), label: {
                Text("댓글 ~개 모두 보기")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }).padding([.leading, .trailing], 15)
                .padding([.top, .bottom], 5)
            
            Text("22시간 전")
                .font(.system(size: 13))
                .foregroundColor(.gray)
                .padding([.leading, .trailing], 15)
                .padding([.top, .bottom], 5)
        }
    }
}

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        FeedCell()
    }
}
