//
//  EventModel.swift
//  spine
//
//  Created by Mac on 22/11/22.
//

import Foundation

struct UserEventResponseModel: Decodable {
    let status: Bool?
    let data: [EventModel]
    let image: String?
    let message: String?
}

struct EventModel: Decodable, Identifiable {
    let id, userID, title, file: String?
    let multiple, type, startTime, startDate: String?
    let endTime, endDate, acctualStartDatetime, acctualEndDatetime: String?
    let timezone, location, latitude, longitude: String?
    let linkOfEvent, joinEventLink: String?
    let eventDescription, eventCategories, eventSubcategories, fee: String?
    let feeCurrency, bookingURL, maxAttendees, language: String?
    let acceptParticipants, allowComments, status, createdOn: String?
    let updatedOn, languageName, userName, useDisplayName: String?
    let hostedProfilePic: String?
    let currencyCountry, currencyName, currencyCode, currencySymbol: String?
    let typeName: String?

    enum CodingKeys: String, CodingKey {
        case id, fee, title, file, multiple, type, timezone, location, latitude, longitude, status, language
        case userID = "user_id"
        case startTime = "start_time"
        case startDate = "start_date"
        case endTime = "end_time"
        case endDate = "end_date"
        case acctualStartDatetime = "acctual_start_datetime"
        case acctualEndDatetime = "acctual_end_datetime"
        case linkOfEvent = "link_of_event"
        case joinEventLink = "join_event_link"
        case eventDescription = "description"
        case eventCategories = "event_categories"
        case eventSubcategories = "event_subcategories"
        case feeCurrency = "fee_currency"
        case bookingURL = "booking_url"
        case maxAttendees = "max_attendees"
        case acceptParticipants = "accept_participants"
        case allowComments = "allow_comments"
        case createdOn = "created_on"
        case updatedOn = "updated_on"
        case languageName = "language_name"
        case userName = "user_name"
        case useDisplayName = "use_display_name"
        case hostedProfilePic = "hosted_profile_pic"
        case currencyCountry = "currency_country"
        case currencyName = "currency_name"
        case currencyCode = "currency_code"
        case currencySymbol = "currency_symbol"
        case typeName = "type_name"
    }
}

extension EventModel {
    var dateString: String {
        var dtStr: String = ""
        if let startDate: Date = startDate?.toDate(format: "yyyy-MM-dd") {
            dtStr = startDate.toString(format: "dd MMM")
        }
        
        if let endDate: Date = endDate?.toDate(format: "yyyy-MM-dd") {
            dtStr.append(" - ")
            dtStr.append(endDate.toString(format: "dd MMM yyyy"))
        }
        
        if let endTime: Date = endTime?.toDate(format: "HH:mm:ss") {
            dtStr.append(", ")
            dtStr.append(endTime.toString(format: "HH:mm"))
        }
        return dtStr
    }
}
