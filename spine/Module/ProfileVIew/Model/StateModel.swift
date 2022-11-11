//
//  StateModel.swift
//  Populist
//
//  Created by Bharat Jadav on 05/07/21.
//

import Foundation

struct StateModel : Codable {
    let id          : AnyCodableValue?
    let name        : AnyCodableValue?
    let countryid   : AnyCodableValue?
    
    enum CodingKeys: String, CodingKey {
        case id             = "id"
        case name           = "name"
        case countryid      = "country_id"
    }
}

struct CityModel : Codable {
    let id          : AnyCodableValue?
    let name        : AnyCodableValue?
    let stateid     : AnyCodableValue?
    
    enum CodingKeys: String, CodingKey {
        case id             = "id"
        case name           = "name"
        case stateid        = "state_id"
    }
}
