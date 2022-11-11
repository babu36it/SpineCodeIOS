//
//  AddEventServiceProvider.swift
//  spine
//
//  Created by Mac on 29/09/22.
//

import Foundation

struct AddEventServiceProvider {
    private let httpUtility: HttpUtility
    
    init(httpUtility: HttpUtility) {
        self.httpUtility = httpUtility
    }
    
    func getEventsTypes(completion: @escaping(_ result: Result<EventTypeResponseModel, CHError>)-> Void) {
        guard let url = URL(string: APIEndPoint.getEventTypes.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(url: url, resultType: EventTypeResponseModel.self) { result in
            completion(result)
        }
    }
    
}

struct EventTypeResponseModel: Codable {
    let status: Bool
    let data: [EventTypeModel]
    let image: String
    let message: String
    
    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
        case image = "image"
        case message = "message"
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
