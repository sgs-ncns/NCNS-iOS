//
//  UserCell.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/14.
//

import SwiftUI

struct UserCell: View {
    var body: some View {
        HStack {
            Image("Exprofile_reflect")
                .resizable()
                .scaledToFill()
                .frame(width: 64, height: 64)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text("User")
                    .font(.system(size: 13, weight: .semibold))
                Text("informantion")
                    .font(.system(size: 13))
            }
            Spacer()
        }
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell()
    }
}
