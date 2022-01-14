//
//  UploadPostView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/06.
//

import SwiftUI

struct UploadPostView: View {
    var body: some View {
        NavigationView {
            Text("UploadPost View")

            
            .navigationTitle("UploadPostView")
            .padding(0.0)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct UploadPostView_Previews: PreviewProvider {
    static var previews: some View {
        UploadPostView()
    }
}
