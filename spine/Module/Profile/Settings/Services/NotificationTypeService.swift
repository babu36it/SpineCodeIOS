//
//  NotificationTypeService.swift
//  spine
//
//  Created by Mac on 13/11/22.
//

import Foundation

class NotificationTypeService {
    private let httpUtility: HttpUtility
    
    init(httpUtility: HttpUtility) {
        self.httpUtility = httpUtility
    }
    
    func getAccountSettings(completion: @escaping(_ result: Result<AccountSettingResponseModel, CHError>) -> Void) {
        guard let accountSettings = URL(string: APIEndPoint.userAccountSettings.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(url: accountSettings, resultType: AccountSettingResponseModel.self) { result in
            completion(result)
        }
    }
    
    func updatePushNotificationStatus(params: [String: Any], completion: @escaping(_ result: Result<EditProfileResponseModel, CHError>) -> Void) {
        guard let languagesList = URL(string: APIEndPoint.mobileNotifications.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(httpMethod: .post, postData: params, url: languagesList, resultType: EditProfileResponseModel.self) { result in
            completion(result)
        }
    }
    
    func updateEmailNotificationStatus(params: [String: Any], completion: @escaping(_ result: Result<EditProfileResponseModel, CHError>) -> Void) {
        guard let languagesList = URL(string: APIEndPoint.emailNotifications.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(httpMethod: .post, postData: params, url: languagesList, resultType: EditProfileResponseModel.self) { result in
            completion(result)
        }
    }
}
