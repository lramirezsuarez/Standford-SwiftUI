//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by Luis Alejandro Ramirez Suarez on 15/07/22.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    let document = EmojiArtDocument()
    let paletteStore = PaletteStore(named: "Default")
    
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: document)
        }
    }
}
