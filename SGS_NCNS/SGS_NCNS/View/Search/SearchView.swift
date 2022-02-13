//
//  SearchView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/06.
//

import SwiftUI

/*
 검색 화면을 보여주는 뷰 입니다.
 검색바가 Focus되지 않으면 추천 피드를 보여주고, Focus되어있으면 TabView.swift에서 만든 커스텀 탭뷰를 불러옵니다.
 자연스러운 애니메이션 처리를 위해 현재 눌러진 탭, 전에 눌렀던 탭을 기록해 비교해서 처리합니다.
 
 */

struct SearchView: View {
    @State private var tabs = ["인기", "계정", "태그"]
    @State private var selectedTab = 0
    @State private var preSelection = 0
    @State var searchText = ""
    @State var inSearchMode = false
    var body: some View {
        NavigationView {
            VStack(spacing:0) {
                SearchBar(text: $searchText, inSearchMode: $inSearchMode)
                    .padding([.leading, .trailing], 15)
                    .padding(.bottom, 10)
                if inSearchMode {
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
                }
                GeometryReader { geometry in
                    ScrollView {
                        if inSearchMode {
                            if selectedTab == 0 {
                                PopularListView()
                                    .padding(.top, 10)
                                    .transition(.asymmetric(insertion: AnyTransition.move(edge: .leading), removal: AnyTransition.move(edge: .trailing)))
                            } else if selectedTab == 1 {
                                UserListView()
                                    .padding(.top, 10)
                                    .transition( (preSelection != 0) ? .asymmetric(insertion: AnyTransition.move(edge: .leading), removal: AnyTransition.move(edge: .trailing)) : .asymmetric(insertion: AnyTransition.move(edge: .trailing), removal: AnyTransition.move(edge: .leading)) )
                            } else if selectedTab == 2 {
                                TagListView()
                                    .padding(.top, 10)
                                    .transition(.asymmetric(insertion: AnyTransition.move(edge: .trailing), removal: AnyTransition.move(edge: .leading)))
                            } else {
                                var _ = print("잘못된 탭 클릭입니다.")
                            }
                        } else {
                            RecommandGridView()
                                .transition(AnyTransition.opacity.animation(.easeInOut))
                        }
                    }
                    .transition(AnyTransition.opacity.animation(.easeInOut))
                    .animation(.easeIn, value: selectedTab)
                    .padding(.top, 1)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarHidden(true)
                    .frame(height: geometry.size.height)
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
