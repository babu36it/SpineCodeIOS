//
//  NotificationTypeService.swift
//  spine
//
//  Created by Mac on 13/11/22.
//

import Foundation

struct PushNotificationResponse: Codable {
    let status: Bool
    let data: PushNotificationModel?
    let message: String
}

struct EmailNotificationResponse: Codable {
    let status: Bool
    let data: EmailNotificationModel?
    let message: String
}

struct EmailNotificationModel: Codable {
    let notifications: Bool
    let eventAttach: Bool
    let messages: Bool
    let comments: Bool
    let podcasts: Bool
    let updates: Bool
    let surveys: Bool
    
    enum CodingKeys: String, CodingKey {
        case notifications = "e_notify_status"
        case eventAttach = "e_event_attach_status"
        case messages = "e_message_status"
        case comments = "e_comment_reply_status"
        case podcasts = "e_event_podcast_status"
        case updates = "e_update_from_spine_status"
        case surveys = "e_spine_surveys_status"
    }
}

struct PushNotificationModel: Codable {
    let notifications: Bool
    let likes: Bool
    let comments: Bool
    let updatesAndReminders: Bool
    let eventReminders: Bool
    let messages: Bool
    let follows: Bool
    let impulses: Bool
    let anyPosts: Bool
    
    enum CodingKeys: String, CodingKey {
        case notifications = "m_notify_status"
        case likes = "m_like_notify_status"
        case comments = "m_comment_notify_status"
        case updatesAndReminders = "m_update_and_reminders_status"
        case eventReminders = "m_save_event_reminders_status"
        case messages = "m_message_status"
        case follows = "m_follow_status"
        case impulses = "m_spine_impulse_status"
        case anyPosts = "m_any_post_status"
    }
}

class NotificationTypeService {
    private let httpUtility: HttpUtility
    
    init(httpUtility: HttpUtility) {
        self.httpUtility = httpUtility
    }
    
    func getPushNotificationsStatus(completion: @escaping(_ result: Result<PushNotificationResponse, CHError>) -> Void) {
        completion(.success(PushNotificationResponse(status: true, data: PushNotificationModel(notifications: true, likes: true, comments: true, updatesAndReminders: true, eventReminders: true, messages: true, follows: true, impulses: true, anyPosts: true), message: "Success")))
//        guard let languagesList = URL(string: APIEndPoint.pushNotifications.urlStr) else {
//            completion(.failure(.invalidUrl))
//            return
//        }
//        httpUtility.requestData(url: languagesList, resultType: PushNotificationResponse.self) { result in
//            completion(result)
//        }
    }
    
    func getEmailNotificationsStatus(completion: @escaping(_ result: Result<EmailNotificationResponse, CHError>) -> Void) {
        completion(.success(EmailNotificationResponse(status: true, data: EmailNotificationModel(notifications: true, eventAttach: true, messages: true, comments: true, podcasts: true, updates: true, surveys: true), message: "Success")))
//        guard let languagesList = URL(string: APIEndPoint.emailNotifications.urlStr) else {
//            completion(.failure(.invalidUrl))
//            return
//        }
//        httpUtility.requestData(url: languagesList, resultType: EmailNotificationResponse.self) { result in
//            completion(result)
//        }
    }
    
    func updatePushNotificationStatus(params: [String: Any], completion: @escaping(_ result: Result<EditProfileResponseModel, CHError>) -> Void) {
        guard let languagesList = URL(string: APIEndPoint.mobileNotifications.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(httpMethod: .post, postData: params, url: languagesList, resultType: EditProfileResponseModel.self) { result in
            completion(result)
        }
    }
    
    func updateEmailNotificationStatus(params: [String: Any], completion: @escaping(_ result: Result<EditProfileResponseModel, CHError>) -> Void) {
        guard let languagesList = URL(string: APIEndPoint.emailNotifications.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(httpMethod: .post, postData: params, url: languagesList, resultType: EditProfileResponseModel.self) { result in
            completion(result)
        }
    }
}
