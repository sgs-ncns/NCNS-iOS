//
//  ProfileSubView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/17.
//

import SwiftUI

struct ProfileSubView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                ProfileHeaderView()
                
                PostGridView()
            }.padding(.top)
        }
    }
}

struct ProfileSubView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSubView()
    }
}
