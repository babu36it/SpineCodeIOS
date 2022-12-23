//
//  AddImageVideoService.swift
//  spine
//
//  Created by Mac on 18/12/22.
//

import Foundation

class AddImageVideoService {
    private let httpUtility: HttpUtility = .shared
    
    func publishPhotoVideo(_ params: [String: Any]? = nil, media: [Media]?, completion: @escaping (_ result: Result<GenericPostAPIResponse, CHError>) -> Void) {
        guard let url = URL(string: APIEndPoint.addQuestionPost.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestFormData(postData: params, mediaFiles: media, url: url, resultType: GenericPostAPIResponse.self, queue: .main) { result in
            completion(result)
        }
    }
    
    
    func publishStory(_ params: [String: Any]? = nil, media: [Media]?, completion: @escaping (_ result: Result<GenericPostAPIResponse, CHError>) -> Void) {
        guard let url = URL(string: APIEndPoint.addUserStory.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestFormData(postData: params, mediaFiles: media, url: url, resultType: GenericPostAPIResponse.self, queue: .main) { result in
            completion(result)
        }
    }

}
