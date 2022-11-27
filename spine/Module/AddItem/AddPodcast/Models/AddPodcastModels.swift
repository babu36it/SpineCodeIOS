//
//  AddPodcastModels.swift
//  spine
//
//  Created by Mac on 18/10/22.
//

import Foundation

enum RssStaus {
    case success
    case failure
}

struct ValidateRssResponseModel: Codable {
    let status: Bool
    let message: String
}

struct RssOtpResponseModel: Codable {
    let status: Bool
    let message: String
    let otp: String?
}

//RSS data models
struct RssDataResponseModel: Codable {
    let status: Bool
    let message: String
    let data: RssDataModel
}

struct RssDataModel: Codable {
    let status: String
    let feed: RssFeedModel
    let items: [RssItemModel]
    let user: RssUserModel?
}


struct RssFeedModel: Codable {
    let url: String
    let title: String
    let link: String
    let author: String
    let description: String
    let image: String
}

struct RssItemModel: Codable, Identifiable {
    let id = UUID()
    let title: String
    let pubDate: String
    let link: String
    let guid: String
    let author: String
    let thumbnail: String
    let description: String
    let content: String
    let enclosure: RssEnclosureModel
    let like: Int
    let favourite: String
    let time: String
}

struct RssEnclosureModel: Codable {
    let link: String
    let type: String
}

struct RssUserModel: Codable {
    let user_id: String
    let user_name: String
    let user_image: String
}

//Language list
struct LanguageModel: Codable {
    let id, name, iso6391, status: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case iso6391 = "iso_639-1"
        case status
    }
}

struct ItemModel: Identifiable {
    let id: String
    let name: String
}

//Category list
struct CategryModel: Codable {
    let id: String
    let categoryName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case categoryName = "category_name"
    }
}

//Sub-Category list
struct SubCategoryModel: Codable {
    let id: String
    let parentId: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case parentId = "parent_id"
        case name = "subcategory_name"
    }
}

//add podcast sub category
struct GeneralResponseModel: Codable {
    let status: Bool
    let message: String
}

class AddPodcastData {
    static let shared = AddPodcastData()
    var rssLink = ""
}
