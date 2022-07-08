//
//  CardView.swift
//  Memorize
//
//  Created by Luis Alejandro Ramirez Suarez on 7/07/22.
//

import SwiftUI

struct CardView: View {
    @ObservedObject var cardItem: CardItemViewModel
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if cardItem.faceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(cardItem.item.text)
                    .padding()
                    .font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .foregroundColor(.red)
        .onTapGesture {
            cardItem.cardTapped()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(cardItem: .init(item: .init(text: "🤣")))
    }
}

