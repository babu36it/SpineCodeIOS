//
//  HttpUtility.swift
//  spine
//
//  Created by Mac on 27/09/22.
//

import Foundation

struct HttpUtility {
    
    func requestData<T: Decodable>(refresh: Bool = false, httpMethod: HTTPMethod = .get, postData: [String:Any]? = nil, url: URL, resultType: T.Type, completion: @escaping(_ result: Result<T, CHError>)-> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        //request.addValue("application/form-data", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(AppUtility.shared.userSettings.authToken, forHTTPHeaderField: "Authorization") //AppUtility.shared.userSettings.authToken
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
                        //Wrong number of segments
                        AppUtility.shared.userSettings.authToken = ""
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
                //Wrong number of segments
                AppUtility.shared.userSettings.authToken = ""
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
