//
//  CameraView.swift
//  EmojiArt
//
//  Created by Luis Alejandro Ramirez Suarez on 26/07/22.
//

import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    
    
    typealias UIViewControllerType = UIImagePickerController
    
    var handlePickerImage: (UIImage?) -> Void
    
    static var isAvailable: Bool {
        UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Nothing to do
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var handlePickerImage: (UIImage?) -> Void
        
        init(handerPickerImage: @escaping (UIImage?) -> Void) {
            self.handlePickerImage = handerPickerImage
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            handlePickerImage(nil)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            handlePickerImage((info[.editedImage] ?? info[.originalImage]) as? UIImage)
        }
    }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(handerPickerImage: handlePickerImage)
    }
}
