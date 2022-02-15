//
//  FollowCheckView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/14.
//

import SwiftUI

struct FollowCheckView: View {
    @EnvironmentObject var isCurrentUser: MySettings
    
    var body: some View {
        if isCurrentUser.checkUser.isMe {
            Text("깐부 보여줌")
        } else {
            Text("깐부 안보여줘")
        }
    }
}

struct FollowCheckView_Previews: PreviewProvider {
    static var previews: some View {
        FollowCheckView()
    }
}
