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
            TextField("Search", text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack{
                        Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                    }
                )
                .onTapGesture {
                    self.inSearchMode = true
                }
                .transition(.move(edge: .trailing))
                .animation(.easeIn)
            
            if inSearchMode {
                Button(action: {
                    inSearchMode = false
                    text = ""
                    UIApplication.shared.endEditing()
                }, label: {
                    Text("Cancel")
                        .foregroundColor(.black)
                })
                    .transition(.move(edge: .trailing))
                    .animation(.easeIn)
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""), inSearchMode: .constant(true))
    }
}
