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
struct LanguageListResponse: Codable {
    let status: Bool
    let data: [LanguageModel]?
    let message: String
}

struct LanguageModel: Codable {
    let name: String
    let id: String
}


struct ItemModel: Identifiable {
    let name: String
    let id: String
}

//Category list
struct CategoryListResponse: Codable {
    let status: Bool
    let data: [CategryModel]?
    let message: String
}

struct CategryModel: Codable {
    let category_name: String
    let id: String
}


//Sub-Category list
struct SubCategoryResponse: Codable {
    let status: Bool
    let data: [SubCategoryModel]?
    let message: String
}

struct SubCategoryModel: Codable {
    let name: String
    let id: String
    let parentId: String
    
    enum CodingKeys: String, CodingKey {
        case name = "subcategory_name"
        case id
        case parentId = "parent_id"
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
