//
//  ProfileView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/06.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 32) {
                    ProfileHeaderView()
                    
                    PostGridView()
                }.padding(.top)
            }
            
            .navigationTitle("User")
            .padding(0.0)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
