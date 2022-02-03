//
//  CommentView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/19.
//

import SwiftUI

struct CommentView: View {
    var body: some View {
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
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView()
    }
}
