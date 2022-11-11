//
//  AddVoiceOverView.swift
//  spine
//
//  Created by Mac on 03/09/22.
//

import SwiftUI

struct AddVoiceOverView: View {
    let addItemType: AddItemType = .videoImage
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = AddVoiceOverViewModel()
    @StateObject var voiceVM = VoiceViewModel()
    @State var showAudiePreview = false
    
    var body: some View {
        Group {
            if let image = viewModel.selectedImage as? UIImage {
                ImagePreviewView(image: image)
            } else if let videoUrl = viewModel.selectedImage as? URL {
                VideoPreviewView(videoUrl: videoUrl)
            } else {
                ScrollView {
                    VStack(spacing: 20) {
                        EventDetailTitle(text: "Add image or video")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                            ForEach(Array(viewModel.images.enumerated()), id: \.offset) { index, image in
                                
                                if let media = image {
                                    ImageVideoCell(media: media) {
                                        viewModel.images.remove(at: index)
                                    }
                                } else {
                                    AddCameraView(isAdd: viewModel.images.count != 2) {
                                        viewModel.showAction = true
                                    }
                                }
                            }
                        }
                        
                        if addItemType == .videoImage {
                            
                            VStack(alignment: .leading) {
                                EventDetailTitle(text: "Add voiceover (max 2 min)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                HStack {
                                    if voiceVM.isAudioExist && !voiceVM.isRecording {
                                        Image(systemName: voiceVM.isPlaying ? "play" : "play")
                                            .onTapGesture {
                                                voiceVM.startPlaying()
                                                /*
                                                if voiceVM.isPlaying {
                                                    voiceVM.stopPlaying()
                                                } else  {
                                                voiceVM.startPlaying()
                                                } */
                                            }
                                    } else {
                                    Image(systemName: voiceVM.isRecording ? "stop.circle.fill" : "mic.circle.fill")
                                        .foregroundColor(.lightBrown)
                                        .font(.system(size: 45))
                                        .onTapGesture {
                                            if voiceVM.isRecording == true {
                                                voiceVM.stopRecording()
                                                showAudiePreview = true
                                            } else {
                                                voiceVM.startRecording()
                                            }
                                        }
                                    }
                                    MicrophoneVisualization(height: 40, fColor: .gray).environmentObject(voiceVM)
                                    if voiceVM.isAudioExist {
                                        Button {
                                            voiceVM.deleteRecording()
                                        } label: {
                                            Image(systemName: ImageName.trash)
                                        }
                                    }
                                }
                            }
                            
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
                            Text("Would you like to promote your post, click here")
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
                        }
                        NavigationLink(isActive: $showAudiePreview) {
                            AudioPreviewView().environmentObject(voiceVM)
                        } label: {
                            EmptyView()
                        }
                        Spacer()
                    }.padding()//vst
                }
            }
        }
        .sheet(item: $viewModel.selectedMode) { mode in
            switch mode {
            case .camera:
                SingleImagePicker(sourceType: .camera, selectedItem: self.$viewModel.selectedImage)
            case .gallary:
                SingleImagePicker(sourceType: .photoLibrary, selectedItem: self.$viewModel.selectedImage)
            }
        }
        .actionSheet(isPresented: $viewModel.showAction) { () -> ActionSheet in
            ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                viewModel.selectedMode = .camera
            }), ActionSheet.Button.default(Text("Photo Library"), action: {
                viewModel.selectedMode = .gallary
            }), ActionSheet.Button.cancel()])
        }
        .navigationBarTitle(Text(viewModel.selectedImage != nil ? "" : "ADD IMAGE/VIDEO"), displayMode: .inline)
        .modifier(BackButtonModifier(fColor: viewModel.selectedImage != nil ? .white : .primary ,action: {
            if viewModel.selectedImage != nil {
                viewModel.selectedImage = nil
            } else {
                self.dismiss()
            }
            
        }))
        .navigationBarItems(trailing: LargeButton(disable: false, title: viewModel.selectedImage != nil ? "ADD" : "POST", width: 40, height: 22, bColor: .lightBrown, fSize: 12, fColor: .white) {
            if let image = viewModel.selectedImage {
                if let firstItem = viewModel.images.first, firstItem != nil {
                    viewModel.images.remove(at: 0)
                }
                viewModel.images.insert(image, at: 0)
                viewModel.selectedImage = nil
            } else {
                // call post api
            }
        })
    }
}
struct AddVoiceOverView_Previews: PreviewProvider {
    static var previews: some View {
        AddVoiceOverView()
    }
}
