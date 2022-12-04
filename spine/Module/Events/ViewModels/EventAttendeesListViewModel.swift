//
//  EventAttendeesListViewModel.swift
//  spine
//
//  Created by Mac on 03/12/22.
//

import Foundation

struct EventAttendeeListResponse: Decodable {
    let status: Bool?
    let data: [EventAttendee]?
    let profileImage, messageStatus, message: String?

    enum CodingKeys: String, CodingKey {
        case status, data, message
        case profileImage = "profile_image"
        case messageStatus = "message_status"
    }
}

// MARK: - EventAttendee
struct EventAttendee: Decodable, Identifiable {
    var id: String? { bookingID }
    let bookingID, userID, userName, displayName: String?
    let town, userEmail, bio, profilePic: String?
    let messageStatus: Int?

    enum CodingKeys: String, CodingKey {
        case bio, town
        case bookingID = "booking_id"
        case userID = "user_id"
        case userName = "user_name"
        case displayName = "display_name"
        case userEmail = "user_email"
        case profilePic = "profile_pic"
        case messageStatus = "message_status"
    }
}


class EventAttendeesListViewModel: ObservableObject {
    private let service: EventServices = .init()
    
    private var attendeesListResponse: EventAttendeeListResponse? {
        didSet {
            attendees = attendeesListResponse?.data ?? []
        }
    }
    
    @Published var attendees: [EventAttendee] = []
    
    func imageForAttendee(_ attendee: EventAttendee) -> String? {
        if let serverPath: String = attendeesListResponse?.profileImage, let profilePic: String = attendee.profilePic, !serverPath.isEmpty, !profilePic.isEmpty {
            return "\(serverPath)\(profilePic)"
        }
        return nil
    }
    
    func getAttendees(for eventID: String) {
        if !eventID.isEmpty {
            service.getEventAttendees(for: eventID) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.attendeesListResponse = response
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
