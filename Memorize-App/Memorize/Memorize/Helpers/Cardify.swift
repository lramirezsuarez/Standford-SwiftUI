//
//  Cardify.swift
//  Memorize
//
//  Created by Luis Alejandro Ramirez Suarez on 13/07/22.
//

import SwiftUI

struct Cardify: ViewModifier {
    var faceUp: Bool
    var matched: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if faceUp {
                shape.fill().foregroundColor(matched ? .green : .white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            } else {
                shape.fill()
            }
            content
                .opacity(faceUp ? 1 : 0)
        }
        .foregroundColor(.red)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardify(faceUp: Bool, matched: Bool) -> some View {
        self.modifier(Cardify(faceUp: faceUp, matched: matched))
    }
}
