//
//  PodcastItem.swift
//  spine
//
//  Created by Mac on 21/12/22.
//

import Foundation

struct PodcastItem {
    let thumbnailImage: String
    let title: String
    let language: String
    let duration: String
    let username: String
    let userImage: String
    let playCount: Int
    let favCount: Int
    let episodeCount: Int
    
    init(podcast: PodcastDetail) {
        self.thumbnailImage = podcast.rssDetail.image
        self.title = podcast.rssDetail.title
        self.language = podcast.rssDetail.language
        self.duration = ""
        self.username = podcast.username
        self.userImage = podcast.userImage
        self.playCount = -1
        self.favCount = -1
        self.episodeCount = podcast.rssDetail.episodes
    }
    
    init(episode: PodcastEpisodeDetail) {
        self.thumbnailImage = episode.thumbnail
        self.title = episode.title
        self.language = episode.language
        self.duration = episode.duration
        self.username = episode.userName
        self.userImage = episode.userImage
        self.playCount = episode.playCount
        self.favCount = episode.favCount
        self.episodeCount = -1
    }
}
