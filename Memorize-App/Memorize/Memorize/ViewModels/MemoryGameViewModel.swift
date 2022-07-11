//
//  MemoryGameViewModel.swift
//  Memorize
//
//  Created by Luis Alejandro Ramirez Suarez on 8/07/22.
//

import SwiftUI

final class MemoryGameViewModel: ObservableObject {
    @Published private var model = MemoryGame(numberOfPairsOfCards: 4)
    
    var cards: Array<CardItemViewModel> {
        return model.cards
    }
    
    // MARK: Intent
    
    func choose(_ card: CardItemViewModel) {
        model.choose(card)
    }
}
