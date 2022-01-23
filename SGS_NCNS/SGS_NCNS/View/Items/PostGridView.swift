//
//  PostGridView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/14.
//

import SwiftUI

struct PostGridView: View {
    // 한 화면에 3개
    private let items = [GridItem(), GridItem(), GridItem()]
    private let width = UIScreen.screenWidth / 3
    
    var body: some View {
        LazyVGrid(columns: items, spacing: 2, content: {
            ForEach(1 ..< 10) {_ in
                Image("Exprofile_punch")
                    .resizable()
                    .frame(width: width, height: width)
            }
        })
    }
}

struct PostGridView_Previews: PreviewProvider {
    static var previews: some View {
        PostGridView()
    }
}
