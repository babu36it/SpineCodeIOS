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

struct EventRequest {
    enum RequestType: String {
        case all = "all"
        case saved = "saved"
        case going = "going"
        case past = "past"
        case online = "online"
        case metaverse = "metaverse"
        case following = "following"
    }

    let page: Int
    let perPage: Int
    let type: RequestType
    let eventTypeID: String?
    
    var queryParams: [String: Any] {
        var params: [String: Any] = ["page": page, "per_page": perPage, "type": type.rawValue]
        if let eventTypeID = eventTypeID {
            params["event_type_id"] = eventTypeID
        }
        return params
    }
}

protocol CommonEventFetcher {
    func getEventsTypes(completion: @escaping(_ result: Result<APIResponseModel<[EventTypeModel]>, CHError>)-> Void)
    func getEvents<T: Decodable>(for request: EventRequest, completion: @escaping(_ result: Result<T, CHError>)-> Void)
}

extension CommonEventFetcher {
    func getEventsTypes(completion: @escaping(_ result: Result<APIResponseModel<[EventTypeModel]>, CHError>)-> Void) {
        guard let url = URL(string: APIEndPoint.getEventTypes.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        HttpUtility.shared.getCachedResponse(url: url, cachedFilename: CachedFileNames.eventTypes, queue: .main, completion: completion)
    }
    
    func getEvents<T: Decodable>(for request: EventRequest, completion: @escaping(_ result: Result<T, CHError>)-> Void) {
        guard let url = URL(string: APIEndPoint.getAllEvent.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        HttpUtility.shared.requestData(httpMethod: .post, postData: request.queryParams, url: url, resultType:  T.self, queue: .main, completion: completion)
    }
}

struct AddEventServiceProvider: CommonEventFetcher {
    private let httpUtility: HttpUtility = .shared
        
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
        case id, description, status
        case name = "type_name"
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
