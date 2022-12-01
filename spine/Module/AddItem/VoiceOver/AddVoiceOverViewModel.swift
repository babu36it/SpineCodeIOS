//
//  AddVoiceOverViewModel.swift
//  spine
//
//  Created by Mac on 03/09/22.
//

import UIKit

class AddVoiceOverViewModel: ObservableObject {
    @Published var showAction = false
    @Published var selectedMode: UIImagePickerController.SourceType?
    @Published var images: [Any?] = [nil]
    @Published var selectedImage: Any?
    @Published var aboutText = ""
    @Published var hashTags = ""
    @Published var markFriends = ""
    @Published var linkPlace = ""
    @Published var allowComments = false
}
