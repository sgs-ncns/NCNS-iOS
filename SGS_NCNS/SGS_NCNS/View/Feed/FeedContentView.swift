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
    var body: some View {
        if !viewMore {
            // 더 보기 누르기 전 뷰
            FeedContentFilterView(vm: FeedContentViewModel("한상혁 스마일 데브 캠프 #데브캠프 @한상혁 #가나다 @한상혁 데브데브캠프 캠프 #데브캠프 @한상혁 #가나다 @한상혁 한상혁 스마일 데브 캠프 #데브캠프 @한상혁 #가나다 @한상혁"), height: $height)

        } else {
            // 더 보기 눌렀을 때 뷰
            FeedContentFilterView(vm: FeedContentViewModel("한상혁 스마일 데브 캠프 #데브캠프 @한상혁 #가나다 @한상혁 데브데브캠프 캠프 #데브캠프 @한상혁 #가나다 @한상혁 한상혁 스마일 데브 캠프 #데브캠프 @한상혁 #가나다 @한상혁"), height: $height)

        }
    }
}

struct FeedContentView_Previews: PreviewProvider {
    static var previews: some View {
        FeedContentView(viewMore: .constant(false))
    }
}
