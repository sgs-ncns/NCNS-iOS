//
//  UserStateView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/14.
//

import SwiftUI

struct UserStateView: View {
    let value: Int
    let title: String
    
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.system(size: 16, weight: .semibold))
            
            Text(title)
                .font(.system(size: 13))
        }.frame(width: 70, alignment: .center)
    }
}

struct UserStateView_Previews: PreviewProvider {
    static var previews: some View {
        UserStateView(value: 1, title: "Post")
    }
}
