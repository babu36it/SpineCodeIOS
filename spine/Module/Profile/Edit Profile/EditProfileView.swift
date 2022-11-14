//
//  EditProfileView.swift
//  spine
//
//  Created by Mac on 01/07/22.
//

import SwiftUI

struct EditProfileView: View {
    private enum ImageSelectionType {
        case profile, background, none
    }

    @Environment(\.dismiss) var dismiss
    private let screenWidth = UIScreen.main.bounds.size.width

    @StateObject var editProfileViewModel: EditProfileViewModel = .init()
    @State private var showAction = false
    @State private var selectionType: ImageSelectionType = .none
    @State var selectedMode: MediaMode?
    
    //2
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)
                ScrollView(showsIndicators: false) {
                    VStack {
                        ZStack(alignment: .bottom) {
                            if let bgImage = editProfileViewModel.backgroundImages.first {
                                Image(uiImage: bgImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: screenWidth - 30, height: screenWidth/3)
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        selectionType = .background
                                        showAction = true
                                    }
                            } else if let bgImage = editProfileViewModel.backgroundImage {
                                Image(uiImage: bgImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: screenWidth - 30, height: screenWidth/3)
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        selectionType = .background
                                        showAction = true
                                    }
                            } else {
                                Image(ImageName.podcastDetailBanner)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: screenWidth - 30, height: screenWidth/3)
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        selectionType = .background
                                        showAction = true
                                    }
                            }
                            if let image = editProfileViewModel.images.first {
                                AddCircularBorderedProfileView(image: image, size: 100, borderWidth: 3, showShadow: true, showBadge: true)
                                    .offset(y: 40)
                                    .onTapGesture {
                                        selectionType = .profile
                                        showAction = true
                                    }
                            } else if let image: UIImage = editProfileViewModel.userImage {
                                AddCircularBorderedProfileView(image: image, size: 100, borderWidth: 3, showShadow: true, showBadge: true)
                                    .offset(y: 40)
                                    .onTapGesture {
                                        selectionType = .profile
                                        showAction = true
                                    }
                            } else {
                                CircularBorderedProfileView(image: "ic_background", size: 100, borderWidth: 3, showShadow: true, showBadge: false)
                                    .offset(y: 40)
                                    .onTapGesture {
                                        selectionType = .profile
                                        showAction = true
                                    }
                            }
                        }
                        .padding(.bottom, 40)
                        Title4(title: "ADD PROFILE IMAGE", fColor: .gray)
                    }
                    .padding(.vertical, 20)

                    if editProfileViewModel.professionalAcc == false {
                        StandardUser(professionalAcc: $editProfileViewModel.professionalAcc)
                            .environmentObject(editProfileViewModel.practnrProfile)
                    } else {
                        if editProfileViewModel.profileType == .practitioner {
                            UserCompleteProfileView(profileType: $editProfileViewModel.profileType, professionalAcc: $editProfileViewModel.professionalAcc).environmentObject(editProfileViewModel.practnrProfile)
                        } else {
                            UserCompleteProfileView(profileType: $editProfileViewModel.profileType, professionalAcc: $editProfileViewModel.professionalAcc)
                                .environmentObject(editProfileViewModel.companyProfile)
                        }
                    }
                }.padding(.horizontal, 20)
            }
            .onAppear(perform: {
                editProfileViewModel.getUserProfile()
            })
            .modifier(LoadingView(isLoading: $editProfileViewModel.showLoader))
            .alert(editProfileViewModel.alertTitle ?? "", isPresented: $editProfileViewModel.showAlert, actions: {
                Button("OK", role: .cancel, action: {
                    if editProfileViewModel.shouldDismiss {
                        self.dismiss()
                    }
                })
            }, message: {
                if let messageStr = editProfileViewModel.alertMessage {
                    Text(messageStr)
                }
            })
            .sheet(item: $selectedMode) { mode in
                let imageSource: UIImagePickerController.SourceType = mode == .camera ? .camera : .photoLibrary
                let imageBinding: Binding<[UIImage]> = selectionType == .background ? $editProfileViewModel.backgroundImages : $editProfileViewModel.images
                let allowsEditing: Bool = selectionType == .profile
                ImagePicker(sourceType: imageSource, allowsEditing: allowsEditing, selectedImages: imageBinding)
            }
            .actionSheet(isPresented: $showAction) { () -> ActionSheet in
                ActionSheet(title: Text("Choose mode"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                    selectedMode = .camera
                }), ActionSheet.Button.default(Text("Photo Library"), action: {
                    selectedMode = .gallary
                }), ActionSheet.Button.cancel()])
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("EDIT PROFILE", displayMode: .inline)
            .navigationBarItems(leading: Button(action : {
                self.dismiss()
            }){
                Image(systemName: ImageName.multiply)
                    .foregroundColor(.primary)
            })
            .navigationBarItems(trailing: LargeButton(title: "SAVE", width: 50, height: 22, bColor: Color.lightBrown, fSize: 12, fColor: .white) {
                print("Tapped")
                editProfileViewModel.saveProfile()
            }//.opacity(0.3).disabled(true)
            )
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}

