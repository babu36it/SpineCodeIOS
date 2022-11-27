//
//  AddEventServiceProvider.swift
//  spine
//
//  Created by Mac on 29/09/22.
//

import Foundation

struct EventPublishResponse: Codable {
    let status: Bool?
    let eventID: Int?
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case status, message
        case eventID = "event_id"
    }
}

struct AddEventServiceProvider {
    private let httpUtility: HttpUtility = .shared
    
    func getEventsTypes(completion: @escaping(_ result: Result<APIResponseModel<[EventTypeModel]>, CHError>)-> Void) {
        guard let url = URL(string: APIEndPoint.getEventTypes.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(url: url, resultType: APIResponseModel<[EventTypeModel]>.self) { result in
            completion(result)
        }
    }
    
    func getUserEvents(completion: @escaping(_ result: Result<APIResponseModel<[EventModel]>, CHError>)-> Void) {
        guard let url = URL(string: APIEndPoint.getUserEvents.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(url: url, resultType: APIResponseModel<[EventModel]>.self) { result in
            completion(result)
        }
    }
    
    func publishEvent(_ params: [String: Any]? = nil, media: [Media]? = nil, completion: @escaping (_ result: Result<EventPublishResponse, CHError>) -> Void) {
        guard let url = URL(string: APIEndPoint.publishEvent.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestFormData(postData: params, mediaFiles: media, url: url, resultType: EventPublishResponse.self) { result in
            completion(result)
        }
    }
}

struct EventTypeModel: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
    let status: String
    let image: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "type_name"
        case description = "description"
        case status = "status"
        case image = "type_image"
    }
}

struct APIResponseModel<T: Codable>: Codable {
    let status: Bool
    let data: T?
    let image: String?
    let message: String?
    
    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
        case image = "image"
        case message = "message"
    }
}

struct EventCategoryModel: Codable {
    let id, categoryName, status, createdOn, updatedOn: String

    enum CodingKeys: String, CodingKey {
        case id, status
        case categoryName = "category_name"
        case createdOn = "created_on"
        case updatedOn = "updated_on"
    }
}
