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
    
    func uploadFiles<T: Decodable>(_ mediaFiles: [Media], toURL url: URL, completion: @escaping(_ result: Result<T, CHError>) -> Void) {
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
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200:
                    do {
                        let results = try JSONDecoder().decode(T.self, from: data!)
                        completion(.success(results))
                    } catch let err1 {
                        let resultURLStr: String = response.url?.absoluteString ?? ""
                        debugPrint("Error while parsing- \(err1.localizedDescription)- \(resultURLStr)")
                        completion(.failure(.parsingError))
                    }
                case 401:
                    completion(.failure(.tokenExpired))
                default:
                    completion(.failure(.otherError))
                }
            }
        }.resume()
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
    
    func requestData<T: Decodable>(refresh: Bool = false, httpMethod: HTTPMethod = .get, postData: [String:Any]? = nil, url: URL, resultType: T.Type, completion: @escaping(_ result: Result<T, CHError>)-> Void) {
        
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
        
        //        self.getData(request: request, resultType: resultType) { result in
        //            completion(result)
        //        }
        URLSession.shared.dataTask(with: request) { data, res, err in
            let response = res as! HTTPURLResponse
            let errCode = response.statusCode
            
            switch errCode {
            case 200:
                print("Success")
                if err == nil && data != nil {
                    do {
                        let results = try JSONDecoder().decode(T.self, from: data!)
                        completion(.success(results))
                    } catch let err1 {
                        let resultURLStr: String = res?.url?.absoluteString ?? ""
                        debugPrint("Error while parsing- \(err1.localizedDescription)- \(resultURLStr)")
                        completion(.failure(.parsingError))
                    }
                }
                
            case 401:
                print("token time expired") //delte existing token and refresh token
                //call refresh token here
                self.refreshToken { success in
                    if success {
                        completion(.failure(.tokenExpired))
                    }
                }
                
            default:
                print("all other case")
                completion(.failure(.otherError))
            }
        }.resume()
    }
    
    func getData<T: Decodable>(request: URLRequest, resultType: T.Type, completion: @escaping(_ result: Result<T, CHError>)-> Void){
        //status code 201 - is failed, only 200 -is success
        URLSession.shared.dataTask(with: request) { data, res, err in
            let response = res as! HTTPURLResponse
            let errCode = response.statusCode
            
            switch errCode {
            case 200:
                print("Success")
                if err == nil && data != nil {
                    do {
                        let results = try JSONDecoder().decode(T.self, from: data!)
                        completion(.success(results))
                    } catch let err1 {
                        debugPrint("Error while parsing- \(err1.localizedDescription)")
                        completion(.failure(.parsingError))
                    }
                }
                
            case 401:
                print("token time expired") //delte existing token and refresh token
                //call refresh token here
                self.refreshToken() { success in
                    if success {
                        completion(.failure(.tokenExpired))
                    }
                }
                
            default:
                print("all other case")
                completion(.failure(.otherError))
            }
        }.resume()
    }
    
    func refreshToken(completion: @escaping(Bool) -> Void) {
        let params: [String: Any] = [:]
        guard let url = URL(string: APIEndPoint.loginUsers.urlStr) else {
            return
        }
        self.requestData(refresh: true, httpMethod: .post, postData: params, url: url, resultType: LoginResponse.self) { result in
            switch result {
            case .success(_):
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
    }
    
    func getPostString(params: [String:Any]) -> String{
        var data = [String]()
        for(key, value) in params {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
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
