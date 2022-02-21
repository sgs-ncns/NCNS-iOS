//
//  CommentView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/19.
//

import SwiftUI

struct CommentView: View {
    @StateObject var commentDetailViewModel =  CommentDetailViewModel()
    @State var commentText = ""
    @State var isSearchMode = false
    @State var commentLoad = false
    @State var isCommentAdd = false
    
    var postId: Int
    var body: some View {
        VStack {
            if commentLoad {
                ScrollView {
                    VStack {
                        // content, user 필요
                        CommentHeaderView(content: commentDetailViewModel.commentLists.content, user: commentDetailViewModel.commentLists.accountName)
                        Divider()
                        
                        if isCommentAdd {
                            CommentCell(content: commentText, user: KeyChainUtils().read("login", account: "accountName")!)
                        }
                        
                        // cell
                        // comment, user
                        if commentDetailViewModel.commentLists.commentList.count != 0 {
                            ForEach(0 ..< commentDetailViewModel.commentLists.commentList.count, id: \.self) { i in
                                CommentCell(content: commentDetailViewModel.commentLists.commentList[i].content, user: commentDetailViewModel.commentLists.commentList[i].accountName)
                            }
                        } else {
                            ZStack {
                                Text("댓글써주세요")
                                    .padding()
                            }
                            
                        }
                        
                    }
                }
                
                Spacer()
                CommentCreateView(text: $commentText, inSearchMode: $isSearchMode,
                                  isCommentAdd: $isCommentAdd,postId: commentDetailViewModel.commentLists.postId, accountId: commentDetailViewModel.commentLists.accountName, placeholder: Text("댓글 달기..."),  imageName: "img6")
            } else {
                ProgressView()
            }
        }
        .onAppear(perform: {
            commentDetailViewModel.requestPostDetail(postId: self.postId)
        })
        .onReceive(commentDetailViewModel.$isCommentLoading, perform: {
            if !$0 {
                self.commentLoad = true
            }
        })
        .navigationTitle("Comment")
    }
}

