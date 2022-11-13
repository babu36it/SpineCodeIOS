//
//  MessagingSettingsViewService.swift
//  spine
//
//  Created by Mac on 13/11/22.
//

import Foundation

struct MessagingSettingsAuthorizationResponseModel {
    var status: Int = 3
}

struct MessagingSettingsViewService {
    private let httpUtility: HttpUtility
    
    init(httpUtility: HttpUtility) {
        self.httpUtility = httpUtility
    }
    
    func getMessageAuthorizationStatus(completion: @escaping(_ result: Result<MessagingSettingsAuthorizationResponseModel, CHError>) -> Void) {
        completion(.success(MessagingSettingsAuthorizationResponseModel()))
    }
    
    func updateMessagingAuthorization(_ status: String, completion: @escaping(_ result: Result<EditProfileResponseModel, CHError>) -> Void) {
        guard let updateAuthorization = URL(string: APIEndPoint.messagingAuthorization.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(httpMethod: .post, postData: ["message_auth": status], url: updateAuthorization, resultType: EditProfileResponseModel.self) { result in
            completion(result)
        }
    }
}
