//
//  HashTagView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/02.
//

import SwiftUI

struct HashTagView: View {
    @State var hashtagString: String
    var body: some View {
        Text("\(hashtagString)")
    }
}

struct HashTagView_Previews: PreviewProvider {
    static var previews: some View {
        HashTagView(hashtagString: "hi")
    }
}
