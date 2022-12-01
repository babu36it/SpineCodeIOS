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
    let addItemType: AddItemType
    @State private var showAction = false
    @State var selectedMode: UIImagePickerController.SourceType?
    @Environment(\.dismiss) var dismiss
    @State var images: [Any?] = [nil]
    @State var selectedImage: Any?
    @State var aboutText = ""
    @State var hashTags = ""
    @State var markFriends = ""
    @State var linkPlace = ""
    @State var allowComments = false
    
    var body: some View {
        Group {
            if let image = selectedImage as? UIImage {
                ImagePreviewView(image: image)
            } else if let videoUrl = selectedImage as? URL {
                VideoPreviewView(videoUrl: videoUrl)
            } else {
                ScrollView {
                    VStack(spacing: 20) {
                        EventDetailTitle(text: "Add image(s) or video(s)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                            //[GridItem(.adaptive(minimum: 100))]
                            //[GridItem(.fixed(100)), GridItem(.fixed(100)), GridItem(.fixed(100))]
                            ForEach(Array(images.enumerated()), id: \.offset) { index, image in
                                
                                if let media = image {
                                    ImageVideoCell(media: media) {
                                        images.remove(at: index)
                                    }
                                } else {
                                    AddCameraView {
                                        showAction = true
                                    }
                                }
                            }
                        }
                        
                        if addItemType == .videoImage {
                            VStack(alignment: .leading) {
                                EventDetailTitle(text: "Add Capture")
                                CustomTextEditorWithCount(txt: $aboutText, placeholder: "Want to say more about this image?", count: 140, height: 100)
                            }
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    EventDetailTitle(text: "Add Hashtags")
                                    Spacer()
                                    Title4(title: "(\(hashTags.components(separatedBy: "#").count - 1)/5 hashtags)", fColor: .gray)
                                }
                                CustomTextFieldWithCount(searchText: $hashTags, placeholder: "Enter", hashCount: 5)
                            }
                            
                            
                            
                            VStack(alignment: .leading) {
                                EventDetailTitle(text: "Mark Friends")
                                CustomTextFieldWithCount(searchText: $markFriends, placeholder: "Enter")
                            }
                            
                            VStack(alignment: .leading) {
                                EventDetailTitle(text: "Link Place")
                                CustomTextFieldWithCount(searchText: $linkPlace, placeholder: "Enter")
                            }
                            
                            Text("Would you like to promote your post, click here1")
                                .font(.Poppins(type: .regular, size: 14))
                                .underline()
                            Divider()
                            HStack {
                                Button("Delete"){
                                    
                                }.foregroundColor(.lightBrown)
                                Spacer()
                                LargeButton(disable: false, title: "POST", width: 80, height: 30, bColor: .lightBrown, fSize: 12, fColor: .white) {
                                    
                                }
                            }
                        } else if addItemType == .story {
                            
                            VStack(alignment: .leading) {
                                EventDetailTitle(text: "Give your story a meaning")
                                CustomTextFieldWithCount(searchText: $hashTags, placeholder: "Want to give your story a title or motto?", count: 90)
                            }
                            HStack {
                                EventDetailTitle2(text: "Allow comments*")
                                Toggle("", isOn: $allowComments)
                                    .tint(Color.lightBrown)
                            }
                            Divider()
                            HStack {
                                Button("Delete"){
                                    
                                }.foregroundColor(.lightBrown)
                                Spacer()
                            }
                            
                        }
                        Spacer()
                    }.padding()//vst
                }
            }
        }
        .sheet(item: $selectedMode) { mode in
            SingleImagePicker(sourceType: mode, selectedItem: self.$selectedImage)
        }
        .actionSheet(isPresented: $showAction) { () -> ActionSheet in
            ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                selectedMode = .camera
            }), ActionSheet.Button.default(Text("Photo Library"), action: {
                selectedMode = .photoLibrary
            }), ActionSheet.Button.cancel()])
        }
        .navigationBarTitle(Text(selectedImage != nil ? "" : "ADD IMAGE/VIDEO"), displayMode: .inline)
        .modifier(BackButtonModifier(fColor: selectedImage != nil ? .white : .primary ,action: {
            if selectedImage != nil {
                selectedImage = nil
            } else {
                self.dismiss()
            }
            
        }))
        .navigationBarItems(trailing: LargeButton(disable: false, title: selectedImage != nil ? "ADD" : "POST", width: 40, height: 22, bColor: .lightBrown, fSize: 12, fColor: .white) {
            if let image = selectedImage {
                images.insert(image, at: 0)
                selectedImage = nil
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
