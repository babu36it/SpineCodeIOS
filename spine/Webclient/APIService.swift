//
//  APIService.swift


import Foundation
import UIKit

var kInternetConnectionMessage = "Please check your internet connection"
var kTryAgainLaterMessage = "Please try again later"
var kErrorDomain = "Error"
var kDefaultErrorCode = 1234

class GeneralResponse<T : Codable> : Codable {
//    var code: Int = 0
    var message : String?
    var data    : T?
    var token   : String?
    var status  : Int?
    
    enum CodingKeys: String, CodingKey {
        case message    = "message"
        case data       = "data"
        case token      = "token"
        case status     = "status"
    }
    
    required init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            if let msgProperty = try? container.decode(Int.self, forKey: .status) {
                status = msgProperty
            }
            if let msgProperty = try? container.decode(String.self, forKey: .message) {
                message = msgProperty 
            }
            if let tokenProperty = try? container.decode(String.self, forKey: .token) {
                token = tokenProperty
            }
            if let objProperty = try? container.decode(T.self, forKey: .data) {
                data = objProperty
            }
        }
    }
}

class GeneralWitoutData : Codable {
//    var code: Int = 0
    var message : String?
    var token   : String?
    var status  : Int?
    
    enum CodingKeys: String, CodingKey {
        case message    = "message"
        case token      = "token"
        case status     = "status"
    }
    
    required init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            if let msgProperty = try? container.decode(Int.self, forKey: .status) {
                status = msgProperty
            }
            if let msgProperty = try? container.decode(String.self, forKey: .message) {
                message = msgProperty
            }
            if let tokenProperty = try? container.decode(String.self, forKey: .token) {
                token = tokenProperty
            }
        }
    }
}

//struct ErrorModel: Codable {
//    var code: Int?
//    var codeMessage: String?
//    var message: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case code           = "code"
//        case codeMessage    = "codeMessage"
//        case message        = "message"
//    }
//}

enum ServerErrorCode: Int {
    case success = 200
    case userNotFound = 404
    case none = 0
    case userInActive = 400
    case sessionExpire = 401
}

enum Session: Int {
    case active = 1
    case expire = 2
}

enum EndPoint: String {
    case dev = "http://162.214.165.52/~pirituc5/apisecure/" /// development environment
   // case prod     = "http://162.214.165.52/~pirituc5/apisecure" /// live environment
}

enum HTTPMethod : String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}

enum ApiResource : String {
    //User Auth
    case userLogin              = "login/loginUsers"
    case userRegister           = "users/register"
    case userCheckPhone         = "users/check-phone"
    case userResetPassword      = "users/reset-password"
    
    //User Management
    case userProfile            = "users/profile"
    case userUpdateProfile      = "users/update-profile"
    case userIsProfileCompelete = "users/is_profile_complete"
    case userChangePassword     = "users/change-password"
    case userUpdatePhone        = "users/update-phone"
    case userChangeNotiPref     = "users/change-notification-preferance"
    
    //Ballots Management
    case ballotCategory         = "ballot/categories?"
    case ballotList             = "ballot/list?"
    case submitBallot           = "ballot/submit"
    
    
    //Location Management
    case locationGetStates      = "locations/getStates?country_id="
    case locationGetCities      = "locations/getCities?state_id="
    
    //CMS
    case cmsPagesTermsCondition = "cms?type=1"
    case cmsPagesPrivacyPolicy  = "cms?type=2"
    case cmsPagesLicence        = "cms?type=3"
    
    //Notifictaion Module
    case getNotification = "notifications?"
    case readUnReadNotification = "notifications/changeReadStatus"
    case deleteAllNotification = "notifications/deleteAll"
}

class APIService {
    static let shared = APIService()
    let requestTimeout = 10.0
    let session = URLSession.shared
    
    /// Get request
    func requestWithGet<T:Codable>(resourceType: ApiResource, value: String = "", requestType:HTTPMethod, completion : @escaping ResultCompletion<T?>) {
        var strUrl = ""
        strUrl = EndPoint.dev.rawValue + resourceType.rawValue + value
        strUrl = strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        AppUtility.shared.printToConsole("URL = \(strUrl)")
        guard let url = URL(string:strUrl) else {
            return
        }
        var request = URLRequest(url: url)
        let user = "devpankaj"
        let password = "devpankaj"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        request.setValue("Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")
        request.setValue("123run", forHTTPHeaderField: "X-API-KEY")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                AppUtility.shared.apiResponseMessage = error.localizedDescription
                return completion(.failure(error))
            }
            guard let data = data else {return}
            let jsonDecoder = JSONDecoder()
            do {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                AppUtility.shared.printToConsole(json as Any)
                let empData = try jsonDecoder.decode(GeneralResponse<T>.self, from: data)
                AppUtility.shared.apiResponseMessage = empData.message ?? ""
                if empData.data == nil {
                    if let statusCode = (response as? HTTPURLResponse)?.statusCode,
                       statusCode != ServerErrorCode.success.rawValue {
                        AppUtility.shared.apiErrorCode = statusCode
                        let err = NSError(domain: kErrorDomain, code: statusCode, userInfo: [NSLocalizedDescriptionKey: empData.message ?? ""])
//                        return completion(.failure(err as Error))
                        AppUtility.shared.showCustomAlert(alertType: .error, message: "", actionButtonTitle: nil, cancelButtonTitle: K.appButtonTitle.ok) { action in                            
                            AppUtility.shared.redirectToLoginScreen()
                            return completion(.failure(err as Error))
                        }
//                        AppUtility.shared.showAlertWith("", empData.message ?? "") { status in
//                            if status ?? false {
//                                if statusCode == ServerErrorCode.sessionExpire.rawValue {
//                                    AppUtility.shared.redirectToLoginScreen()
//                                }
//                            }
//                            return completion(.failure(err as Error))
//                        }
                    }
                    return completion(.success(empData as? T))
                }
                else {
                    return  completion(.success(empData.data))
                }
            } catch let error {
                AppUtility.shared.apiResponseMessage = error.localizedDescription
                return  completion(.failure(error))
            }
        }.resume()
    }
    
    /// Post methos
    func requestWithPost<T:Codable>(resourceType:ApiResource, requestType:HTTPMethod, queryParameters:NSDictionary, completion : @escaping ResultCompletion<T?>) {
        
        guard let url = URL(string:EndPoint.dev.rawValue + resourceType.rawValue) else {
            return
        }
        AppUtility.shared.printToConsole("URL = \(url)")
        AppUtility.shared.printToConsole("Params = \(queryParameters)")
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: requestTimeout)
        request.httpMethod = requestType.rawValue
        let user = "devpankaj"
        let password = "devpankaj"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        request.setValue("Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")
        request.setValue("123run", forHTTPHeaderField: "X-API-KEY")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        guard let requestBody = try? JSONSerialization.data(withJSONObject: queryParameters, options:[]) else {
            return
        }
        request.httpBody = requestBody
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                AppUtility.shared.apiResponseMessage = error.localizedDescription
                return completion(.failure(error))
            }
            
            guard let data = data else {return}
            let jsonDecoder = JSONDecoder()
            do {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                AppUtility.shared.printToConsole(json as Any)
                let empData = try jsonDecoder.decode(GeneralResponse<T>.self, from: data)
                AppUtility.shared.apiResponseMessage = empData.message ?? ""
                if empData.data == nil {
                    if let statusCode = (response as? HTTPURLResponse)?.statusCode,
                       statusCode != ServerErrorCode.success.rawValue {
                        let err = NSError(domain: kErrorDomain, code: statusCode, userInfo: [NSLocalizedDescriptionKey: empData.message ?? ""])
                        return completion(.failure(err as Error))
                    }
                    return completion(.success(empData as? T))
                }
                else {
                    AppUtility.shared.printToConsole("Auth Token : \(empData.token ?? "")")
                    if AppUtility.shared.userSettings.authToken == "" {
                        AppUtility.shared.userSettings.authToken = empData.token ?? ""
                    }
                    return completion(.success(empData.data))
                }
            } catch let error {
                AppUtility.shared.apiResponseMessage = error.localizedDescription
                return completion(.failure(error))
            }
        }.resume()
    }
}
