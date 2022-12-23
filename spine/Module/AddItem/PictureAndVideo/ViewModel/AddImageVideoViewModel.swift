//
//  AddImageVideoViewModel.swift
//  spine
//
//  Created by Mac on 17/12/22.
//

import UIKit

class AddImageVideoViewModel: ObservableObject {
    private let service: AddImageVideoService = .init()

    @Published var showAction = false
    @Published var aboutText = ""
    @Published var hashTags = ""
    @Published var markFriends = ""
    @Published var linkPlace = ""
    @Published var allowComments = false

    @Published var selectedMode: UIImagePickerController.SourceType?
    @Published var images: [Any?] = [nil]
    @Published var selectedImage: Any?
    
    
    func publishPost(completion: @escaping (Bool, CHError?) -> Void) {
        guard !aboutText.trim().isEmpty, !images.compactMap({$0}).isEmpty
        else {
            completion(false, .badData)
            return
        }

        var mediaItems: [Media] = []
        for item in images {
            if let url = item as? URL, let mediaItem = Media(withVideo: url, forKey: "file") {
                mediaItems.append(mediaItem)
            } else if let image = item as? UIImage, let mediaItem = Media(withImage: image, forKey: "file") {
                mediaItems.append(mediaItem)
            }
        }

        service.publishPhotoVideo(["title": aboutText, "type": "1", "hashtags": hashTags, "mark_friends": markFriends, "place_link": linkPlace], media: mediaItems) { result in
            switch result {
            case .success:
                completion(true, nil)
            case .failure(let error):
                print(error)
                completion(false, error)
            }
        }
    }
    
    func publishStory(completion: @escaping (Bool, CHError?) -> Void) {
        guard !aboutText.trim().isEmpty
        else {
            completion(false, .badData)
            return
        }

        var storyType: String = "3" // 1 for Image ,2 for Video and 3 for Text
        var mediaItems: [Media] = []
        for item in images {
            if let url = item as? URL, let mediaItem = Media(withVideo: url, forKey: "media_file") {
                mediaItems.append(mediaItem)
                storyType = "2"
            } else if let image = item as? UIImage, let mediaItem = Media(withImage: image, forKey: "media_file") {
                mediaItems.append(mediaItem)
                storyType = "1"
            }
        }
        let allowCommentStatus = allowComments ? "true": "false"
        
        service.publishStory(["title": aboutText, "type": storyType, "allow_comment": allowCommentStatus], media: mediaItems) { result in
            switch result {
            case .success:
                completion(true, nil)
            case .failure(let error):
                print(error)
                completion(false, error)
            }
        }
    }
}
