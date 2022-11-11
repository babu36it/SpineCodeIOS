//
//  CategoryModel.swift
//  Populist
//
//  Created by Bharat Jadav on 30/06/21.
//

import Foundation

struct CategoryModel : Codable, Identifiable {
    let id = UUID()
    let index : Int?
    let name : String?
    let isSubmitted : Bool?
    
    enum CodingKeys: String, CodingKey {
        case index  = "id"
        case name   = "name"
        case isSubmitted = "is_submitted"
    }
}
