//
//  EditProfileService.swift
//  spine
//
//  Created by Mac on 09/11/22.
//

import Foundation

struct EditProfileResponseModel: Codable {
    let status: Bool
    let message: String
}

struct EditProfileService {
    private let httpUtility: HttpUtility
    
    init(httpUtility: HttpUtility) {
        self.httpUtility = httpUtility
    }
    
    func fetchUserDetails(completion: @escaping(_ result: Result<UserDetailResponse, CHError>)-> Void) {
        guard let url = URL(string: APIEndPoint.userDetails.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(url: url, resultType: UserDetailResponse.self) { result in
            completion(result)
        }
    }
    
    func saveProfile(postData: [String:Any]?, completion: @escaping(_ result: Result<EditProfileResponseModel, CHError>)-> Void) {
        guard let url = URL(string: APIEndPoint.editProfile.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(httpMethod: .post, postData: postData, url: url, resultType: EditProfileResponseModel.self) { result in
            completion(result)
        }
    }
    
}
