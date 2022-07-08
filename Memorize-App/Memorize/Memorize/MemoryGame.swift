//
//  MemoryGame.swift
//  Memorize
//
//  Created by Luis Alejandro Ramirez Suarez on 8/07/22.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: Array<CardItemViewModel>
    
    func choose(_ card: CardItemViewModel) {
        
    }
    
    init(numberOfPairsOfCards: Int) {
        cards = Array<CardItemViewModel>()
        // add numberOfPairsOfCards x 2 to cards array.
        for _ in 0..<numberOfPairsOfCards {
            let emoji = randomEmoji()
            let cardsToAppend = [CardItemViewModel(item: .init(text: emoji)),
                                 CardItemViewModel(item: .init(text: emoji))]
            cards.append(contentsOf: cardsToAppend)
        }
    }
}
