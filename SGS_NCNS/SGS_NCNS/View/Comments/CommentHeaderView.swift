//
//  CommentHeaderView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/31.
//

import SwiftUI

struct CommentHeaderView: View {
    @State private var height: CGFloat = 0
    var content: String
    var user: String
    
    var body: some View {
        HStack(alignment: .top) {
            Image("Exprofile_aim")
                .resizable()
                .frame(width: 32, height: 32)
                .clipShape(Circle())
                .padding(.leading, 10)
            
            VStack (alignment: .leading, spacing: 0) {
                CommentContentFilterView(vm: CommentViewModel(content, user: user), height: $height)
            }
        }.padding([.leading, .trailing], 5)
    }
}

struct CommentHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CommentHeaderView(content: "test", user: "123")
    }
}
