//
//  NotificationModels.swift
//  Populist
//
//  Created by Mitun Patel on 12/07/21.
//

import Foundation

struct NotificationResponseModel: Codable {
    let total_pages : AnyCodableValue?
    let res        : [NotificationModel]?
    
    enum CodingKeys: String, CodingKey {
        case total_pages = "total_pages"
        case res = "res"
    }
}

class NotificationModel: Codable, Identifiable {
    let id = UUID()
    var notficationId:CLong? = 0
    var title : String? = ""
    var desc : String? = ""
    var `type`:Int? = 0
    var date : String? = ""
    var isRead : Int? = 0
    var isExpand: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case notficationId = "id"
        case title = "title"
        case desc = "text"
        case date = "created_date"
        case isRead = "is_seen"
        case `type` = "type"
//        case isExpand = "isExpand"
    }
    
    init(title:String, desc:String, date:String) {
        self.title = title
        self.desc = desc
        self.date = date
    }
    
    func isNotificationRead() -> Bool {
        return (self.isRead ?? 0) == 1
    }
    
    func toDateValue() -> String {
        /////16-07-2021 10:10:14
        if let strDate = self.date,
           let strValue = Date(fromString: strDate, format: K.dateFomate.ddMMyyyy_HHmmss)?.timePassed() {
            return strValue
        }
        return ""
    }
}


