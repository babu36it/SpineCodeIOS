//
//  EventDetailViewModel.swift
//  spine
//
//  Created by Mac on 03/12/22.
//

import UIKit

class EventDetailViewModel: ObservableObject {
    
    @Published var eventImages: [UIImage] = []

    private(set) var eventImagePath: String?
    private(set) var userImagePath: String?
    private(set) var event: EventModel

    init(event: EventModel, eventImagePath: String?, userImagePath: String?) {
        self.event = event
        self.eventImagePath = eventImagePath
        self.userImagePath = userImagePath
    }
    
    var userImageForEvent: String? {
        if let userImagePath = userImagePath, !userImagePath.isEmpty, !event.hostedProfilePic.isEmpty {
            return "\(userImagePath)\(event.hostedProfilePic)"
        }
        return nil
    }
    
    func getEventImages() {
        eventImages.removeAll()
        
        if let imagePath = eventImagePath, let imageURLs = event.imageURLs(for: imagePath) {
            for imageURL in imageURLs {
                let imageDownloader = DefaultImageDownloader(imagePath: imageURL)

                let cacheKey = imageDownloader.cacheKey
                if let cachedImage = RemoteImageCache.shared.getImage(for: cacheKey) {
                    eventImages.append(cachedImage)
                } else {
                    imageDownloader.downloadImageData { imgData, _ in
                        if let imgData = imgData, let image = UIImage(data: imgData) {
                            DispatchQueue.main.async { [weak self] in
                                self?.eventImages.append(image)
                            }
                        }
                    }
                }
            }
        }
    }
}
