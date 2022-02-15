//
//  NotificationView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/06.
//

import SwiftUI

struct NotificationsView: View {
    @State private var tabs = ["깐부 알림", "일반 알림"]
    @State private var selectedTab = 0
    @State private var preSelection = 0
    @State private var isFirstLoad = true
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    TabsView(tabs: $tabs, preSelection: $preSelection, selection: $selectedTab, underlineColor: .black) { title, isSelected in
                        Text(title.uppercased())
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(isSelected ? .black : .gray)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }.padding(.bottom, 0)
                    
                    Divider()
                        .padding(0)
                }.transition(AnyTransition.opacity.animation(.easeInOut))
                    .animation(.easeIn, value: selectedTab)
                
                GeometryReader { geometry in
                    ScrollView {
                        if selectedTab == 0 {
                            KKanbuNotificationsView()
                                .padding(.top, 10)
                                .transition(.asymmetric(insertion: AnyTransition.move(edge: .leading), removal: AnyTransition.move(edge: .trailing)))
                        } else if selectedTab == 1 {
                            NormalNotificationsView()
                                .padding(.top, 10)
                                .transition(.asymmetric(insertion: AnyTransition.move(edge: .trailing), removal: AnyTransition.move(edge: .leading)))
                        } else {
                            var _ = print("잘못된 탭 클릭입니다.")
                        }
                    }
                    .transition(AnyTransition.opacity.animation(.easeInOut))
                    .animation(.easeIn, value: selectedTab)
                    .padding(.top, 1)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
            
            
            .navigationTitle("활동")
            .padding(0.0)
            .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(StackNavigationViewStyle())
            .onAppear {
                if isFirstLoad{
                    var _ = print("NotificationView Appear")
                    isFirstLoad = false
                }
            }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
