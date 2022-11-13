//
//  NotificationTypeViewModel.swift
//  spine
//
//  Created by Mac on 13/11/22.
//

import SwiftUI

class PushNotificationViewModel: ObservableObject {
    var notifications: Bool = false
    var likes: Bool = false
    var comments: Bool = false
    var updatesAndReminders: Bool = false
    var eventReminders: Bool = false
    var messages: Bool = false
    var follows: Bool = false
    var impulses: Bool = false
    var anyPosts: Bool = false
}

class EmailNotificationViewModel: ObservableObject {
    var notifications: Bool = false
    var eventAttach: Bool = false
    var messages: Bool = false
    var comments: Bool = false
    var podcasts: Bool = false
    var updates: Bool = false
    var surveys: Bool = false
}

class NotificationTypeViewModel: ObservableObject {
    let serviceProvider = NotificationTypeService(httpUtility: HttpUtility())
    
    @Published var showLoader: Bool = false
    @Published var pushNotifications: PushNotificationViewModel = .init()
    @Published var emailNotifications: EmailNotificationViewModel = .init()
    
    func getPushNotificationStatus() {
        showLoader = true
        serviceProvider.getPushNotificationsStatus { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let apiRes):
                    self?.pushNotifications.notifications = apiRes.data?.notifications ?? false
                    self?.pushNotifications.likes = apiRes.data?.likes ?? false
                    self?.pushNotifications.comments = apiRes.data?.comments ?? false
                    self?.pushNotifications.updatesAndReminders = apiRes.data?.updatesAndReminders ?? false
                    self?.pushNotifications.eventReminders = apiRes.data?.eventReminders ?? false
                    self?.pushNotifications.messages = apiRes.data?.messages ?? false
                    self?.pushNotifications.follows = apiRes.data?.follows ?? false
                    self?.pushNotifications.impulses = apiRes.data?.impulses ?? false
                    self?.pushNotifications.anyPosts = apiRes.data?.anyPosts ?? false
                case .failure(let error):
                    print(error)
                }
                self?.showLoader = false
            }
        }
    }
    
    func getEmailNotificationStatus() {
        showLoader = true
        serviceProvider.getEmailNotificationsStatus { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let apiRes):
                    self?.emailNotifications.notifications = apiRes.data?.notifications ?? false
                    self?.emailNotifications.eventAttach = apiRes.data?.eventAttach ?? false
                    self?.emailNotifications.messages = apiRes.data?.messages ?? false
                    self?.emailNotifications.comments = apiRes.data?.comments ?? false
                    self?.emailNotifications.podcasts = apiRes.data?.podcasts ?? false
                    self?.emailNotifications.updates = apiRes.data?.updates ?? false
                    self?.emailNotifications.surveys = apiRes.data?.surveys ?? false
                case .failure(let error):
                    print(error)
                }
                self?.showLoader = false
            }
        }
    }
    
    func updateMobileNotificationStatus() {
        showLoader = true
        let params: [String: Any] = ["m_notify_status": pushNotifications.notifications,
                                     "m_like_notify_status": pushNotifications.likes,
                                     "m_comment_notify_status": pushNotifications.comments,
                                     "m_update_and_reminders_status": pushNotifications.updatesAndReminders,
                                     "m_save_event_reminders_status": pushNotifications.eventReminders,
                                     "m_message_status": pushNotifications.messages,
                                     "m_follow_status": pushNotifications.follows,
                                     "m_spine_impulse_status": pushNotifications.impulses,
                                     "m_any_post_status": pushNotifications.anyPosts]
        serviceProvider.updatePushNotificationStatus(params: params) { result in
            DispatchQueue.main.async { [weak self] in
//                switch result {
//                case .success(let success):
//                case .failure(let error)
//                }
                self?.showLoader = false
            }
        }
    }
    
    func updateEmailNotificationsStatus() {
        showLoader = true
        let params: [String: Any] = ["e_notify_status": emailNotifications.notifications,
                                     "e_event_attach_status": emailNotifications.eventAttach,
                                     "e_message_status": emailNotifications.messages,
                                     "e_comment_reply_status": emailNotifications.comments,
                                     "e_event_podcast_status": emailNotifications.podcasts,
                                     "e_update_from_spine_status": emailNotifications.updates,
                                     "e_spine_surveys_status": emailNotifications.surveys]
        serviceProvider.updateEmailNotificationStatus(params: params) { result in
            DispatchQueue.main.async { [weak self] in
//                switch result {
//                case .success(let success):
//                case .failure(let error)
//                }
                self?.showLoader = false
            }
        }
    }
}
