//
//  CMSModel.swift
//  Populist
//
//  Created by Bharat Jadav on 30/06/21.
//

import Foundation

struct CMSModel : Codable {
    let id          : AnyCodableValue?
    let title       : AnyCodableValue?
    let desc        : AnyCodableValue?
    let type        : AnyCodableValue?
    let created_date : AnyCodableValue?
    let modified_date : AnyCodableValue?
    
    enum CodingKeys: String, CodingKey {
        case id             = "id"
        case title          = "title"
        case desc           = "description"
        case type           = "type"
        case created_date   = "created_date"
        case modified_date  = "modified_date"
    }
}
