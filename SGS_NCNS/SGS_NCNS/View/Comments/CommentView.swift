//
//  CommentView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/19.
//

import SwiftUI

struct CommentView: View {
    @State var commentText = ""
    @State var isSearchMode = false
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    CommentHeaderView()
                    Divider()
                    
                    /// cell

                    CommentCell()
                    CommentCell()
                    CommentCell()
                    CommentCell()
                    CommentCell()
                }
            }
            
            Spacer()
            CommentCreateView(text: $commentText, inSearchMode: $isSearchMode, placeholder: Text("댓글 달기..."), imageName: "img6")
                
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView()
    }
}

