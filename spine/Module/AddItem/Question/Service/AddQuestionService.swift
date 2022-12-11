//
//  AddQuestionService.swift
//  spine
//
//  Created by Mac on 12/12/22.
//

import Foundation

class AddQuestionService {
    private let httpUtility: HttpUtility = .shared
    
    func publishQuestion(_ params: [String: Any]? = nil, media: [Media]?, completion: @escaping (_ result: Result<GenericPostAPIResponse, CHError>) -> Void) {
        guard let url = URL(string: APIEndPoint.addQuestionPost.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestFormData(postData: params, mediaFiles: media, url: url, resultType: GenericPostAPIResponse.self, queue: .main) { result in
            completion(result)
        }
    }
}
