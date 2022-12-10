//
//  AddVoiceOverService.swift
//  spine
//
//  Created by Mac on 10/12/22.
//

import Foundation

class AddVoiceOverService {
    private let httpUtility: HttpUtility = .shared
    
    func publishVoiceOver(_ params: [String: Any]? = nil, media: [Media]?, completion: @escaping (_ result: Result<EventPublishResponse, CHError>) -> Void) {
        guard let url = URL(string: APIEndPoint.createVoiceOver.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestFormData(postData: params, mediaFiles: media, url: url, resultType: EventPublishResponse.self) { result in
            completion(result)
        }
    }
}
