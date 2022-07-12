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
        GeometryReader { geoReader in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if cardItem.faceUp {
                    shape.fill().foregroundColor(cardItem.matched ? .green : .white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                        .foregroundColor(.orange)
                        .opacity(DrawingConstants.circleOpacity)
                        .padding(DrawingConstants.circlePadding)
                    Text(cardItem.item.text)
                        .padding()
                        .font(font(in: geoReader.size))
                } else {
                    shape.fill()
                }
            }
            .foregroundColor(.red)
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
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

