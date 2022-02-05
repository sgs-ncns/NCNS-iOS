//
//  SearchView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/06.
//

import SwiftUI

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
                    }
                }
                GeometryReader { geometry in
                    ScrollView {
                        if inSearchMode {
                            if selectedTab == 0 {
                                PopularListView()
                                    .transition(.asymmetric(insertion: AnyTransition.move(edge: .leading), removal: AnyTransition.move(edge: .trailing)))
                            } else if selectedTab == 1 {
                                UserListView()
                                    .transition( (preSelection != 0) ? .asymmetric(insertion: AnyTransition.move(edge: .leading), removal: AnyTransition.move(edge: .trailing)) : .asymmetric(insertion: AnyTransition.move(edge: .trailing), removal: AnyTransition.move(edge: .leading)) )
                            } else if selectedTab == 2 {
                                TagListView()
                                    .transition(.asymmetric(insertion: AnyTransition.move(edge: .trailing), removal: AnyTransition.move(edge: .leading)))
                            } else {
                                var _ = print("잘못된 탭 클릭입니다.")
                            }
                            
                        } else {
                            RecommandGridView()
                        }
                    }
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
