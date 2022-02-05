//
//  TabsView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/04.
//

import SwiftUI

struct TabsView<Label: View>: View {
    @Binding var tabs: [String] // tab title
    @Binding var preSelection: Int
    @Binding var selection: Int // Current selected tab
    let underlineColor: Color
    let label: (String, Bool) -> Label
    
    var body: some View {
        // Pack the tabs horizontally and allow them to be scrolled
        HStack(spacing: 0) {
            ForEach(tabs, id: \.self) { eachTab in
                GeometryReader { geometry in
                    self.tab(title: eachTab)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }.frame(height: 30)
            }
        }.padding(.horizontal, 3)
    }
    
    private func tab(title: String) -> some View {
        let index = self.tabs.firstIndex(of: title)!
        let isSelected = index == selection
        return Button(action: {
            withAnimation {
                self.preSelection = self.selection
                self.selection = index
            }
        }) {
            label(title, isSelected)
                .overlay(Rectangle()
                            .frame(height: 1)
                            .foregroundColor(isSelected ? underlineColor : .clear)
                            .padding(.top, 2)
                            .transition(.move(edge: .trailing)), alignment: .bottomLeading
                )
                
        }
    }
}

