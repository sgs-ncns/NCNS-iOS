//
//  FeedCell.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/06.
//

import SwiftUI

struct FeedCell: View {
    @State var viewMore = false
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // profile
            HStack {
                Image("Exprofile_aim")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())
                    .padding(.leading, 10)
                
                
                Text("User")
                    .font(.system(size: 15, weight: .semibold))
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
                
                Button(action: {}, label: {
                    Image("Heart")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 23, height: 23)
                        .padding(4)
                })
                
                Button(action: {}, label: {
                    Image("Comment")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 23, height: 23)
                        .padding(4)
                })
                
                Button(action: {}, label: {
                    Image("Messanger")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 23, height: 23)
                        .padding(4)
                })
                
                Spacer()
                
                Button(action: {}, label: {
                    Image("Save")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 23, height: 23)
                        .padding(4)
                })
                
                Spacer()
                    .frame(width: 15)
            }
            .frame(height: 50)
            .foregroundColor(.black)
            
            // Like
            HStack {
                Text("3 Like")
                    .font(.system(size: 14, weight: .semibold))
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
                
                Text("batman")
                    .font(.system(size: 15, weight: .semibold))
                    .onTapGesture {
                        print("click user")
                    }
            }
            .padding([.leading, .trailing], 15)
        }
    }
}

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        FeedCell()
    }
}
