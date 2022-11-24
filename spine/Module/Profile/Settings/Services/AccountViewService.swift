//
//  AccountViewService.swift
//  spine
//
//  Created by Mac on 19/11/22.
//

import Foundation

struct AccountViewService {
    private let httpUtility: HttpUtility = .shared
    
    func getAccountSettings(completion: @escaping(_ result: Result<AccountSettingResponseModel, CHError>) -> Void) {
        guard let accountSettings = URL(string: APIEndPoint.userAccountSettings.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(url: accountSettings, resultType: AccountSettingResponseModel.self) { result in
            completion(result)
        }
    }
}
