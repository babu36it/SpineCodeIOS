//
//  AccountViewService.swift
//  spine
//
//  Created by पंकज तेजावत on 19/11/22.
//

import Foundation

struct AccountViewService {
    private let httpUtility: HttpUtility
    
    init(httpUtility: HttpUtility) {
        self.httpUtility = httpUtility
    }
    
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
