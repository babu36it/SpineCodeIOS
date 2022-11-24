//
//  HttpUtility.swift
//  spine
//
//  Created by Mac on 27/09/22.
//

import UIKit

struct Media {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/jpeg"
        self.filename = "\(Date().timeIntervalSince1970.rounded()).jpg"
        guard let data = image.jpegData(compressionQuality: 0.7) else { return nil }
        self.data = data
    }
}

struct HttpUtility {
    static let shared: HttpUtility = .init()
    
    private init() { }
    
    func uploadFiles<T: Decodable>(_ mediaFiles: [Media], toURL url: URL, queue: DispatchQueue? = nil, completion: @escaping(_ result: Result<T, CHError>) -> Void) {
        if mediaFiles.isEmpty { return }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        //create boundary
        let boundary = generateBoundary()
        //set content type
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if let authToken: String = AppUtility.shared.userInfo?.token {
            request.addValue(authToken, forHTTPHeaderField: "Authorization")
        }

        //call createDataBody method
        let dataBody = createDataBody(media: mediaFiles, boundary: boundary)
        request.httpBody = dataBody
        httpRequest(request, queue: queue, completion: completion)
    }
    
    func requestData<T: Decodable>(refresh: Bool = false, httpMethod: HTTPMethod = .get, postData: [String:Any]? = nil, url: URL, resultType: T.Type, queue: DispatchQueue? = nil, completion: @escaping(_ result: Result<T, CHError>)-> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        //request.addValue("application/form-data", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if let authToken: String = AppUtility.shared.userInfo?.token {
            request.addValue(authToken, forHTTPHeaderField: "Authorization")
        }
        if let data = postData {
            request.httpBody = self.getPostString(params: data).data(using: .utf8)
        }
        
        httpRequest(request, queue: queue, completion: completion)
    }
    
    func getData<T: Decodable>(request: URLRequest, resultType: T.Type, queue: DispatchQueue? = nil, completion: @escaping(_ result: Result<T, CHError>)-> Void){
        httpRequest(request, queue: queue, completion: completion)
    }
    
    func refreshToken(completion: @escaping(Bool) -> Void) {
        print("\(String(describing: self)) \(#function)")
        if let userCreds = AppUtility.shared.userCredentials {
            LoginViewModel.shared.signIn(emailId: userCreds.email, password: userCreds.password) { response, status in
                completion(status)
                
                print("tokenRefreshed")
            }
        } else {
            completion(false)
        }
    }
    
    // MARK: - Helper functions
    private func httpRequest<T: Decodable>(_ request: URLRequest, queue: DispatchQueue?, completion: @escaping(_ result: Result<T, CHError>)-> Void) {
        URLSession.shared.dataTask(with: request) { data, res, err in
            if let queue = queue {
                queue.async {
                    self.handleAPIResponse(request: request, queue: queue, data: data, response: res, error: err, completion: completion)
                }
            } else {
                handleAPIResponse(request: request, queue: queue, data: data, response: res, error: err, completion: completion)
            }
        }.resume()
    }
    
    private func getPostString(params: [String:Any]) -> String{
        var data = [String]()
        for(key, value) in params {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }

    private func createDataBody(withParameters params: [String: Any]? = nil, media: [Media]?, boundary: String) -> Data {
       let lineBreak = "\r\n"
       var body = Data()
       if let parameters = params {
          for (key, value) in parameters {
             body.append("--\(boundary + lineBreak)")
             body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
             body.append("\(value as! String + lineBreak)")
          }
       }
       if let media = media {
          for photo in media {
             body.append("--\(boundary + lineBreak)")
             body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
             body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
             body.append(photo.data)
             body.append(lineBreak)
          }
       }
       body.append("--\(boundary)--\(lineBreak)")
       return body
    }
    
    private func generateBoundary() -> String {
       return "Boundary-\(NSUUID().uuidString)"
    }
    
    private func handleAPIResponse<T: Decodable>(request: URLRequest, queue: DispatchQueue?, data: Data?, response: URLResponse?, error: Error?, completion: @escaping(_ result: Result<T, CHError>)-> Void) {
        let response = response as! HTTPURLResponse
        let errCode = response.statusCode
        
        switch errCode {
        case 200:
            print("Success")
            if error == nil && data != nil {
                do {
                    let results = try JSONDecoder().decode(T.self, from: data!)
                    completion(.success(results))
                } catch let err1 {
                    let resultURLStr: String = response.url?.absoluteString ?? ""
                    debugPrint("Error while parsing- \(err1.localizedDescription)- \(resultURLStr)")
                    completion(.failure(.parsingError))
                }
            }
            
        case 401:
            print("token time expired for request: \(request)") //delte existing token and refresh token
            //call refresh token here
            self.refreshToken { success in
                if success {
                    // get the updated token
                    if let authToken: String = AppUtility.shared.userInfo?.token {
                        var urlRequest: URLRequest = request
                        urlRequest.setValue(authToken, forHTTPHeaderField: "Authorization")
                        httpRequest(urlRequest, queue: queue, completion: completion)
                    } else {
                        completion(.failure(.tokenExpired))
                    }
                } else {
                    completion(.failure(.tokenExpired))
                }
            }

        default:
            print("all other case for request: \(request)")
            completion(.failure(.otherError))
        }
    }
}

struct LoginResponse: Codable {
    let status: Bool
    let token: String
    let token_type: StringLiteralType
    let expires_in: Int
    let message: String
}

extension Data {
   mutating func append(_ string: String) {
      if let data = string.data(using: .utf8) {
         append(data)
         print("data======>>>",data)
      }
   }
}
