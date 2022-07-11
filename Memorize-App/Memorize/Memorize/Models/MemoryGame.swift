//
//  MemoryGame.swift
//  Memorize
//
//  Created by Luis Alejandro Ramirez Suarez on 8/07/22.
//

import Foundation

struct MemoryGame {
    private(set) var cards: Array<CardItemViewModel>
    
    private var indexOfFaceUpCard: Int?
    
    init(numberOfPairsOfCards: Int) {
        cards = Array<CardItemViewModel>()
        // add numberOfPairsOfCards x 2 to cards array.
        for _ in 0..<numberOfPairsOfCards {
            let emoji = randomEmoji()
            let cardsToAppend = [CardItemViewModel(item: .init(text: emoji)),
                                 CardItemViewModel(item: .init(text: emoji))]
            cards.append(contentsOf: cardsToAppend)
        }
        
        cards.shuffle()
    }
    
    mutating func choose(_ card: CardItemViewModel) {
        guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
        !card.matched,
        !card.faceUp else {
            return
        }
        
        cards[chosenIndex].cardTapped()
        
        if let faceUpCardIndex = indexOfFaceUpCard {
            if cards[chosenIndex].item.text == cards[faceUpCardIndex].item.text {
                cards[chosenIndex].matched = true
                cards[faceUpCardIndex].matched = true
            }
            indexOfFaceUpCard = nil
        } else {
            cards.forEach { $0.faceUp = $0.id == cards[chosenIndex].id || $0.matched }
            indexOfFaceUpCard = chosenIndex
        }
    }
}
