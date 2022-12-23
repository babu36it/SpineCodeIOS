//
//  AddQuestionThoughtViewModel.swift
//  spine
//
//  Created by Mac on 26/07/22.
//

import Foundation
import SwiftUI


class AddQuestionThoughtViewModel: ObservableObject {
    private let service: AddQuestionService = .init()
    
    let postTextLimit = 460
    let hashTagCount = 5
    let bgColors: [Color] = [.lightBrown, .red, .green, .blue, .yellow]
    @Published var selectedTab: Color = .lightBrown
    @Published var showTag = false
    @Published var showPreview = false
    
    @Published var postText = "" {
        didSet {
            if postText.count > postTextLimit {
                postText = String(postText.prefix(postTextLimit))
            }
        }
    }
    
    @Published var hashTag = "" {
        didSet {
            if hashTag.components(separatedBy: "#").count - 1 > hashTagCount {
                hashTag = String(hashTag.prefix(hashTag.count - 1))
            }
        }
    }
    
    func publishPost(_ post: String, hashtags: String, completion: @escaping (Bool, CHError?) -> Void) {
        service.publishQuestion(["title": post, "type": "0", "hashtags": hashtags], media: nil) { result in
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
