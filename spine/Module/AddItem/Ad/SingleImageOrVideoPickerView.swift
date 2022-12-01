//
//  SingleImageOrVideoPickerView.swift
//  spine
//
//  Created by Mac on 13/08/22.
//

import SwiftUI
import AVKit

struct SingleImageOrVideoPickerView: View {
    @Binding var selectedMedia: Any?
    @State private var showAction = false
    @State var selectedMode: UIImagePickerController.SourceType?
    var supportVideo = true
    
    var body: some View {
        VStack {
            ZStack {
                
                if let image = selectedMedia as? UIImage {
                    ImageCellPreviewView(image: image)
                } else if let videoUrl = selectedMedia as? URL {
                    VideoPreviewView(videoUrl: videoUrl)
                    //VideoPreviewView1(player: AVPlayer(url: videoUrl))
                } else {
                    GreyBackgroundImage()
                }
             //   if selectedMedia == nil { //add if condition if u dont want to see camera button once the image is added
                    VStack(spacing: 10) {
                        Image(systemName: ImageName.cameraFill)
                        Title4(title: supportVideo ? "Add an image or video" : "Add an image")
                    }.foregroundColor(.lightBrown)
                        .onTapGesture {
                            showAction = true
                        }
             //   }
            }
        }
        
        .sheet(item: $selectedMode) { mode in
            SingleImagePicker(sourceType: mode, selectedItem: self.$selectedMedia, supportVideo: supportVideo)
        }
        .actionSheet(isPresented: $showAction) { () -> ActionSheet in
            ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                selectedMode = .camera
            }), ActionSheet.Button.default(Text("Photo Library"), action: {
                selectedMode = .photoLibrary
            }), ActionSheet.Button.cancel()])
        }
    }
}


//struct SingleImageOrVideoPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        SingleImageOrVideoPickerView()
//    }
//}
