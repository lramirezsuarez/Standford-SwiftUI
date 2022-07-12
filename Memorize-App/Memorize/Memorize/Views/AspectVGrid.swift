//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Luis Alejandro Ramirez Suarez on 12/07/22.
//

import SwiftUI

struct AspectVGrid<CardItemViewModel, CardItemView>: View where CardItemView: View, CardItemViewModel: Identifiable {
    var items: [CardItemViewModel]
    var aspectRatio: CGFloat
    var content: (CardItemViewModel) -> CardItemView
    
    init(items: [CardItemViewModel], aspectRatio: CGFloat, @ViewBuilder content: @escaping (CardItemViewModel) -> CardItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                let width = widthThatFits(itemCount: items.count, in: geometry.size, itemAspectRatio: aspectRatio)
                LazyVGrid(columns: [gridItem(for: width)], spacing: 0) {
                    ForEach(items) { item in
                        content(item).aspectRatio(aspectRatio, contentMode: .fit)
                        
                    }
                }
                Spacer(minLength: 0)
            }
        }
    }
    
    private func gridItem(for width: CGFloat) -> GridItem {
        GridItem(.adaptive(minimum: width), spacing: 0)
    }
    
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1
        var rowCount = itemCount
        
        repeat {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / itemAspectRatio
            if CGFloat(rowCount) * itemHeight < size.height {
                break
            }
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
        } while columnCount < itemCount
        
        if columnCount > itemCount {
            columnCount = itemCount
        }
        return floor(size.width / CGFloat(columnCount))
    }
    
}

//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
//}
