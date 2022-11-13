//
//  EditProfileService.swift
//  spine
//
//  Created by Mac on 09/11/22.
//

import UIKit

struct EditProfileResponseModel: Codable {
    let status: Bool
    let message: String
}

struct EditProfileService {
    private let httpUtility: HttpUtility
    
    init(httpUtility: HttpUtility) {
        self.httpUtility = httpUtility
    }
    
    func updateUserImage(_ image: UIImage, completion: @escaping(_ result: Result<EditProfileResponseModel, CHError>) -> Void) {
        uploadImage(image: image, to: APIEndPoint.uploadProfilePic.urlStr, completion: completion)
    }
    
    func updateUserBackgroundImage(_ image: UIImage, completion: @escaping(_ result: Result<EditProfileResponseModel, CHError>) -> Void) {
        uploadImage(image: image, to: APIEndPoint.uploadBgProfilePic.urlStr, completion: completion)
    }
    
    private func uploadImage(image: UIImage, to url: String, completion: @escaping(_ result: Result<EditProfileResponseModel, CHError>) -> Void) {
        guard let uploadUrl = URL(string: url) else {
            completion(.failure(.invalidUrl))
            return
        }
        if let mediaObj = Media(withImage: image, forKey: "image") {
            httpUtility.uploadFiles([mediaObj], toURL: uploadUrl) { result in
                completion(result)
            }
        }
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
