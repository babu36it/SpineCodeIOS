//
//  EventsServices.swift
//  spine
//
//  Created by Mac on 22/11/22.
//

import Foundation

class EventServices: CommonEventFetcher {
    private let httpUtility: HttpUtility = .shared

    func getEventAttendees(for eventID: String, completion: @escaping(_ result: Result<EventAttendeeListResponse, CHError>)-> Void) {
        guard let url = URL(string: String(format: APIEndPoint.getEventAttendee.urlStr, eventID)) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.getData(url: url, resultType: EventAttendeeListResponse.self, queue: .main, completion: completion)
    }
    
    func getEventComments(for eventID: String, completion: @escaping(_ result: Result<EventCommentsAPIResponse, CHError>)-> Void) {
        guard let url = URL(string: String(format: APIEndPoint.getEventComments.urlStr, eventID)) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.getData(url: url, resultType: EventCommentsAPIResponse.self, queue: .main, completion: completion)
    }
    
    func getCommentReplies(for commentID: String, completion: @escaping(_ result: Result<EventCommentsAPIResponse, CHError>)-> Void) {
        guard let url = URL(string: String(format: APIEndPoint.getEventCommentReplies.urlStr, commentID)) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.getData(url: url, resultType: EventCommentsAPIResponse.self, queue: .main, completion: completion)
    }
    
    func postEventComment(for eventID: String, parentCommentID: String, comment: String, userID: String, completion: @escaping(_ result: Result<GenericPostAPIResponse, CHError>)-> Void) {
        guard let url = URL(string: APIEndPoint.postEventComment.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        let postData: [String: String] = ["spine_event_id": eventID, "user_id": userID, "comment_id": parentCommentID, "comment": comment]
        httpUtility.requestData(httpMethod: .post, postData: postData, url: url, resultType: GenericPostAPIResponse.self, queue: .main, completion: completion)
    }
}
