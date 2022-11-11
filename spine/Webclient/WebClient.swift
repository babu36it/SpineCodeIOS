//
//  WebClient.swift
//  CNQR
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

protocol APIResponse: Mappable {
    var status: String? { get }
    var message: String? { get }
    var data: Any? { get set }
    var errorMessage: String? { get }
}

class BaseDataHandeler: APIResponse {
    var status: String?
    var message: String?
    var data: Any?
    var errorMessage: String?
    
    required init?(map: Map){}
    
    func mapping(map: Map){
        status <- map["code"]
        message <- map["message"]
        data <- map["payload"]
        errorMessage <- map["error_message"]
    }
}

class ErrorModel: Mappable {
    var code: Int?
//    var codeMessage: String?
    var message: String?
//    var errorMessageType: ErrorMessageType?
    
    required init() {}
    required init?(map: Map){}
    
    func mapping(map: Map){
        code        <- map["code"]
        message     <- map["message"]
    }
}

class EroorMessageModel : Mappable{

    var id : String?
    var message : String?
    var messages : [EroorMessageModel]?

    required init(){ }
    
    required init?(map: Map) {}

    func mapping(map: Map) {
        id <- map["id"]
        message <- map["message"]
        messages <- map["messages"]
    }
}
class ErrorResponseModel : Mappable{

    var statusCode: Int?
    var messages: [EroorMessageModel]?
    var errorMessage: String?
    
    required init(){ }
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        statusCode <- map["status"]
        messages <- map["message"]
        errorMessage <- map["error"]
    }
}

struct ArrayContext: MapContext { }

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    class func isConnectedToInternetWithToast() -> Bool {
        let status = NetworkReachabilityManager()?.isReachable ?? false
        if !status {
           // ShowToast.show(toatMessage: "No Internet connection!")
        }
        return status
    }
}

typealias DownloadCompletionBlock = (_ filePath: String?, _ fileData: Data?, _ error: Error?) -> Void

struct AlamofireClient<T:BaseMappable> {
    static func responseObjectNew(_ request: APIRequest, completionHandler: @escaping (T?, ErrorResponseModel?) -> Void) {
        
        func isValidJson(from object:Any) -> Bool {
            guard let data = try? JSONSerialization.data(withJSONObject: object, options: []),
                let stringValue = String(data: data, encoding: String.Encoding.utf8) else {
                    return false
            }
            if stringValue.isEmpty || stringValue == "[]" {
                return false
            }
            return true
        }
        
        guard Connectivity.isConnectedToInternet() else {
            let errorModel = ErrorResponseModel()
            errorModel.errorMessage = "No Internet connection found"
            errorModel.statusCode = -1009
            return completionHandler(nil, errorModel)
        }
        AF.request(request.address)
            .validate(statusCode: 200..<510)
            .responseObject { (response: DataResponse<T, AFError>) in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success(let value):
                        print("response:\(value.toJSONString() ?? "")")
                        print(value.toJSON())
                            return completionHandler(Mapper<T>().map(JSON: value.toJSON()),nil)
                    case .failure(let afError):
                        print(afError.errorDescription ?? "")
                        let errorModel = ErrorResponseModel()
                        errorModel.errorMessage = afError.errorDescription
                        completionHandler(nil, errorModel)
                        break
                    }
                }
        }
    }
    
    static func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    static func responseObjectArray(_ request: APIRequest, completionHandler: @escaping ([T]?, ErrorModel?) -> Void) {
        
        guard Connectivity.isConnectedToInternet() else {
            let errorModel = ErrorModel()
            errorModel.message = "No Internet connection found"
            errorModel.code = -1009
            return completionHandler(nil, errorModel)
        }
        AF.request(request.address)
            .validate(statusCode: 200..<510)
            .responseObject { (response: DataResponse<BaseDataHandeler, AFError>) in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success(let value):
                        print("response:\(value.toJSONString() ?? ""))")
                        guard let data = value.data as? [[String:Any]], let status = value.status?.toInt(), status == 1 else {
                           completionHandler(nil, Mapper<ErrorModel>().map(JSON: value.toJSON()))
                            return
                        }
                        completionHandler(Mapper<T>().mapArray(JSONArray: data),nil)
                        break
                    case .failure(let afError):
                        print(afError.errorDescription ?? "")
                        let errorModel = ErrorModel()
                        errorModel.message = afError.errorDescription
                        completionHandler(nil, errorModel)
                        break
                    }
                }
        }
    }
    
 
    static func uploadMedia(_ request: MediaAPIRequest, queue: DispatchQueue? = nil , completionHandler: @escaping (T?, ErrorResponseModel?) -> Void) {
        
        guard Connectivity.isConnectedToInternet() else {
            let errorModel = ErrorResponseModel()
            errorModel.errorMessage = "No Internet connection found"
            errorModel.statusCode = -1009
            return completionHandler(nil, errorModel)
        }
        
        func isValidJson(from object:Any) -> Bool {
            guard let data = try? JSONSerialization.data(withJSONObject: object, options: []),
                let stringValue = String(data: data, encoding: String.Encoding.utf8) else {
                    return false
            }
            if stringValue.isEmpty || stringValue == "[]" {
                return false
            }
            return true
        }
        
      
        AF.upload(multipartFormData: { (multiPartFormData) in
            if let url = request.mediaFileURL {
               multiPartFormData.append(url, withName: request.uploadParamName, fileName:request.mediaFileName,  mimeType: request.mediaType.mimeType)
            } else if let data = request.mediaData {
                print(request.mediaType.mimeType)
                multiPartFormData.append(data, withName: request.uploadParamName, fileName: request.mediaFileName, mimeType: request.mediaType.mimeType)
            }
            
            if let parameters = request.address.parameter {
                for (key, value) in parameters {
                    print("key: \(key), value: \(value)")
                    multiPartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                }
            }
        }, with: request.address)
            .validate(statusCode: 200..<510)
            .responseObject { (response: DataResponse<T, AFError>) in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success(let value):
                        print("response:\(value.toJSONString() ?? ""))")
                     return completionHandler(Mapper<T>().map(JSON: value.toJSON()),nil)
                        break
                    case .failure(let afError):
                        print(afError.errorDescription ?? "")
                        let errorModel = ErrorResponseModel()
                        errorModel.errorMessage = afError.errorDescription
                        completionHandler(nil, errorModel)
                        break
                    }
                }
        }
    }
    static func uploadMultipleMedia(_ request: MediaAPIRequest, queue: DispatchQueue? = nil , completionHandler: @escaping (T?, ErrorResponseModel?) -> Void) {
        
        guard Connectivity.isConnectedToInternet() else {
            let errorModel = ErrorResponseModel()
            errorModel.errorMessage = "No Internet connection found"
            errorModel.statusCode = -1009
            return completionHandler(nil, errorModel)
        }
        
        func isValidJson(from object:Any) -> Bool {
            guard let data = try? JSONSerialization.data(withJSONObject: object, options: []),
                let stringValue = String(data: data, encoding: String.Encoding.utf8) else {
                    return false
            }
            if stringValue.isEmpty || stringValue == "[]" {
                return false
            }
            return true
        }
        
      
        AF.upload(multipartFormData: { (multiPartFormData) in
            if let data = UserDefaults.standard.data(forKey: "frontData"){
                multiPartFormData.append(data, withName: "files", fileName: request.mediaFileName, mimeType: request.mediaType.mimeType)
            }
            if let data = UserDefaults.standard.data(forKey: "rearData"){
                multiPartFormData.append(data, withName: "files_back", fileName: request.mediaFileName, mimeType: request.mediaType.mimeType)
            }
            
            if let parameters = request.address.parameter {
                for (key, value) in parameters {
                    print("key: \(key), value: \(value)")
                    multiPartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                }
            }
        }, with: request.address)
            .validate(statusCode: 200..<510)
            .responseObject { (response: DataResponse<T, AFError>) in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success(let value):
                        print("response:\(value.toJSONString() ?? ""))")
                     return completionHandler(Mapper<T>().map(JSON: value.toJSON()),nil)
                        break
                    case .failure(let afError):
                        print(afError.errorDescription ?? "")
                        let errorModel = ErrorResponseModel()
                        errorModel.errorMessage = afError.errorDescription
                        completionHandler(nil, errorModel)
                        break
                    }
                }
        }
    }
    
    static func downloadFile(url: String, atUrl: URL, downloadCompletionBlock: DownloadCompletionBlock?) -> DownloadRequest? {
        let destination: DownloadRequest.Destination = { _, _ in
            return (atUrl, [.removePreviousFile, .createIntermediateDirectories])
        }
        return AF.download(url, to: destination).response { response in
            if response.error == nil, let filePath = response.fileURL?.path {
                downloadCompletionBlock?(filePath, nil, nil)
            }
            else {
                downloadCompletionBlock?(nil, nil, response.error)
            }
        }
    }
}
