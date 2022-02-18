//
//  FeedDetailView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/16.
//

import SwiftUI

struct FeedDetailView: View {
    var body: some View {
        ScrollView {
            VStack {
                FeedDetailCell()
                FeedDetailCell()
                FeedDetailCell()
            }
        }
        
    }
}

struct FeedDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FeedDetailView()
    }
}
