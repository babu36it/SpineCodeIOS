//
//  PodcastResponse.swift
//  spine
//
//  Created by Mac on 16/12/22.
//

import Foundation

struct PodcastResponse: Codable {
    let status: Bool
    let data: [PodcastDetail]
    let image: String
    let message: String
}

struct PodcastDetail: Codable, Hashable, Identifiable {
    let id: String
    let username: String
    let userId: String
    let userImage: String
    let resFeed: String
    let rssDetail: RssDetail
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case username = "user_name"
        case userId = "user_id"
        case userImage = "user_image"
        case resFeed = "rss_feed"
        case rssDetail = "rss_data"
    }
}

struct RssDetail: Codable, Hashable {
    let url: String
    let title: String
    let language: String
    let link: String
    let author: String
    let description: String
    let image: String
    let episodes: Int
}
