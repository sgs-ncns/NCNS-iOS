//
//  FeedContentView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/10.
//

import SwiftUI

struct FeedContentView: View {
    @Binding var viewMore: Bool
    var body: some View {
        if !viewMore {
            // 더 보기 누르기 전 뷰
            HStack {
                { Text("batman")
                    .font(.system(size: 15, weight: .semibold)) +
                Text(" All men have limits. They learn what they are and not to exceed them. I ignore mine.")
                }()
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 15))
                Text("더 보기")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
            }
            
        } else {
            // 더 보기 눌렀을 때 뷰
            { Text("batman")
                .font(.system(size: 15, weight: .semibold)) +
            Text(" All men have limits. They learn what they are and not to exceed them. I ignore mine.")
            }()
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .font(.system(size: 15))
        }
        
    }
}

struct FeedContentView_Previews: PreviewProvider {
    static var previews: some View {
        FeedContentView(viewMore: .constant(false))
    }
}
