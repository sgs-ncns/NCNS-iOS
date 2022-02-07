//
//  ButtonFlatLinkStyle.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/05.
//

import Foundation
import SwiftUI

struct FlatLinkStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
