//
//  UserCell.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/14.
//

import SwiftUI

struct UserCell: View {
    var accountName: String = "test1"
    var nickname: String = "test123"
    var body: some View {
        HStack {
            Image("user_default")
                .resizable()
                .scaledToFill()
                .frame(width: 64, height: 64)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(accountName)
                    .font(.system(size: 13, weight: .semibold))
                Text(nickname)
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
