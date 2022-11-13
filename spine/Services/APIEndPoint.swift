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
    case languages = "languages"
    case currency = "currency"
    case getPodcastsCategory = "/podcasts/getPodcastsCategory"
    case getPodcastsSubcategoryByIds = "/podcasts/getPodcastsSubcategoryByIds"
    case addPodcastsSubcategory = "/podcasts/addPodcastsSubcategory"
    case addPodcasts = "/podcasts/addPodcasts"
    
    case editProfile = "/profile/profileEdit"
    case userDetails = "/userDetails"
    case uploadProfilePic = "/profile/userProfilePic"
    case uploadBgProfilePic = "profile/userBgProfilePic"
    case updateUserEmail = "requestToChangeEmail"

    case messagingAuthorization = "eventMessagingAutho"
    
    case mobileNotifications = "mobileAllNotification"
    case emailNotifications = "emailAllNotification"

    var urlStr: String {
        return baseUrl + rawValue
    }
}
