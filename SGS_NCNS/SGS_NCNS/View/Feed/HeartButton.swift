//
//  HeartButton.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/14.
//

import SwiftUI

struct HeartButton: View {
    @Binding var isLiked: Bool
    var body: some View {
        Button(action: {
            self.isLiked.toggle()
        }, label: {
            Image(systemName: isLiked ? "heart.fill" : "heart")
                .resizable()
                .scaledToFill()
                .frame(width: 23, height: 23)
                .padding(4)
                .font(.system(size: 23,weight: .light))
                .foregroundColor(isLiked ? Color("FeedLikeColor") : .black)
        })
    }
}

struct HeartButton_Previews: PreviewProvider {
    static var previews: some View {
        HeartButton(isLiked: .constant(false))
    }
}
