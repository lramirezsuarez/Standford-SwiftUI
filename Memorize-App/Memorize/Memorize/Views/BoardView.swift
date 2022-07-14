//
//  BoardView.swift
//  Memorize
//
//  Created by Luis Alejandro Ramirez Suarez on 7/07/22.
//

import SwiftUI

struct BoardView: View {
    @ObservedObject var memoryGameViewModel: MemoryGameViewModel
    @State private var dealt = Set<ObjectIdentifier>()
    @Namespace private var dealingNamespace
    
    private func deal(_ card: CardItemViewModel) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: CardItemViewModel) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: CardItemViewModel) -> Animation {
        var delay = 0.0
        if let index = memoryGameViewModel.cards.firstIndex(where: {$0.id == card.id }) {
            delay = Double(index) * ((CardConstants.totalDealDuration) / Double(memoryGameViewModel.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: CardItemViewModel) -> Double {
        -Double(memoryGameViewModel.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                gameBody
                HStack {
                    restart
                    Spacer()
                    shuffle
                }
            }
            deckBody
        }.padding()
//        VStack {
//            ScrollView {
//                LazyVGrid(columns: gridItems, spacing: 10) {
//                    ForEach(memoryGameViewModel.cards) { cardItemViewModel in
        
//                    }
//                }
//            }
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
    
    var gameBody: some View {
        AspectVGrid(items: memoryGameViewModel.cards, aspectRatio: CardConstants.aspectRatio) { cardItemViewModel in
            if isUndealt(cardItemViewModel) || (cardItemViewModel.matched && !cardItemViewModel.faceUp) {
                Color.clear
            } else {
                CardView(cardItem: cardItemViewModel)
                    .matchedGeometryEffect(id: cardItemViewModel.id, in: dealingNamespace)
                    .padding(5)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .opacity))
                    .zIndex(zIndex(of: cardItemViewModel))
                    .onTapGesture {
                        withAnimation {
                            memoryGameViewModel.choose(cardItemViewModel)
                        }
                    }
            }
        }
        
        .foregroundColor(CardConstants.color)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(memoryGameViewModel.cards.filter(isUndealt)) { card in
                CardView(cardItem: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
        }.onTapGesture {
            for card in memoryGameViewModel.cards {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
    }
    
    var shuffle: some View {
        Button("Shuffle") {
            withAnimation(.spring()) {
                memoryGameViewModel.shuffle()
            }
        }
            
    }
    
    var restart: some View {
        Button("Restart") {
            withAnimation {
                dealt = []
                memoryGameViewModel.restart()
            }
        }
    }
    
    private struct CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 1
        static let dealDuration: Double = 0.5
        static let totalDealDuration: CGFloat = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth = undealtHeight * aspectRatio
        
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
