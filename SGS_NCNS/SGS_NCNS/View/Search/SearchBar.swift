//
//  SearchBar.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/10.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var inSearchMode: Bool
    var body: some View {
        HStack {
            TextField("Search", text: $text, onEditingChanged: { (editingChanged) in
                if editingChanged {
                    self.inSearchMode = true
                } else {
//                    self.inSearchMode = false
                }
            })
                .submitLabel(.done)
                .onSubmit {
                if !text.isEmpty {
                    print("hi")
                    ProfileSubView(clickedUserName: "\(text)")
                }
            }
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .animation(.easeInOut, value: inSearchMode)
                .overlay(
                    HStack{
                        Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                    }
                )
                
            
            if inSearchMode {
                HStack {
                    NavigationLink(destination: ProfileSubView(clickedUserName: "\(text)"), label: {
                        Text("이동")
                            .disabled(!text.isEmpty)
                            .transition(AnyTransition.move(edge: .trailing))
                            .animation(.easeInOut)
                    })
                    Button(action: {
                        inSearchMode = false
                        text = ""
                        UIApplication.shared.endEditing()
                    }, label: {
                        Text("취소")
                        
                        })
                        
                
                }
                
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""), inSearchMode: .constant(false))
    }
}
