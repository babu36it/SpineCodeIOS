//
//  ChangeEmailService.swift
//  spine
//
//  Created by Mac on 12/11/22.
//

import Foundation

struct ChangeEmailService {
    private let httpUtility: HttpUtility = .shared

    func updateUserEmail(_ toEmail: String, completion: @escaping(_ result: Result<GenericPostAPIResponse, CHError>) -> Void) {
        guard let updateEmail = URL(string: APIEndPoint.updateUserEmail.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(httpMethod: .post, postData: ["email": toEmail], url: updateEmail, resultType: GenericPostAPIResponse.self) { result in
            completion(result)
        }
    }
}
