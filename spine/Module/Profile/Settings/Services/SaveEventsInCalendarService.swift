//
//  SaveEventsInCalendarService.swift
//  spine
//
//  Created by Mac on 13/11/22.
//

import Foundation

struct SaveEventsInCalendarService {
    private let httpUtility: HttpUtility = .shared
    
    func getAccountSettings(completion: @escaping(_ result: Result<AccountSettingResponseModel, CHError>) -> Void) {
        guard let accountSettings = URL(string: APIEndPoint.userAccountSettings.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(url: accountSettings, resultType: AccountSettingResponseModel.self) { result in
            completion(result)
        }
    }

    func updateSaveEventsInCalendarStatus(_ status: String, completion: @escaping(_ result: Result<GenericPostAPIResponse, CHError>) -> Void) {
        guard let updateAuthorization = URL(string: APIEndPoint.saveEventToCalendar.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(httpMethod: .post, postData: ["calender_status": status], url: updateAuthorization, resultType: GenericPostAPIResponse.self) { result in
            completion(result)
        }
    }
}
