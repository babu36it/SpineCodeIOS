//
//  AddVoiceOverViewModel.swift
//  spine
//
//  Created by Mac on 03/09/22.
//

import Foundation

class AddVoiceOverViewModel: ObservableObject {
    @Published var showAction = false
    @Published var selectedMode: MediaMode?
    @Published var images: [Any?] = [nil]
    @Published var selectedImage: Any?
    @Published var aboutText = ""
    @Published var hashTags = ""
    @Published var markFriends = ""
    @Published var linkPlace = ""
    @Published var allowComments = false
}
