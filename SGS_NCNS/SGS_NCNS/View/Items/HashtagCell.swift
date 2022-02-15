//
//  HashtagCell.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/13.
//

import SwiftUI

struct HashtagCell: View {
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .mask(Image(systemName: "circle").font(.system(size: 64, weight: .ultraLight)))
                    .foregroundColor(.gray)
                    .frame(width: 58, height: 58)
                Image("hashtag_default")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            }
            
            VStack(alignment: .leading) {
                Text("#hashtag")
                    .font(.system(size: 13, weight: .regular))
            }
            Spacer()
        }
    }
}

struct HashtagCell_Previews: PreviewProvider {
    static var previews: some View {
        HashtagCell()
    }
}
