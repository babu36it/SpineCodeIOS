//
//  EventModel.swift
//  spine
//
//  Created by Mac on 22/11/22.
//

import Foundation

class EventModel: ObservableObject, Codable, Identifiable {
    var id: String = ""
    var userID: String = ""
    var title: String = ""
    var file: String = ""
    var multiple: String = ""
    var type: String = ""
    var startTime: String = ""
    var startDate: String = ""
    var endTime: String = ""
    var endDate: String = ""
    var acctualStartDatetime: String = ""
    var acctualEndDatetime: String = ""
    var timezone: String = ""
    var location: String = ""
    var latitude: String = ""
    var longitude: String = ""
    var linkOfEvent: String = ""
    var joinEventLink: String = ""
    var eventDescription: String = ""
    var eventCategories: String = ""
    var eventSubcategories: String = ""
    var fee: String = ""
    var feeCurrency: String = ""
    var bookingURL: String = ""
    var maxAttendees: String = ""
    var language: String = ""
    var acceptParticipants: String = ""
    var allowComments: String = ""
    var status: String = ""
    var createdOn: String = ""
    var updatedOn: String = ""
    var languageName: String = ""
    var userName: String = ""
    var useDisplayName: String = ""
    var hostedProfilePic: String = ""
    var currencyCountry: String = ""
    var currencyName: String = ""
    var currencyCode: String = ""
    var currencySymbol: String = ""
    var typeName: String = ""
    var totalComment: String = ""
    var totalSave: String = ""
    var totalShare: String = ""
    var userShareStatus: Int = 0
    var userSaveStatus: Int = 0

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
        case totalComment = "total_comment"
        case totalSave = "total_save"
        case totalShare = "total_share"
        case userShareStatus = "user_share_status"
        case userSaveStatus = "user_save_status"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        userID = try container.decodeIfPresent(String.self, forKey: .userID) ?? ""
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        file = try container.decodeIfPresent(String.self, forKey: .file) ?? ""
        multiple = try container.decodeIfPresent(String.self, forKey: .multiple) ?? ""
        type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        startTime = try container.decodeIfPresent(String.self, forKey: .startTime) ?? ""
        startDate = try container.decodeIfPresent(String.self, forKey: .startDate) ?? ""
        endTime = try container.decodeIfPresent(String.self, forKey: .endTime) ?? ""
        endDate = try container.decodeIfPresent(String.self, forKey: .endDate) ?? ""
        acctualStartDatetime = try container.decodeIfPresent(String.self, forKey: .acctualStartDatetime) ?? ""
        acctualEndDatetime = try container.decodeIfPresent(String.self, forKey: .acctualEndDatetime) ?? ""
        timezone = try container.decodeIfPresent(String.self, forKey: .timezone) ?? ""
        location = try container.decodeIfPresent(String.self, forKey: .location) ?? ""
        latitude = try container.decodeIfPresent(String.self, forKey: .latitude) ?? ""
        longitude = try container.decodeIfPresent(String.self, forKey: .longitude) ?? ""
        linkOfEvent = try container.decodeIfPresent(String.self, forKey: .linkOfEvent) ?? ""
        joinEventLink = try container.decodeIfPresent(String.self, forKey: .joinEventLink) ?? ""
        eventDescription = try container.decodeIfPresent(String.self, forKey: .eventDescription) ?? ""
        eventCategories = try container.decodeIfPresent(String.self, forKey: .eventCategories) ?? ""
        eventSubcategories = try container.decodeIfPresent(String.self, forKey: .eventSubcategories) ?? ""
        fee = try container.decodeIfPresent(String.self, forKey: .fee) ?? ""
        feeCurrency = try container.decodeIfPresent(String.self, forKey: .feeCurrency) ?? ""
        bookingURL = try container.decodeIfPresent(String.self, forKey: .bookingURL) ?? ""
        maxAttendees = try container.decodeIfPresent(String.self, forKey: .maxAttendees) ?? ""
        language = try container.decodeIfPresent(String.self, forKey: .language) ?? ""
        acceptParticipants = try container.decodeIfPresent(String.self, forKey: .acceptParticipants) ?? ""
        allowComments = try container.decodeIfPresent(String.self, forKey: .allowComments) ?? ""
        status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
        createdOn = try container.decodeIfPresent(String.self, forKey: .createdOn) ?? ""
        updatedOn = try container.decodeIfPresent(String.self, forKey: .updatedOn) ?? ""
        languageName = try container.decodeIfPresent(String.self, forKey: .languageName) ?? ""
        userName = try container.decodeIfPresent(String.self, forKey: .userName) ?? ""
        useDisplayName = try container.decodeIfPresent(String.self, forKey: .useDisplayName) ?? ""
        hostedProfilePic = try container.decodeIfPresent(String.self, forKey: .hostedProfilePic) ?? ""
        currencyCountry = try container.decodeIfPresent(String.self, forKey: .currencyCountry) ?? ""
        currencyName = try container.decodeIfPresent(String.self, forKey: .currencyName) ?? ""
        currencyCode = try container.decodeIfPresent(String.self, forKey: .currencyCode) ?? ""
        currencySymbol = try container.decodeIfPresent(String.self, forKey: .currencySymbol) ?? ""
        typeName = try container.decodeIfPresent(String.self, forKey: .typeName) ?? ""
        totalComment = try container.decodeIfPresent(String.self, forKey: .totalComment) ?? ""
        totalSave = try container.decodeIfPresent(String.self, forKey: .totalSave) ?? ""
        totalShare = try container.decodeIfPresent(String.self, forKey: .totalShare) ?? ""
        userShareStatus = try container.decodeIfPresent(Int.self, forKey: .userShareStatus) ?? 0
        userSaveStatus = try container.decodeIfPresent(Int.self, forKey: .userSaveStatus) ?? 0
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(userID, forKey: .userID)
        try container.encode(title, forKey: .title)
        try container.encode(file, forKey: .file)
        try container.encode(multiple, forKey: .multiple)
        try container.encode(type, forKey: .type)
        try container.encode(startTime, forKey: .startTime)
        try container.encode(startDate, forKey: .startDate)
        try container.encode(endTime, forKey: .endTime)
        try container.encode(endDate, forKey: .endDate)
        try container.encode(acctualStartDatetime, forKey: .acctualStartDatetime)
        try container.encode(acctualEndDatetime, forKey: .acctualEndDatetime)
        try container.encode(timezone, forKey: .timezone)
        try container.encode(location, forKey: .location)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(linkOfEvent, forKey: .linkOfEvent)
        try container.encode(joinEventLink, forKey: .joinEventLink)
        try container.encode(eventDescription, forKey: .eventDescription)
        try container.encode(eventCategories, forKey: .eventCategories)
        try container.encode(eventSubcategories, forKey: .eventSubcategories)
        try container.encode(fee, forKey: .fee)
        try container.encode(feeCurrency, forKey: .feeCurrency)
        try container.encode(bookingURL, forKey: .bookingURL)
        try container.encode(maxAttendees, forKey: .maxAttendees)
        try container.encode(language, forKey: .language)
        try container.encode(acceptParticipants, forKey: .acceptParticipants)
        try container.encode(allowComments, forKey: .allowComments)
        try container.encode(status, forKey: .status)
        try container.encode(createdOn, forKey: .createdOn)
        try container.encode(updatedOn, forKey: .updatedOn)
        try container.encode(languageName, forKey: .languageName)
        try container.encode(userName, forKey: .userName)
        try container.encode(useDisplayName, forKey: .useDisplayName)
        try container.encode(hostedProfilePic, forKey: .hostedProfilePic)
        try container.encode(currencyCountry, forKey: .currencyCountry)
        try container.encode(currencyName, forKey: .currencyName)
        try container.encode(currencyCode, forKey: .currencyCode)
        try container.encode(currencySymbol, forKey: .currencySymbol)
        try container.encode(typeName, forKey: .typeName)
        try container.encode(totalComment, forKey: .totalComment)
        try container.encode(totalSave, forKey: .totalSave)
        try container.encode(totalShare, forKey: .totalShare)
        try container.encode(userShareStatus, forKey: .userShareStatus)
        try container.encode(userSaveStatus, forKey: .userSaveStatus)
    }
    
    init() { }
}

extension EventModel {
    var eventDurationDateString: String {
        var dtStr: String = ""
        if let startDate: Date = startDate.toDate(format: "yyyy-MM-dd") {
            dtStr = startDate.toString(format: "EEE, dd MMM yyyy")
        }
        if let endDate: Date = endDate.toDate(format: "yyyy-MM-dd") {
            dtStr.append(" - ")
            dtStr.append(endDate.toString(format: "EEE, dd MMM yyyy"))
        }
        return dtStr
    }
    
    var eventDurationTimeString: String {
        var dtStr: String = ""
        if let startTime: Date = startTime.toDate(format: "HH:mm:ss") {
            dtStr.append(startTime.toString(format: "HH:mm"))
        }
        dtStr.append(" - ")
        if let endTime: Date = endTime.toDate(format: "HH:mm:ss") {
            dtStr.append(endTime.toString(format: "HH:mm"))
        }
        dtStr.append(" \(timezone)")
        return dtStr
    }
    
    var dateString: String {
        var dtStr: String = ""
        if let startDate: Date = startDate.toDate(format: "yyyy-MM-dd") {
            dtStr = startDate.toString(format: "dd MMM")
        }
        
        if let endDate: Date = endDate.toDate(format: "yyyy-MM-dd") {
            dtStr.append(" - ")
            dtStr.append(endDate.toString(format: "dd MMM yyyy"))
        }
        
        if let endTime: Date = endTime.toDate(format: "HH:mm:ss") {
            dtStr.append(", ")
            dtStr.append(endTime.toString(format: "HH:mm"))
        }
        return dtStr
    }
    
    func imageURLs(for path: String?) -> [String]? {
        if let path = path, !file.isEmpty {
            let filenames: [String] = file.components(separatedBy: ",")
                
            return filenames.map { "\(path)\($0)" }
        }
        return nil
    }
    
    var formBody: [String: Any] {
        var formB: [String: Any] = [:]
        
        formB["type"] = type
        formB["allow_comments"] = Int(allowComments) ?? 0
        formB["title"] = title
        formB["description"] = eventDescription
        formB["start_date"] = startDate
        formB["start_time"] = startTime
        formB["end_date"] = endDate
        formB["end_time"] = endTime
        formB["timezone"] = timezone
        formB["location"] = location
        formB["latitude"] = latitude
        formB["longitude"] = longitude
        formB["link_of_event"] = linkOfEvent
        formB["join_event_link"] = joinEventLink
        formB["event_categories"] = eventCategories
        formB["event_subcategories"] = eventSubcategories
        formB["fee"] = Double(fee) ?? 0
        formB["fee_currency"] = feeCurrency
        formB["max_attendees"] = maxAttendees
        formB["language"] = language
        formB["accept_participants"] = acceptParticipants
        formB["booking_url"] = bookingURL
        formB["status"] = 1 // 0 for draft , 1 for publish
        
        return formB
    }
    
    var eventDays: String {
        if let startDate: Date = startDate.toDate(format: "yyyy-MM-dd"), let endDate: Date = endDate.toDate(format: "yyyy-MM-dd") {
            let calendar = Calendar.current
            let daysPassed = calendar.startOfDay(for: endDate).daysInBetweenDate(calendar.startOfDay(for: startDate))
            if daysPassed > 1 {
                return "\(daysPassed) days"
            } else if daysPassed == 1 {
                return "\(daysPassed) day"
            } else if !startTime.isEmpty, !endTime.isEmpty {
                return "\(startTime) - \(endTime)"
            }
        }
        return ""
    }
    
    func cost(_ completion: @escaping (String) -> Void) {
        if let feeVal = Double(fee), feeVal > 0 {
            CurrenciesListService.currency(for: feeCurrency) { [weak self] model in
                guard let self = self else {
                    completion("FREE")
                    return
                }
                
                if let model = model {
                    let formatter = NumberFormatter()
                    formatter.numberStyle = .currency
                    formatter.minimumFractionDigits = 0
                    formatter.maximumFractionDigits = 2
                    formatter.currencySymbol = model.symbol

                    if let price = formatter.string(from: feeVal as NSNumber) {
                        completion(price)
                    } else {
                        completion("$\(self.fee)")
                    }
                } else {
                    completion("$\(self.fee)")
                }
            }
        } else {
            completion("FREE")
        }
    }
}
