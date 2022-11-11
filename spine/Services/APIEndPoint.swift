//
//  APIEndPoint.swift
//  spine
//
//  Created by Mac on 27/09/22.
//

import Foundation

let baseUrl = "https://thespiritualnetwork.com/api/v1/"

enum APIEndPoint: String {
    case loginUsers = "login/loginUsers"
    case getEventTypes = "events/getEventTypes"
    //add podcast
    case validateRss = "podcasts/validateRss"
    case rssEmailOTPVerification = "podcasts/sendEmailOTPVerification"
    case getRssData = "/podcasts/getRssData"
    case languages = "/languages"
    case getPodcastsCategory = "/podcasts/getPodcastsCategory"
    case getPodcastsSubcategoryByIds = "/podcasts/getPodcastsSubcategoryByIds"
    case addPodcastsSubcategory = "/podcasts/addPodcastsSubcategory"
    case addPodcasts = "/podcasts/addPodcasts"
    
    case editProfile = "/profile/profileEdit"
    case userDetails = "/userDetails"

    var urlStr: String {
        return baseUrl + self.rawValue
    }
}
