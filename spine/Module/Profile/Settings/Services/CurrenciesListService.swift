//
//  CurrenciesListService.swift
//  spine
//
//  Created by Mac on 13/11/22.
//

import Foundation

//Language list
struct CurrencyModel: Codable {
    let id, country, currency, code: String
    let symbol: String
}

class CurrenciesListService {
    private let httpUtility: HttpUtility = .shared
    
    func getCurrencies(completion: @escaping(_ result: Result<APIResponseModel<[CurrencyModel]>, CHError>) -> Void) {
        guard let url = URL(string: APIEndPoint.currency.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.getCachedResponse(url: url, cachedFilename: CachedFileNames.currencies, queue: .main, completion: completion)
    }
    
    func updateCurrency(to currency: CurrencyModel, completion: @escaping(_ result: Result<GenericPostAPIResponse, CHError>) -> Void) {
        guard let updateCurrency = URL(string: APIEndPoint.updateCurrency.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(httpMethod: .post, postData: ["currency_id": currency.id], url: updateCurrency, resultType: GenericPostAPIResponse.self) { result in
            completion(result)
        }
    }
    
    class func currency(for id: String, completion: @escaping (CurrencyModel?) -> Void) {
        CurrenciesListService().getCurrencies { result in
            switch result {
            case .success(let currenciesRes):
                let currModel = currenciesRes.data?.first { $0.id == id }
                completion(currModel)
            case .failure(let error):
                print(error)
            }
        }
    }
}
