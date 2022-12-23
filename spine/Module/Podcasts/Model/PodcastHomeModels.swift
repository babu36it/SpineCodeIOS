//
//  PodcastHomeModels.swift
//  spine
//
//  Created by Mac on 16/12/22.
//

import Foundation

struct PodcastEpisodeCustomResponse: Codable {
    let status: Bool
    let data: [PodcastEpisodeCustom]
    let image: String
    let message: String
}

struct PodcastEpisodeCustom: Codable {
    let id: String
    let podcastEpisodes: [PodcastEpisodeDetail]
    
    enum CodingKeys: String, CodingKey {
        case id
        case podcastEpisodes = "podcast_episodes"
    }
}

struct PodcastEpisodeDetail: Codable, Hashable {
    let title: String
    let language: String
    let favCount: Int
    let playCount: Int
    let likeCount: Int
    let thumbnail: String
    let description: String
    let mediaLink: String
    let mediaType: String
    let duration: String
    let userName: String
    let userImage: String
    let author: String
    
    enum CodingKeys: String, CodingKey {
        case title, language, thumbnail, mediaLink, duration, author, description
        case favCount = "favourite_count"
        case playCount = "play_count"
        case likeCount = "like"
        case mediaType = "type"
        case userName = "user_name"
        case userImage = "user_image"
    }
}
