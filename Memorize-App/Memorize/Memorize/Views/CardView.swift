//
//  CardView.swift
//  Memorize
//
//  Created by Luis Alejandro Ramirez Suarez on 7/07/22.
//

import SwiftUI

struct CardView: View {
    @ObservedObject var cardItem: CardItemViewModel
    @State private var animateBonusRemaining: Double = 0
    
    var body: some View {
        GeometryReader { geoReader in
            ZStack {
                Group {
                    if cardItem.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: (1 - animateBonusRemaining) * 360 - 90))
                            .onAppear {
                                animateBonusRemaining = cardItem.bonusRemaining
                                withAnimation(.linear(duration: cardItem.bonusTimeRemaining)) {
                                    animateBonusRemaining = 0
                                }
                            }
                    } else {
                        Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: (1 - cardItem.bonusRemaining) * 360 - 90))
                    }
                }
                .foregroundStyle(Gradient(colors: [.red, .orange, .green]))
                .opacity(DrawingConstants.circleOpacity)
                .padding(DrawingConstants.circlePadding)
                Text(cardItem.item.text)
                    .padding()
                    .rotationEffect(Angle.degrees(cardItem.matched ? 360 : 0))
//                    .animation(.linear(duration: 2).repeatForever(autoreverses: false))
                    .font(.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geoReader.size))
            }
            .cardify(faceUp: cardItem.faceUp)
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontSize: CGFloat = 32
        static let fontScale: CGFloat = 0.5
        static let circleOpacity: CGFloat = 0.5
        static let circlePadding: CGFloat = 10
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(cardItem: .init(item: .init(text: "🤣"), faceUp: true))
    }
}

