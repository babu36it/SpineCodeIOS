//
//  EditProfileView.swift
//  spine
//
//  Created by Mac on 01/07/22.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss

    @StateObject var editProfileViewModel: EditProfileViewModel = .init()
    @State var images: [UIImage] = []
    @State private var showAction = false
    @State var selectedMode: MediaMode?
    
    //2
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        if let image = images.first {
                            AddCircularBorderedProfileView(image: image, size: 100, borderWidth: 3, showShadow: true, showBadge: true)
                        } else if let image: UIImage = editProfileViewModel.userImage {
                            AddCircularBorderedProfileView(image: image, size: 100, borderWidth: 3, showShadow: true, showBadge: true)
                        } else {
                            CircularBorderedProfileView(image: "ic_background", size: 100, borderWidth: 3, showShadow: true, showBadge: false)
                        }
                        
                        Title4(title: "ADD PROFILE IMAGE", fColor: .gray)
                    }
                    .padding(.vertical, 20)
                    .onTapGesture {
                        showAction = true
                    }

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
            .alert("Please input", isPresented: $editProfileViewModel.showError, actions: {
                Button("OK", role: .cancel, action: {})
            }, message: {
                if let messageStr = editProfileViewModel.errorMessage {
                    Text(messageStr)
                }
            })
            .alert("Success", isPresented: $editProfileViewModel.showSuccess, actions: {
                Button("OK", role: .none, action: {
                    self.dismiss()
                }).accentColor(.lightBrown)
            }, message: {
                if let messageStr = editProfileViewModel.apiResponse?.message {
                    Text(messageStr)
                }
            })
            .sheet(item: $selectedMode) { mode in
                switch mode {
                case .camera:
                    ImagePicker(sourceType: .camera, selectedImages: self.$images)
                case .gallary:
                    ImagePicker(sourceType: .photoLibrary, selectedImages: self.$images)
                }
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

