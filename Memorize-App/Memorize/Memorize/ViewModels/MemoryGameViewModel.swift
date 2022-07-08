//
//  MemoryGameViewModel.swift
//  Memorize
//
//  Created by Luis Alejandro Ramirez Suarez on 8/07/22.
//

import SwiftUI

final class MemoryGameViewModel {
    private var model: MemoryGame<CardItemViewModel> = MemoryGame<CardItemViewModel>(numberOfPairsOfCards: 4)
    
    var cards: Array<CardItemViewModel> {
        return model.cards
    }
}
