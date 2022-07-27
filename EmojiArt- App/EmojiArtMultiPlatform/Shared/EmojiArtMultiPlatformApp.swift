//
//  EmojiArtMultiPlatformApp.swift
//  Shared
//
//  Created by Luis Alejandro Ramirez Suarez on 27/07/22.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    //    @StateObject var document = EmojiArtDocument()
    @StateObject var paletteStore = PaletteStore(named: "Default")
    
    var body: some Scene {
        DocumentGroup(newDocument: { EmojiArtDocument() }) { config in
            EmojiArtDocumentView(document: config.document)
                .environmentObject(paletteStore)
        }
    }
}

