//
//  AddVoiceOverViewModel.swift
//  spine
//
//  Created by Mac on 10/12/22.
//

import UIKit

class AddVoiceOverViewModel: ObservableObject {
    private let service: AddVoiceOverService = .init()

    @Published var showAction = false
    @Published var selectedMode: UIImagePickerController.SourceType?
    @Published var images: [Any?] = [nil]
    @Published var selectedImage: Any?
    @Published var aboutText = ""
    @Published var hashTags = ""
    @Published var markFriends = ""
    @Published var linkPlace = ""
    @Published var allowComments = false
    
    func createVoiceOver(recording: URL, completion: @escaping (Bool, CHError?) -> Void) {
        guard !aboutText.trim().isEmpty, let audio = Media(withAudio: recording, forKey: "voice")
        else {
            completion(false, .badData)
            return
        }
        
        let params: [String: Any] = ["capture": aboutText, "hagtags": hashTags, "friends": markFriends, "place_link": linkPlace]
        var media: [Media] = []
        if let banner = images.first {
            if let url = banner as? URL, let mediaItem = Media(withVideo: url, forKey: "file") {
                media.append(mediaItem)
            } else if let image = banner as? UIImage, let mediaItem = Media(withImage: image, forKey: "file") {
                media.append(mediaItem)
            }
        }

        media.append(audio)

        service.publishVoiceOver(params, media: media) { result in
            switch result {
            case .success(let response):
                print(response)
                completion(true, nil)
            case .failure(let error):
                print(error)
                completion(false, error)
            }
        }
    }
}
