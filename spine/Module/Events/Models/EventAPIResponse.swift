//
//  EventAPIResponse.swift
//  spine
//
//  Created by Mac on 01/12/22.
//

import Foundation

// MARK: - EventAPIResponse
struct EventAPIResponse: Decodable {
    let status: Bool?
    let data: [Records]?
    let currentPage, currentPerPage: String?
    let image, userImage: String?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case status, data, image, message
        case currentPage = "current_page"
        case currentPerPage = "current_per_page"
        case userImage = "user_image"
    }
    
    // MARK: - Records
    struct Records: Decodable {
        let startDate: String?
        let records: [EventModel]?

        enum CodingKeys: String, CodingKey {
            case startDate = "start_date"
            case records
        }
    }
}
