//
//  HashTagView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/02.
//

import SwiftUI

struct HashTagView: View {
    @State var hashtagString: String
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    ZStack {
                        Circle()
                            .mask(Image(systemName: "circle").font(.system(size: 70, weight: .ultraLight)))
                            .foregroundColor(.gray)
                            .frame(width: 64, height: 64)
                        Image("hashtag_default")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                    Spacer()
                    
                    VStack(spacing: 5) {
                        Text("1300")
                            .font(.system(size: 13, weight: .semibold)) +
                        Text(" 게시물")
                            .font(.system(size: 13))
                        
                        Text("매주 게시물을 확인해보세요")
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                    }.padding(.trailing, 30)
                }
                .padding([.top, .bottom], 10)
                .padding([.leading, .trailing], 30)
                
                Divider()
                    .frame(height: 1)
                    .background(Color(.systemGray6))
                
                RecommandGridView()
            }
            .navigationTitle("#\(hashtagString)")
        }
    }
}

struct HashTagView_Previews: PreviewProvider {
    static var previews: some View {
        HashTagView(hashtagString: "hi")
    }
}
