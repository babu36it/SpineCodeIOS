//
//  SingleImagePicker.swift
//  spine
//
//  Created by Mac on 28/07/22.
//

import SwiftUI
import AVFoundation
import AVKit

struct SingleImagePicker: UIViewControllerRepresentable {
   
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedItem: Any?
    @Environment(\.presentationMode) private var presentationMode
    var supportVideo = true
 
    func makeUIViewController(context: UIViewControllerRepresentableContext<SingleImagePicker>) -> UIImagePickerController {
 
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = sourceType
        if supportVideo {
            imagePicker.mediaTypes = ["public.image", "public.movie"]
        } else {
            imagePicker.mediaTypes = ["public.image"]
        }
        
        //[UTType.image.identifier, UTType.video.identifier] //["public.image", "public.movie"]
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
 
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<SingleImagePicker>) {
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
     
        var parent: SingleImagePicker
     
        init(_ parent: SingleImagePicker) {
            self.parent = parent
        }
     
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedItem = image
            }
            if let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
                parent.selectedItem = videoUrl
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}


//struct SingleImagePicker_Previews: PreviewProvider {
//    static var previews: some View {
//        SingleImagePicker()
//    }
//}
