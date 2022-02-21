//
//  CommentCreateView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/06.
//

import SwiftUI

struct CommentCreateView: View {
    @StateObject var commentCreateViewModel = CommentCreateViewModel()
    @StateObject var notificationPostViewModel = NotificationPostViewModel()
    @State var createCommentComplete = false
    @Binding var text: String
    @Binding var inSearchMode: Bool
    @Binding var isCommentAdd: Bool
    var postId: Int
    var accountId: String
    let placeholder: Text
    let imageName: String
    let kcAccountId = KeyChainUtils().read("login", account: "accountName")!
    
    let emojiList = ["❤️", "🙌", "🔥", "👏", "😢", "😍", "😮", "😂"]
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            HStack {
                ForEach(emojiList, id: \.self) { item in
                    Button(action: {
                        text += "\(item)"
                    }, label: {
                        Text("\(item)")
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 25))
                    })
                }
            }
            .padding([.top, .leading, .trailing], 10)
            
            HStack {
                Image(imageName)
                    .resizable()
                    .frame(width: 44, height: 44)
                    .clipShape(Circle())
                    .padding(.leading, 10)
                
                ZStack(alignment: .leading){
                    if text.isEmpty {
                        placeholder
                            .font(.system(size: 14))
                            .foregroundColor(Color(.init(white: 0, alpha: 0.3)))
                            .padding(.leading, 18)
                    }
                    ZStack(alignment: .trailing) {
                        TextField("", text: $text, onEditingChanged: { (editingChanged) in
                            if editingChanged {
                                self.inSearchMode = true
                            } else {
                                self.inSearchMode = false
                            }
                        })
                            .frame(height: 44)
                            .padding(EdgeInsets(top: 0, leading: 17, bottom: 0, trailing: 0))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding(.trailing, 10)
                        
                        Button(action: {
                            commentCreateViewModel.requestCreateComment(data: CommentCreateModel(accountName: KeyChainUtils().read("login", account: "accountName")!, content: text, postId: postId))
                            if createCommentComplete {
                                notificationPostViewModel.requsetNotificationPost(data: NotificationPostModel(accountName: self.accountId, postId: self.postId, targetAccountName: self.kcAccountId), category: "comment")
                                isCommentAdd = true
                                text = ""
                            }
                            UIApplication.shared.endEditing()
                        }, label: {
                            Text("게시")
                        })
                            .foregroundColor(!text.isEmpty ? Color("FeedIndicator") : Color("FeedIndicator").opacity(0.5))
                            .opacity(!text.isEmpty || inSearchMode ? 1 : 0)
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.trailing, 24)
                            .disabled(text.isEmpty ? true : false)
                    }
                }
            }.padding([.top, .bottom], 10)
        }
        .onReceive(commentCreateViewModel.$isCommentCreate, perform: {
            if $0 {
                self.createCommentComplete = true
            } else {
                self.createCommentComplete = false
            }
        })
    }
}

struct CommentCreateView_Previews: PreviewProvider {
    static var previews: some View {
        CommentCreateView(text: .constant("가나"),  inSearchMode: .constant(true), isCommentAdd: .constant(false), postId: 0, accountId: "jo", placeholder: Text("댓글 달기..."), imageName: "img6")
    }
}
