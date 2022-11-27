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
    
    // profile
    case editProfile = "/profile/profileEdit"
    case userDetails = "/userDetails"
    case uploadProfilePic = "/profile/userProfilePic"
    case uploadBgProfilePic = "profile/userBgProfilePic"
    case updateUserEmail = "requestToChangeEmail"
    
    // settings
    case updateLanguage = "profile/updateProfileLanguage"
    case updateCurrency = "profile/updateProfileCurrency"
    case mobileNotifications = "mobileAllNotification"
    case emailNotifications = "emailAllNotification"
    case messagingAuthorization = "eventMessagingAutho"
    case saveEventToCalendar = "saveEventToCalender"
    case userAccountSettings = "userAccountSetting"
    
    // events
    case getUserEvents = "events/getUserEvents"
    case getEventCategories = "events/getEventsCategory"
    case timezones = "timezones"
    case publishEvent = "events/publishEvent"
    
    var urlStr: String {
        return baseUrl + rawValue
    }
}
