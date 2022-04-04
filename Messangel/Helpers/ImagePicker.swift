//
//  ImagePicker.swift
//  Messangel
//
//  Created by Saad on 6/2/21.
//

import SwiftUI
import UniformTypeIdentifiers
/// Image Picker Representable
///
struct ImagePicker: UIViewControllerRepresentable {
    
    typealias imagePickerController = UIImagePickerController
    
    @Binding var image: UIImage
    @Binding var isShown: Bool
    @Binding var sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(image: $image, isShown: $isShown)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        @Binding var image: UIImage
        @Binding var isShown: Bool
        var sourceType: UIImagePickerController.SourceType = .camera
        
        init(image: Binding<UIImage>, isShown: Binding<Bool>) {
            _image = image
            _isShown = isShown
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                image = uiImage
                isShown = false
            }
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isShown = false
        }
    }
}

struct VideoPicker: UIViewControllerRepresentable {
    
    typealias imagePickerController = UIImagePickerController
    
    @Binding var videoUrl: NSURL
    @Binding var isShown: Bool
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
        imagePicker.mediaTypes = [UTType.movie.identifier]
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(videoUrl: $videoUrl, isShown: $isShown)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        @Binding var videoUrl: NSURL
        @Binding var isShown: Bool
        var sourceType: UIImagePickerController.SourceType = .camera
        
        init(videoUrl: Binding<NSURL>, isShown: Binding<Bool>) {
            _videoUrl = videoUrl
            _isShown = isShown
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? NSURL {
                self.videoUrl = videoUrl
                isShown = false
            }
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isShown = false
        }
    }
}

//struct ImagePicker: UIViewControllerRepresentable {
//
//    var sourceType: UIImagePickerController.SourceType = .photoLibrary
//
//    @Binding var selectedImage: UIImage
//    @Environment(\.presentationMode) private var presentationMode
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
//
//        let imagePicker = UIImagePickerController()
//        imagePicker.allowsEditing = false
//        imagePicker.sourceType = sourceType
//        imagePicker.delegate = context.coordinator
//
//        return imagePicker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
//
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//        var parent: ImagePicker
//
//        init(_ parent: ImagePicker) {
//            self.parent = parent
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//                parent.selectedImage = image
//            }
//
//            parent.presentationMode.wrappedValue.dismiss()
//        }
//    }
//}
