//
//  CardItemViewModel.swift
//  Memorize
//
//  Created by Luis Alejandro Ramirez Suarez on 7/07/22.
//

import SwiftUI

final class CardItemViewModel: Identifiable, ObservableObject {
    var item: CardItem
    @Published var faceUp: Bool
    @Published var matched: Bool
    
    init(item: CardItem,
         faceUp: Bool = false,
         matched: Bool = false) {
        self.item = item
        self.faceUp = faceUp
        self.matched = matched
    }
    
    func cardTapped() {
        faceUp.toggle()
    }
}
