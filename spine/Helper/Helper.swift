//
//  Helper.swift
//  spine
//
//  Created by Mac on 26/10/22.
//

import Foundation

class Helper {
    
    static func getUrlString(itemType: ItemType) -> String {
        switch itemType {
        case .language:
            return APIEndPoint.languages.urlStr
        default:
            return ""
        }
    }

}
