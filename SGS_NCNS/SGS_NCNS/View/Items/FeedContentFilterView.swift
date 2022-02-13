//
//  ContentFilterView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/03.
//

import SwiftUI

struct FeedContentFilterView: View {
    @StateObject var vm: FeedContentViewModel
    @Binding var height: CGFloat
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack(alignment: .topLeading) {
                    zStackViews(geometry)
                }
                .background(calculateHeight($height))
            }
        }.frame(height: height)
    }
    
    // ZStack에서의 모든 뷰의 alignment를 결정
    func zStackViews(_ geometry: GeometryProxy) -> some View {
        // 현재 수평 및 수직 위치를 추적하는 데 사용
        // ZStack에서 새 텍스트나 링크가 추가되면 가로가 줄어들게 설정
        // 새로운 라인이 필요할 때 수직은 감소하고 수평은 0으로 재설정
        var horizontal: CGFloat = 0
        var vertical: CGFloat = 0
        
        // View에 주어진 인덱스에 맞게 alignment를 결정
        func forEachView(_ index: Int) -> some View {
            var numberOfViewsInContent: Int
            let view: AnyView
            
            
            // 주어진 인덱스에 맞는 뷰의 컨텐츠 개수 결정
            switch vm.feedContent[index] {
            case .user(let text):
                numberOfViewsInContent = 1
                view = AnyView(text)
            case .hashtag(let link):
                numberOfViewsInContent = 1
                view = AnyView(link)
            case .humantag(let link):
                numberOfViewsInContent = 1
                view = AnyView(link)
            case .content(let text):
                numberOfViewsInContent = 1
                view = AnyView(text)
            }
            
            var numberOfViewsRendered = 0
            
            return view
                .alignmentGuide(.leading, computeValue: { dimension in
                    numberOfViewsRendered += 1
                    
                    // 만약 zStack 안의 한 라인의 width가 zStack보다 커진다면
                    let viewShouldBePlacedOnNextLine = geometry.size.width < -1 * ( horizontal - dimension.width)
                    if viewShouldBePlacedOnNextLine {
                        // 뷰를 다음 라인으로 보낸다
                        vertical -= dimension.height
                        horizontal = -dimension.width
                        return 0
                        
                    }
                    
                    let result = horizontal
                    
                    // horizontal 좌표를 현재 뷰 끝에 설정
                    horizontal -= dimension.width
                    
                    return result
                })
                .alignmentGuide(.top, computeValue: { _ in
                    let result = vertical
                    
                    // 마지막 뷰일 때
                    let isLastView = index == vm.feedContent.indices.last && numberOfViewsRendered == numberOfViewsInContent
                    //                    if !viewMore
                    if isLastView {
                        vertical = 0
                        horizontal = 0
                        numberOfViewsRendered = 0
                    }
                    
                    return result
                })
        }
        
        return ForEach(vm.feedContent.indices, content: forEachView)
    }
    
    func calculateHeight(_ binding: Binding<CGFloat>) -> some View {
        GeometryReader { geometry -> Color in
            DispatchQueue.main.async {
                binding.wrappedValue = geometry.frame(in: .local).height
            }
            
            return .clear
        }
    }
    
}
//
//struct ContentFilterView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentFilterView()
//    }
//}
