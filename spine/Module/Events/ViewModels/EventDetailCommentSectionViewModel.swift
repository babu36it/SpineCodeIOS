//
//  EventDetailCommentSectionViewModel.swift
//  spine
//
//  Created by Mac on 04/12/22.
//

import Foundation

struct EventCommentsAPIResponse: Decodable {
    let status: Bool?
    let data: [EventComment]?
    let userImage: String?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case status, data, message
        case userImage = "user_image"
    }
}

// MARK: - EventComment
struct EventComment: Decodable, Identifiable {
    let id, spineEventID, userID, parentCommentID: String?
    let comment, createdOn, postUserName, postUserDisplayName: String?
    let profilePic: String?

    enum CodingKeys: String, CodingKey {
        case id, comment
        case spineEventID = "spine_event_id"
        case userID = "user_id"
        case parentCommentID = "parent_comment_id"
        case createdOn = "created_on"
        case postUserName = "post_user_name"
        case postUserDisplayName = "post_user_display_name"
        case profilePic = "profile_pic"
    }
}

extension EventComment {
    func getUserImage(for serverPath: String?) -> String? {
        if let serverPath = serverPath, let image = profilePic, !serverPath.isEmpty, !image.isEmpty {
            return "\(serverPath)\(image)"
        }
        return nil
    }
}

class EventDetailCommentSectionViewModel: ObservableObject {
    private let service: EventServices = .init()
    
    let event: EventModel
    
    private var eventCommentsResponse: EventCommentsAPIResponse? {
        didSet {
            comments = eventCommentsResponse?.data ?? []
        }
    }
    
    @Published var comments: [EventComment] = []
    @Published var commentReplies: [String: EventCommentsAPIResponse] = [:]

    var serverUserImagePath: String? { eventCommentsResponse?.userImage }
    
    init(event: EventModel) {
        self.event = event
    }
    
    func userImageFor(_ comment: EventComment) -> String? {
        if let serverPath: String = eventCommentsResponse?.userImage, let profilePic: String = comment.profilePic, !serverPath.isEmpty, !profilePic.isEmpty {
            return "\(serverPath)\(profilePic)"
        }
        return nil
    }
    
    func getComments(for eventID: String) {
        if !eventID.isEmpty {
            service.getEventComments(for: eventID) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.eventCommentsResponse = response
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func getCommentReplies(for commentID: String?) {
        if let commentID = commentID, !commentID.isEmpty {
            service.getCommentReplies(for: commentID) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.commentReplies[commentID] = response
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    func postComment(_ commentText: String, eventID: String, userID: String, parentCommentID: String = "0", completion: @escaping (Bool, CHError?) -> Void) {
        if !eventID.isEmpty, !commentText.isEmpty, !userID.isEmpty {
            service.postEventComment(for: eventID, parentCommentID: parentCommentID, comment: commentText, userID: userID) { result in
                switch result {
                case .success:
                    completion(true, nil)
                case .failure(let error):
                    print(error)
                    completion(false, error)
                }
            }
        }
    }
}
