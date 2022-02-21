//
//  PostGridView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/13.
//

import SwiftUI

struct RecommandGridView: View {
    // 한 화면에 3개
    private let items = [GridItem(), GridItem(), GridItem()]
    private let width = UIScreen.screenWidth / 3
    
    var body: some View {
        LazyVGrid(columns: items, spacing: 2, content: {
            ForEach(0 ..< 1) {_ in
                Image("Exprofile_aim")
                    .resizable()
                    .frame(width: width, height: width)
            }
        })
    }
}

struct RecommandGridView_Previews: PreviewProvider {
    static var previews: some View {
        RecommandGridView()
    }
}
