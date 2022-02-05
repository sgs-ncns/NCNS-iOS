//
//  PostGridView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/14.
//

import SwiftUI

struct PostGridView: View {
    // 한 화면에 3개
    private let items = [
        GridItem(.flexible(minimum: 40)),
        GridItem(.flexible(minimum: 40)),
        GridItem(.flexible(minimum: 40)),]
    private let width = (UIScreen.screenWidth - 4) / 3
    
    var body: some View {
        LazyVGrid(columns: items, alignment: .center) {
//            ForEach(model.imageNames, id:\.self) { item in
//                
//            }
//            NavigationLink(destinat ion: <#T##() -> _#>, label: <#T##() -> _#>)
            Image("img1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: width)
                .clipped()
            
            Image("img6")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: width)
                .clipped()
            Image("img2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: width)
                .clipped()
            Image("img3")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: width)
                .clipped()
            Image("img4")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: width)
                .clipped()
            Image("img1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: width)
                .clipped()
            
            Image("img6")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: width)
                .clipped()
            Image("img2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: width)
                .clipped()
            Image("img3")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: width)
                .clipped()
            Image("img4")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: width)
                .clipped()
            
        }
    }
}

struct PostGridView_Previews: PreviewProvider {
    static var previews: some View {
        PostGridView()
    }
}
