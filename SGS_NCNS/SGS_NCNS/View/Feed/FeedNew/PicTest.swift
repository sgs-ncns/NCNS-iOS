//
//  PicTest.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/16.
//

import SwiftUI

struct PicTest: View {
    var postId: String
    var userId: String
    var accountName: String
    var imagePath: String
    
    var body: some View {
        VStack {
            Text("postId: \(postId)")
                .font(.system(size: 10))
            Text("postId: \(userId)")
                .font(.system(size: 10))
            Text("postId: \(accountName)")
                .font(.system(size: 10))
            Text("postId: \(imagePath)")
                .font(.system(size: 10))
        }
    }
}

struct PicTest_Previews: PreviewProvider {
    static var previews: some View {
        PicTest(postId: "2", userId: "1", accountName: "contea95", imagePath: "920209")
    }
}
