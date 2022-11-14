//
//  APIRequest.swift
//  CNQR
//

import Foundation
import Alamofire
import ObjectMapper
public let IS_GO_LIVE   = false ///need to add on constant files

public enum EnvironmentType {
    case stagging
    case production
    var baseURL: String {
        switch self {
        case .stagging: return "https://thespiritualnetwork.com/api/v1/" ///staging URL
            ///http://162.214.165.52/~pirituc5/apisecure/
        case .production: return "https://thespiritualnetwork.com/api/v1/" ///production URL
            ///http://162.214.165.52/~pirituc5/apisecure/
        }
    }
}

public enum ErrorMessageType {
    case empty
    case other
    
    var description:String {
        switch self {
        case .empty:
            return "empty"
        default:
            return "general api failure"
        }
    }
}

public let currentEnvironment:EnvironmentType = IS_GO_LIVE ? .production : .stagging

enum APIAddress: URLRequestConvertible {
    case signin(parameters: Parameters)
    case signup(parameters: Parameters)
    case userAccountVerify(userID:String)
    case forgotpassword(parameters: Parameters)
    case userMobileVerification(parameters: Parameters)
    case socialLogin(parameters: Parameters)
    case resendEmailOTP(userID:String)
    
    var method: HTTPMethod {
        switch self {
        case .signin,.signup,.forgotpassword,.userMobileVerification,.socialLogin:
            return .post
        case .userAccountVerify, .resendEmailOTP:
            return .get
            //        case :
            //            return .delete
            //        case :
            //            return .put
        }
    }
    
    var path: String {
        switch self {
        case .socialLogin:
            return "login/socialLogin"
        case .signin:
            return "login/loginUsers"
        case .signup:
            return "login/registerUsers"
        case .userAccountVerify(let userID):
            return "login/accountVerify/\(userID)"
        case .forgotpassword:
            return "login/forgetPassword"
        case .userMobileVerification:
            return "login/verificationCodeOnMobile"
        case .resendEmailOTP:
            return "/login/reSendOtp/"
         default:
            return ""
        }
    }

    var parameter: Parameters? {
        switch self {
        case .socialLogin(let parameters),.signin(let parameters),.signup(let parameters),.forgotpassword(let parameters),.userMobileVerification(let parameters):
            return parameters
        case .userAccountVerify, .resendEmailOTP:
            return nil
        }
    }
    
    // MARK: URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try currentEnvironment.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        let user = "devpankaj"
        let password = "devpankaj"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        urlRequest.headers = ["Authorization":"Basic \(base64Credentials)", "X-API-KEY":"123run","Content-Type":"application/x-www-form-urlencoded"]
    
        print(urlRequest.headers)
        switch self {
        case .socialLogin(let parameters),.signin(let parameters),.signup(let parameters),.forgotpassword(let parameters),.userMobileVerification(let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            break
        default:
            break
        }
        print(urlRequest.description)
        return urlRequest
    }
    
    
}

struct APIRequest {
    let address: APIAddress
    init(_ address: APIAddress) {
        self.address = address
    }
}

enum MediaType : Int {
    case text   = 0
    case image  = 1
    case video  = 2
    case audio  = 3
    case file  = 4
    
    var mimeType: String {
        switch self {
        case.text:
            return ""
        case .image:
            return "jpg"
        case .video:
            return "mp4"
        case .audio:
            return "mp3"
        case .file:
            return "com.adobe.pdf"
        default:
            return ""
        }
    }
}

struct MediaAPIRequest {
    let address: APIAddress
    var mediaType: MediaType
    var mediaData: Data?
    var mediaFileURL: URL?
    var mediaFileName: String
    var uploadParamName: String
    
    init(_ address: APIAddress,
         mediaType: MediaType,
         mediaData: Data? = nil,
         mediaFileURL: URL? = nil,
         mediaFileName: String = "",
         uploadParamName: String) {
        self.address = address
        self.mediaType = mediaType
        self.mediaData = mediaData
        self.mediaFileURL = mediaFileURL
        self.mediaFileName = mediaFileName
        self.uploadParamName = uploadParamName
    }
}
