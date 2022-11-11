//
//  Error.swift
//  spine
//
//  Created by Mac on 27/09/22.
//

import Foundation

enum CHError: String, Error {
    case parsingError = "Parsing Error"
    case invalidUrl = "Invalid url"
    case postBodyCreation = "Post body creation error"
    case invalidToken = "Token is not valid"
    case otherError = "Other Error"
    case authFailed = "Not able to authenticate user"
    case badData = "Bad data"
    case tokenExpired = "Token Expired"
}

extension CHError: Identifiable {
    var id: Int {
        self.hashValue
    }
}
