//
//  BoardView.swift
//  Memorize
//
//  Created by Luis Alejandro Ramirez Suarez on 7/07/22.
//

import SwiftUI

struct BoardView: View {
    @ObservedObject var memoryGameViewModel: MemoryGameViewModel
    
    var gridItems = [GridItem(.adaptive(minimum: 100))]
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: gridItems, spacing: 10) {
                    ForEach(memoryGameViewModel.cards) { cardItemViewModel in
                        CardView(cardItem: cardItemViewModel)
                            .aspectRatio(1, contentMode: .fit)
                            .onTapGesture {
                                memoryGameViewModel.choose(cardItemViewModel)
                            }
                    }
                }
            }
            .padding()
        }
    }
    
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
