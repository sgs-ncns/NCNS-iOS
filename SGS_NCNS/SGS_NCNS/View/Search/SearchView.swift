//
//  SearchView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/06.
//

import SwiftUI

struct SearchView: View {
    @State var searchText = ""
    @State var inSearchMode = false
    var body: some View {
        ScrollView {
            // search view
            SearchBar(text: $searchText, inSearchMode: $inSearchMode)
                .padding()
            // grid view / userlist view
            if inSearchMode {
                UserListView()
            } else {
                RecommandGridView()
            }
        }.padding(.top, 1)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
