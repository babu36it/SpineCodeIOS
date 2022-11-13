//
//  CurrenciesListService.swift
//  spine
//
//  Created by Mac on 13/11/22.
//

import Foundation

//Language list
struct CurrenciesListResponse: Codable {
    let status: Bool
    let data: [CurrencyModel]?
    let message: String
}

struct CurrencyModel: Codable {
    let id, country, currency, code: String
    let symbol: String
}

class CurrenciesListService {
    private let httpUtility: HttpUtility
    
    init(httpUtility: HttpUtility) {
        self.httpUtility = httpUtility
    }
    
    func getCurrencies(completion: @escaping(_ result: Result<CurrenciesListResponse, CHError>) -> Void) {
        guard let languagesList = URL(string: APIEndPoint.currency.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(url: languagesList, resultType: CurrenciesListResponse.self) { result in
            completion(result)
        }
    }
    
    func updateCurrency(to currency: CurrencyModel, completion: @escaping(_ result: Result<EditProfileResponseModel, CHError>) -> Void) {
        completion(.success(.init(status: true, message: "Successfully updated language.")))
//        guard let updateAuthorization = URL(string: APIEndPoint.updateLanguage.urlStr) else {
//            completion(.failure(.invalidUrl))
//            return
//        }
//        httpUtility.requestData(httpMethod: .post, postData: ["currency": currency.id], url: updateAuthorization, resultType: EditProfileResponseModel.self) { result in
//            completion(result)
//        }
    }
}
