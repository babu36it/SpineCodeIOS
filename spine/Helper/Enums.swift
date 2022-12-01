//
//  Enums.swift
//  spine
//
//  Created by Mac on 15/06/22.
//

import Foundation
import SwiftUI

enum CalnderType {
    case date
    case time
}

enum ItemType: String {
    case language
    case category
    case timezone
    case location
    case currency
    case performance
    case desease
}

enum EventType: String, CaseIterable, Identifiable {
    var id: String {
        rawValue
    }
    case local
    case online
    case retreat
    case metaverse
    
    func getTitle() -> String {
        switch self {
        case .local:
            return "Local event"
        case .online:
            return "Online Event"
        case .retreat:
            return "Retreat"
        case .metaverse:
            return "Metaverse Event"
        }
    }
    
    func getDescription() -> String {
        switch self {
        case .local:
            return "Requires max 24h meeting in a physical location"
        case .online:
            return "Virtual event/livestream experience on the web(Zoom, You Tube etc.)"
        case .retreat:
            return "Spiritual gateways for 2+ days, spiritual vacation"
        case .metaverse:
            return "Coachings, Lessons, Readings and Speaches that take place in the"
        }
    }
}


enum EventsHomeTabType: String, CaseIterable {
    case none
    case all = "ALL"
    case going = "GOING"
    case saved = "SAVED"
    case following = "FOLLOWING"
    case online = "ONLINE"
    case meta = "META"
    case nearby = "NEARBY"
    case past = "PAST"
    
    static func allTabs()->[EventsHomeTabType] {
        return [.all, .going, .saved, .following, .online, .meta, .nearby, .past]
    }
    
}

enum Invitation {
    case accepted
    case notAccepted
    case pending
    case none
    
    func imageName()-> (String, Color) {
        switch self {
        case .accepted:
            return ("checkmark.circle.fill", .green)
        case .notAccepted:
            return ("multiply.circle.fill", .black)
        case .pending:
            return ("checkmark.circle.fill", .gray)
        case .none:
            return ("", .primary)
        }
    }
    
    func getTitle()-> String {
        switch self {
        case .accepted:
            return "You are going"
        case .notAccepted:
            return "You we not accepted"
        case .pending:
            return "Waiting to be accepted"
        case .none:
            return ""
        }
    }
}

enum EventSheetType: Identifiable {
    var id: Int { hashValue }
    case filter
    case mapView
}


enum PaymentType: String {
    case creditCard = "Credit Card"
    case paypal = "PayPal"
    case bankAccount = "Bank Account"
}

enum ActivityTabType: String {
    case you = "YOU"
    case following = "FOLLOWING"
}
