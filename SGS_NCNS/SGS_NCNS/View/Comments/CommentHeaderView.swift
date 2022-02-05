//
//  CommentHeaderView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/31.
//

import SwiftUI

struct CommentHeaderView: View {
    @State private var height: CGFloat = 0
    
    var body: some View {
        HStack(alignment: .top) {
            Image("Exprofile_aim")
                .resizable()
                .frame(width: 32, height: 32)
                .clipShape(Circle())
                .padding(.leading, 10)
            
            VStack (alignment: .leading, spacing: 0) {
                CommentContentFilterView(vm: CommentViewModel("한상혁 스마일 데브 캠프 #데브캠프 @한상혁 #가나다 @한상혁 데브데브캠프 캠프 #데브캠프 @한상혁 #가나다 @한상혁 한상혁 스마일 데브 캠프 #데브캠프 @한상혁 #가나다 @한상혁", user: "han"), height: $height)
//                    .frame(minWidth: UIScreen.screenWidth - 42)
                
                Text("22시간 전")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
//                    .padding([.leading, .trailing], 10)
                    .padding([.top, .bottom], 5)
            }
        }.padding([.leading, .trailing], 5)
    }
}

struct CommentHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CommentHeaderView()
    }
}
