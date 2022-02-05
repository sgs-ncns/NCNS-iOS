//
//  FeedView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/06.
//

import SwiftUI

struct FeedView: View {
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(1 ..< 10) { _ in
                        FeedCell()
                    }
                }
            }
            .navigationTitle("")
            .padding(0.0)
            .navigationBarItems(leading:Image("IGlogo"))
            .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
