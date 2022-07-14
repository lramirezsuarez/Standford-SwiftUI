//
//  MemoryGame.swift
//  Memorize
//
//  Created by Luis Alejandro Ramirez Suarez on 8/07/22.
//

import Foundation

struct MemoryGame {
    private(set) var cards: Array<CardItemViewModel>
    
    private var indexOfFaceUpCard: Int? {
        get {
            cards.indices.filter({ cards[$0].faceUp && !cards[$0].matched }).oneAndOnly
        }
        set {
            cards.indices.forEach({ cards[$0].faceUp = $0 == newValue /*|| cards[$0].matched*/ })
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        cards = []
        // add numberOfPairsOfCards x 2 to cards array.
        for _ in 0..<numberOfPairsOfCards {
            let emoji = randomEmoji()
            let cardsToAppend = [CardItemViewModel(item: .init(text: emoji)),
                                 CardItemViewModel(item: .init(text: emoji))]
            cards.append(contentsOf: cardsToAppend)
        }
    }
    
    mutating func choose(_ card: CardItemViewModel) {
        guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
        !card.matched,
        !card.faceUp else {
            return
        }
        
        
        if let faceUpCardIndex = indexOfFaceUpCard {
            if cards[chosenIndex].item.text == cards[faceUpCardIndex].item.text {
                cards[chosenIndex].matched = true
                cards[faceUpCardIndex].matched = true
            }
            cards[chosenIndex].cardTapped()
        } else {
            indexOfFaceUpCard = chosenIndex
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
}

extension Array {
    var oneAndOnly: Element? {
        return self.count == 1 ? first : nil
    }
}
