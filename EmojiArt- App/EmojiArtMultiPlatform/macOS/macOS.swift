//
//  macOS.swift
//  EmojiArtMultiPlatform
//
//  Created by Luis Alejandro Ramirez Suarez on 27/07/22.
//

import SwiftUI

typealias UIImage = NSImage
typealias PaletteManager = EmptyView

extension Image {
    init(uiImage: UIImage) {
        self.init(nsImage: uiImage)
    }
}

extension UIImage {
    var imageData: Data? { tiffRepresentation }
}

extension View {
    func wrappedInNavigationViewToMakeDismissable(_ dismiss: (() -> Void)?) -> some View {
        self
    }
    
    func paletteControlButtonStyle() -> some View {
        self.buttonStyle(PlainButtonStyle()).foregroundColor(.accentColor).padding(.vertical)
    }
    
    func popoverPadding() -> some View {
        self.padding(.horizontal)
    }
}

struct CantDoItPhotoPicker: View {
    var handlePickerImage: (UIImage?) -> Void
    
    static let isAvailable = false
    
    var body: some View {
        EmptyView()
    }
}

typealias CameraView = CantDoItPhotoPicker
typealias PhotoLibraryView = CantDoItPhotoPicker

struct Pasteboard {
    static var imageData: Data? {
        NSPasteboard.general.data(forType: .tiff) ?? NSPasteboard.general.data(forType: .png)
    }
    
    static var imageURL: URL? {
        (NSURL(from: NSPasteboard.general) as URL?)?.imageURL
    }
}
