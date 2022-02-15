//
//  KkanbuStateView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/13.
//

import SwiftUI

struct KkanbuStateView: View {
    let value: Int
    
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color("KanbuIndicator"))
            
            Text("Kkanbu")
                .font(.system(size: 13))
        }.frame(width: 60, alignment: .center)
    }
}

struct KkanbuStateView_Previews: PreviewProvider {
    static var previews: some View {
        KkanbuStateView(value: 2)
    }
}
