//
//  MessagingSettingsViewService.swift
//  spine
//
//  Created by Mac on 13/11/22.
//

import Foundation

// MARK: - AccountSettingResponseModel
struct AccountSettingResponseModel: Codable {
    let status: Bool
    let data: AccountSettingModel
    let message: String
}

// MARK: - AccountSettingModel
struct AccountSettingModel: Codable {
    let id, userID, messageAuth, eventCalenderStatus: String
    let mNotify, mLikeNotify, mCommentNotify, mUpdateAndReminders: String
    let mSaveEventReminder, mMesage, mFollow, mSpineImpulses: String
    let mAnyPost, eNotify, eEventAttach, eMessage: String
    let eCommentReply, eEventPodcast, eUpdateFromSpine, eSpineSurveys: String
    let pFindability, pPersonalized, pCustomization, pNecessary: String
    let status, creationDate, modificationDate: String

    enum CodingKeys: String, CodingKey {
        case id, status
        case userID = "user_id"
        case messageAuth = "message_auth"
        case eventCalenderStatus = "event_calender_status"
        case mNotify = "m_notify"
        case mLikeNotify = "m_like_notify"
        case mCommentNotify = "m_comment_notify"
        case mUpdateAndReminders = "m_update_and_reminders"
        case mSaveEventReminder = "m_save_event_reminder"
        case mMesage = "m_mesage"
        case mFollow = "m_follow"
        case mSpineImpulses = "m_spine_impulses"
        case mAnyPost = "m_any_post"
        case eNotify = "e_notify"
        case eEventAttach = "e_event_attach"
        case eMessage = "e_message"
        case eCommentReply = "e_comment_reply"
        case eEventPodcast = "e_event_podcast"
        case eUpdateFromSpine = "e_update_from_spine"
        case eSpineSurveys = "e_spine_surveys"
        case pFindability = "p_findability"
        case pPersonalized = "p_personalized"
        case pCustomization = "p_customization"
        case pNecessary = "p_necessary"
        case creationDate = "creation_date"
        case modificationDate = "modification_date"
    }
}

struct MessagingSettingsViewService {
    private let httpUtility: HttpUtility = .shared
    
    func getMessageAuthorizationStatus(completion: @escaping(_ result: Result<AccountSettingResponseModel, CHError>) -> Void) {
        guard let updateAuthorization = URL(string: APIEndPoint.userAccountSettings.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(url: updateAuthorization, resultType: AccountSettingResponseModel.self) { result in
            completion(result)
        }
    }
    
    func updateMessagingAuthorization(_ status: String, completion: @escaping(_ result: Result<EditProfileResponseModel, CHError>) -> Void) {
        guard let updateAuthorization = URL(string: APIEndPoint.messagingAuthorization.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(httpMethod: .post, postData: ["message_auth": status], url: updateAuthorization, resultType: EditProfileResponseModel.self) { result in
            completion(result)
        }
    }
}
