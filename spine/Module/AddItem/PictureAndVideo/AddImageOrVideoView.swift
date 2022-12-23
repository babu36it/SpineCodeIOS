//
//  AddImageOrVideoView.swift
//  spine
//
//  Created by Mac on 13/07/22.
//

import SwiftUI
import UIKit
import AVKit

enum AddItemType {
    case videoImage
    case story
}

extension UIImagePickerController.SourceType: Identifiable {
    public var id: Int {
        rawValue
    }
}

struct AddImageOrVideoView: View {
    @Environment(\.dismiss) var dismiss

    @State private var showAction = false
    @StateObject private var viewModel: AddImageVideoViewModel = .init()
    
    let addItemType: AddItemType

    var body: some View {
        Group {
            if let image = viewModel.selectedImage as? UIImage {
                ImagePreviewView(image: image)
            } else if let videoUrl = viewModel.selectedImage as? URL {
                VideoPreviewView(videoUrl: videoUrl)
            } else {
                ScrollView {
                    VStack(spacing: 20) {
                        EventDetailTitle(text: "Add image(s) or video(s)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                            ForEach(Array(viewModel.images.enumerated()), id: \.offset) { index, image in
                                if let media = image {
                                    ImageVideoCell(media: media) {
                                        if addItemType == .videoImage {
                                            viewModel.images.remove(at: index)
                                        } else {
                                            viewModel.images = [nil] // reset to add image view
                                        }
                                    }
                                } else {
                                    AddCameraView {
                                        if UIImagePickerController.isSourceTypeAvailable(.camera) {
                                            viewModel.showAction = true
                                        } else {
                                            viewModel.selectedMode = .photoLibrary
                                        }
                                    }
                                }
                            }
                        }
                        
                        if addItemType == .videoImage {
                            VStack(alignment: .leading) {
                                EventDetailTitle(text: "Add Capture")
                                CustomTextEditorWithCount(txt: $viewModel.aboutText, placeholder: "Want to say more about this image?", count: 140, height: 100)
                            }
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    EventDetailTitle(text: "Add Hashtags")
                                    Spacer()
                                    Title4(title: "(\(viewModel.hashTags.components(separatedBy: "#").count - 1)/5 hashtags)", fColor: .gray)
                                }
                                CustomTextFieldWithCount(searchText: $viewModel.hashTags, placeholder: "Enter", hashCount: 5)
                            }

                            VStack(alignment: .leading) {
                                EventDetailTitle(text: "Mark Friends")
                                CustomTextFieldWithCount(searchText: $viewModel.markFriends, placeholder: "Enter")
                            }
                            
                            VStack(alignment: .leading) {
                                EventDetailTitle(text: "Link Place")
                                CustomTextFieldWithCount(searchText: $viewModel.linkPlace, placeholder: "Enter")
                            }
                            
                            Text("Would you like to promote your post, click here1")
                                .font(.Poppins(type: .regular, size: 14))
                                .underline()
                            Divider()
                            HStack {
                                Button("Delete"){
                                }
                                .foregroundColor(.lightBrown)
                                Spacer()
                                LargeButton(disable: false, title: "POST", width: 80, height: 30, bColor: .lightBrown, fSize: 12, fColor: .white) {
                                    viewModel.publishPost { status, error in
                                        if status {
                                            dismiss()
                                        } else if let error = error {
                                            ShowToast.show(toatMessage: error.localizedDescription)
                                            print(error)
                                        }
                                    }
                                }
                            }
                        } else if addItemType == .story {
                            VStack(alignment: .leading) {
                                EventDetailTitle(text: "Give your story a meaning")
                                CustomTextFieldWithCount(searchText: $viewModel.aboutText, placeholder: "Want to give your story a title or motto?", count: 90)
                            }
                            HStack {
                                EventDetailTitle2(text: "Allow comments*")
                                Toggle("", isOn: $viewModel.allowComments)
                                    .tint(Color.lightBrown)
                            }
                            Divider()
                            HStack {
                                Button("Delete") {
                                    
                                }
                                .foregroundColor(.lightBrown)
                                Spacer()
                                LargeButton(disable: false, title: "POST", width: 80, height: 30, bColor: .lightBrown, fSize: 12, fColor: .white) {
                                    viewModel.publishStory { status, error in
                                        if status {
                                            dismiss()
                                        } else if let error = error {
                                            ShowToast.show(toatMessage: error.localizedDescription)
                                            print(error)
                                        }
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                    .padding()//vst
                }
            }
        }
        .sheet(item: $viewModel.selectedMode) { mode in
            SingleImagePicker(sourceType: mode, selectedItem: $viewModel.selectedImage)
        }
        .actionSheet(isPresented: $showAction) { () -> ActionSheet in
            ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                viewModel.selectedMode = .camera
            }), ActionSheet.Button.default(Text("Photo Library"), action: {
                viewModel.selectedMode = .photoLibrary
            }), ActionSheet.Button.cancel()])
        }
        .navigationBarTitle(Text(viewModel.selectedImage != nil ? "" : (addItemType == .videoImage ? "ADD IMAGE/VIDEO" : "ADD STORY")), displayMode: .inline)
        .modifier(BackButtonModifier(fColor: viewModel.selectedImage != nil ? .white : .primary ,action: {
            if viewModel.selectedImage != nil {
                viewModel.selectedImage = nil
            } else {
                self.dismiss()
            }
        }))
        .navigationBarItems(trailing: LargeButton(disable: false, title: viewModel.selectedImage != nil ? "ADD" : "POST", width: 40, height: 22, bColor: .lightBrown, fSize: 12, fColor: .white) {
            if let image = viewModel.selectedImage {
                if addItemType == .videoImage {
                    viewModel.images.insert(image, at: 0)
                } else {
                    viewModel.images = [image]
                }
                viewModel.selectedImage = nil
            } else {
                // call post api
            }
        })
    }
}

struct AddImageOrVideoView_Previews: PreviewProvider {
    static var previews: some View {
        AddImageOrVideoView(addItemType: .videoImage)
    }
}

struct ImagePreviewView: View {
    let image: UIImage
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea(.all)
    }
}

struct ImageCellPreviewView: View {
    let image: UIImage
    var heightF: CGFloat = 1.7
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: UIScreen.main.bounds.width/heightF)
            .clipped()
    }
}

struct VideoPreviewView: View {
    let videoUrl: URL
    var heightF: CGFloat = 1.7
    var body: some View {
        VideoPlayer(player: AVPlayer(url: videoUrl))
            .frame(height: UIScreen.main.bounds.width/heightF)
    }
}

struct VideoPreviewView1: View {
    let player: AVPlayer
    var heightF: CGFloat = 1.7
    
    init(player: AVPlayer) {
        self.player = player
    }
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VideoPlayer(player: player)
                .frame(height: UIScreen.main.bounds.width/heightF)
            
            Button {
                player.play()
            } label: {
                Image(systemName: ImageName.plusCircle).font(.title)
                    .foregroundColor(.white)
            }.padding()
        }
        
    }
}

struct AddCameraView: View {
    var isAdd: Bool = true
    var onTapped: ()-> Void
    var body: some View {
        ZStack {
            Image("lightGrayBg")
                .resizable()
                .frame(width: 100, height: 100)
            Button {
                onTapped()
            } label: {
                VStack(spacing: 20) {
                    Image(systemName: ImageName.cameraFill)
                    Text(isAdd ? "Add": "Edit")
                }
            }
            
        }
    }
}


struct ImageVideoCell: View {
    let media: Any
    var onDelete: () -> Void
    var body: some View {
        
        ZStack(alignment: .topTrailing){
            if let videoUrl = media as? URL {
                VideoPlayer(player: AVPlayer(url: videoUrl))
                    .frame(width: 100, height: 100)
            } else if let image = media as? UIImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 100, height: 100)
            }
            
            Button {
                print("tapped")
                onDelete()
            } label: {
                Image(systemName: ImageName.multiply)
            }.padding(5)
                .tint(.white)
        }
    }
}
