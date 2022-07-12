//
//  BoardView.swift
//  Memorize
//
//  Created by Luis Alejandro Ramirez Suarez on 7/07/22.
//

import SwiftUI

struct BoardView: View {
    @ObservedObject var memoryGameViewModel: MemoryGameViewModel
    
    
    
    var body: some View {
//        VStack {
//            ScrollView {
//                LazyVGrid(columns: gridItems, spacing: 10) {
//                    ForEach(memoryGameViewModel.cards) { cardItemViewModel in
        AspectVGrid(items: memoryGameViewModel.cards, aspectRatio: 1) { cardItemViewModel in
            CardView(cardItem: cardItemViewModel)
                .padding(5)
                .onTapGesture {
                    memoryGameViewModel.choose(cardItemViewModel)
                }
        }
//                    }
//                }
//            }
            .padding()
//        }
    }
    
//    @ViewBuilder
//    private func cardView(for card: CardItemViewModel) -> some View {
//        CardView(cardItem: card)
//            .padding(5)
//            .onTapGesture {
//                memoryGameViewModel.choose(card)
//            }
//    }
    
}

func randomEmoji() -> String {
    let range = 0x1F300...0x1F3F0
    let index = Int(arc4random_uniform(UInt32(range.count)))
    let ord = range.lowerBound + index
    guard let scalar = UnicodeScalar(ord) else { return "❓" }
    return String(scalar)
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView(memoryGameViewModel: MemoryGameViewModel())
    }
}
