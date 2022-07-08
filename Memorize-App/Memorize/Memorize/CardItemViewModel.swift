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
    
    init(item: CardItem,
         faceUp: Bool = false) {
        self.item = item
        self.faceUp = faceUp
    }
    
    func cardTapped() {
        faceUp.toggle()
    }
}
