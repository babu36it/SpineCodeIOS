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
    
    func update(with accountSettings: AccountSettingModel) {
        notifications = accountSettings.mNotify.toBool() ?? false
        likes = accountSettings.mLikeNotify.toBool() ?? false
        comments = accountSettings.mCommentNotify.toBool() ?? false
        updatesAndReminders = accountSettings.mUpdateAndReminders.toBool() ?? false
        eventReminders = accountSettings.mSaveEventReminder.toBool() ?? false
        messages = accountSettings.mMesage.toBool() ?? false
        follows = accountSettings.mFollow.toBool() ?? false
        impulses = accountSettings.mSpineImpulses.toBool() ?? false
        anyPosts = accountSettings.mAnyPost.toBool() ?? false
    }
}

class EmailNotificationViewModel: ObservableObject {
    var notifications: Bool = false
    var eventAttach: Bool = false
    var messages: Bool = false
    var comments: Bool = false
    var podcasts: Bool = false
    var updates: Bool = false
    var surveys: Bool = false
    
    func update(with accountSettings: AccountSettingModel) {
        notifications = accountSettings.eNotify.toBool() ?? false
        eventAttach = accountSettings.eEventAttach.toBool() ?? false
        messages = accountSettings.eMessage.toBool() ?? false
        comments = accountSettings.eCommentReply.toBool() ?? false
        podcasts = accountSettings.eEventPodcast.toBool() ?? false
        updates = accountSettings.eUpdateFromSpine.toBool() ?? false
        surveys = accountSettings.eSpineSurveys.toBool() ?? false
    }
}

class NotificationTypeViewModel: ObservableObject {
    let serviceProvider = NotificationTypeService()
    
    @Published var showLoader: Bool = false
    @Published var pushNotifications: PushNotificationViewModel = .init()
    @Published var emailNotifications: EmailNotificationViewModel = .init()

    @Published var accountSettings: AccountSettingModel? {
        didSet {
            guard let accountSettings = accountSettings else { return }
            pushNotifications.update(with: accountSettings)
            emailNotifications.update(with: accountSettings)
        }
    }
    
    func getAccountSettings() {
        showLoader = true
        serviceProvider.getAccountSettings { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let apiRes):
                    self?.accountSettings = apiRes.data
                case .failure(let error):
                    print(error)
                }
                self?.showLoader = false
            }
        }
    }

    func updateMobileNotificationStatus() {
        showLoader = true
        let params: [String: Any] = ["m_notify_status": "\(pushNotifications.notifications ? 1 : 0)",
                                     "m_like_notify_status": "\(pushNotifications.likes ? 1 : 0)",
                                     "m_comment_notify_status": "\(pushNotifications.comments ? 1 : 0)",
                                     "m_update_and_reminders_status": "\(pushNotifications.updatesAndReminders ? 1 : 0)",
                                     "m_save_event_reminders_status": "\(pushNotifications.eventReminders ? 1 : 0)",
                                     "m_message_status": "\(pushNotifications.messages ? 1 : 0)",
                                     "m_follow_status": "\(pushNotifications.follows ? 1 : 0)",
                                     "m_spine_impulse_status": "\(pushNotifications.impulses ? 1 : 0)",
                                     "m_any_post_status": "\(pushNotifications.anyPosts ? 1 : 0)"]
        serviceProvider.updatePushNotificationStatus(params: params) { result in
            DispatchQueue.main.async { [weak self] in
//                switch result {
//                case .success(let success):
//                    print(success)
//                case .failure(let error):
//                    print(error)
//                }
                self?.showLoader = false
            }
        }
    }
    
    func updateEmailNotificationsStatus() {
        showLoader = true
        let params: [String: Any] = ["e_notify_status": "\(emailNotifications.notifications ? 1 : 0)",
                                     "e_event_attach_status": "\(emailNotifications.eventAttach ? 1 : 0)",
                                     "e_message_status": "\(emailNotifications.messages ? 1 : 0)",
                                     "e_comment_reply_status": "\(emailNotifications.comments ? 1 : 0)",
                                     "e_event_podcast_status": "\(emailNotifications.podcasts ? 1 : 0)",
                                     "e_update_from_spine_status": "\(emailNotifications.updates ? 1 : 0)",
                                     "e_spine_surveys_status": "\(emailNotifications.surveys ? 1 : 0)"]
        serviceProvider.updateEmailNotificationStatus(params: params) { result in
            DispatchQueue.main.async { [weak self] in
//                switch result {
//                case .success(let success):
//                    print(success)
//                case .failure(let error):
//                    print(error)
//                }
                self?.showLoader = false
            }
        }
    }
}
