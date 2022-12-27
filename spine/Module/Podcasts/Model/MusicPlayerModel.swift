//
//  MusicPlayerModel.swift
//  spine
//
//  Created by Mac on 27/12/22.
//

import Foundation

struct MusicPlayerModel {
    let episodeNumber: String
    let title: String
    let subtitle: String
    let authorImage: String
    let authorName: String
    let audioPath: String
    
    init(feed: RssFeedModel?, item: RssItemModel?, user: RssUserModel?) {
        self.episodeNumber = "EPISODE - #3"
        self.title = item?.title ?? "NA"
        self.subtitle = feed?.title ?? "NA"
        self.authorName = item?.author ?? "NA"
        self.authorImage = user?.user_image ?? "NA"
        self.audioPath = ""
    }
    
    init(episode: PodcastEpisodeDetail) {
        self.episodeNumber = "EPISODE - #3"
        self.title = episode.title
        self.subtitle = "NA"
        self.authorName = episode.author
        self.authorImage = episode.userImage
        self.audioPath = ""
    }
}
