//
//  PostModel.swift
//  spine
//
//  Created by Mac on 22/12/22.
//

import Foundation

// MARK: - EventAPIResponse
struct PageListAPIResponse<T: Codable>: Codable {
    let status: Bool?
    let data: [T]?
    let currentPage, currentPerPage: String?
    let profilImage, image: String?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case status, data, image, message
        case currentPage = "current_page"
        case currentPerPage = "current_per_page"
        case profilImage = "profil_image"
    }
}

// MARK: - Datum
struct PostItem: Codable {
    let id, userID, type, title: String?
    let hashtagIDS: String?
    let postBackroundColorID: String?
    let multiplity: String?
    let files, markFriends, placeLink, eventLocation: String?
    let status, eventPost, eventID, featurePost: String?
    let featurePostLink: String?
    let featureAdminApprove, createdOn: String?
    let updatedOn: String?
    let postUserName: String?
    let postUserDisplayName, profilePic: String?
    let accountMode: String?
    let totalComment, totalLike, totalSave, totalShare: Int?
    let userLikeStatus, userSaveStatus, followStatus: Int?

    enum CodingKeys: String, CodingKey {
        case id, type, title, multiplity, files, status
        case userID = "user_id"
        case hashtagIDS = "hashtag_ids"
        case postBackroundColorID = "post_backround_color_id"
        case markFriends = "mark_friends"
        case placeLink = "place_link"
        case eventLocation = "event_location"
        case eventPost = "event_post"
        case eventID = "event_id"
        case featurePost = "feature_post"
        case featurePostLink = "feature_post_link"
        case featureAdminApprove = "feature_admin_approve"
        case createdOn = "created_on"
        case updatedOn = "updated_on"
        case postUserName = "post_user_name"
        case postUserDisplayName = "post_user_display_name"
        case profilePic = "profile_pic"
        case accountMode = "account_mode"
        case totalComment = "total_comment"
        case totalLike = "total_like"
        case totalSave = "total_save"
        case totalShare = "total_share"
        case userLikeStatus = "user_like_status"
        case userSaveStatus = "user_save_status"
        case followStatus = "follow_status"
    }
}

struct FollowerItem: Codable, Identifiable {
    let tblUserID, userName, userDisplayName, bio: String?
    let profilePic, id, userID, followUserID: String?
    let privateReq, createdOn: String?
    let _isFollow: Int?

    enum CodingKeys: String, CodingKey {
        case id, bio
        case tblUserID = "tbl_users_user_id"
        case userName = "tbl_users_user_name"
        case userDisplayName = "tbl_users_user_display_name"
        case profilePic = "profile_pic"
        case userID = "user_id"
        case followUserID = "follow_user_id"
        case privateReq = "private_req"
        case createdOn = "created_on"
        case _isFollow = "is_follow"
    }
}

extension FollowerItem {
    func userImage(forPath path: String?) -> String? {
        if let path = path, let profilePic = profilePic, !path.isEmpty, !profilePic.isEmpty {
            return "\(path)\(profilePic)"
        }
        return nil
    }
    
    var isFollowing: Bool {
        (_isFollow ?? 0) == 1
    }
}
