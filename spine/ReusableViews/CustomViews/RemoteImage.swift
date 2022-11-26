//
//  RemoteImage.swift
//  spine
//
//  Created by Mac on 25/11/22.
//

import SwiftUI

protocol ImageDownloader {
    var cacheKey: String { get }
    func downloadImageData(completion: @escaping (Data?, Error?) -> Void)
}

class DefaultImageDownloader: ImageDownloader {
    let imagePath: String
    
    var cacheKey: String {
        imagePath
    }
    
    init(imagePath: String) {
        self.imagePath = imagePath
    }
    
    func downloadImageData(completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: imagePath) else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            completion(data, error)
        }
        dataTask.resume()
    }
}

class RemoteImageCache: NSCache<NSString, UIImage> {
    static let shared = RemoteImageCache()
    
    func cache(_ image: UIImage, for key: String) {
        setObject(image, forKey: key as NSString)
    }
    
    func getImage(for key: String) -> UIImage? {
        object(forKey: key as NSString)
    }
}

struct RemoteImage: View {
    enum Error: Swift.Error {
        case badData
    }
    
    @State var uiImage: UIImage?
    @State var error: Error?

    private let placeholder: Image?
    private let imageDownloader: ImageDownloader
    
    init(placeholder: Image? = nil, imageDownloader: ImageDownloader) {
        self.placeholder = placeholder
        self.imageDownloader = imageDownloader
    }
    
    var body: some View {
        if let uiImage = self.uiImage {
            Image(uiImage: uiImage)
                .resizable()
        } else {
            Group {
                if let placeholder = placeholder {
                    placeholder
                } else if error != nil {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .strokeBorder()
                        Image(systemName: "exclamationmark.circle")
                    }
                    .foregroundColor(.red)
                } else {
                    progressView
                }
            }
            .onAppear(perform: getImage)
        }
    }
    
    private var progressView: some View {
        ProgressView()
    }

    private func getImage() {
        let cacheKey = imageDownloader.cacheKey
        if let cachedImage = RemoteImageCache.shared.getImage(for: cacheKey) {
            self.uiImage = cachedImage
        } else {
            imageDownloader.downloadImageData { imageData, error in
                if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                    RemoteImageCache.shared.cache(uiImage, for: cacheKey)
                    
                    DispatchQueue.main.async {
                        self.uiImage = uiImage
                    }
                } else {
                    self.error = .badData
                    self.uiImage = nil
                }
            }
        }
    }
}
