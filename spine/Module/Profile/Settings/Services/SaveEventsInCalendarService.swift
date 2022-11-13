//
//  SaveEventsInCalendarService.swift
//  spine
//
//  Created by Mac on 13/11/22.
//

import Foundation

struct SaveEventsInCalendarResponse {
    var status: Bool = false
}

struct SaveEventsInCalendarService {
    private let httpUtility: HttpUtility
    
    init(httpUtility: HttpUtility) {
        self.httpUtility = httpUtility
    }
    
    func getSaveEventsInCalendarStatus(completion: @escaping(_ result: Result<SaveEventsInCalendarResponse, CHError>) -> Void) {
        completion(.success(SaveEventsInCalendarResponse()))
    }
    
    func updateSaveEventsInCalendarStatus(_ status: String, completion: @escaping(_ result: Result<EditProfileResponseModel, CHError>) -> Void) {
        guard let updateAuthorization = URL(string: APIEndPoint.messagingAuthorization.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(httpMethod: .post, postData: ["calender_status": status], url: updateAuthorization, resultType: EditProfileResponseModel.self) { result in
            completion(result)
        }
    }
}
