//
//  FeedContentView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/10.
//

import SwiftUI

struct FeedContentView: View {
    @State private var height: CGFloat = 0
    @Binding var viewMore: Bool
    var feedContent: String
    var accountName: String
    var body: some View {
        if !viewMore {
            // 더 보기 누르기 전 뷰
            FeedContentFilterView(vm: FeedContentViewModel(feedContent, user: accountName), height: $height)

        } else {
            // 더 보기 눌렀을 때 뷰
            FeedContentFilterView(vm: FeedContentViewModel(feedContent, user: accountName), height: $height)

        }
    }
}

struct FeedContentView_Previews: PreviewProvider {
    static var previews: some View {
        FeedContentView(viewMore: .constant(false), feedContent: "tmp", accountName: "contea95")
    }
}
