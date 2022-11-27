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
    private struct Constants {
        static let currenciesFilename: String = "currencies.json"
    }

    private let httpUtility: HttpUtility = .shared
    
    func getCurrencies(completion: @escaping(_ result: Result<APIResponseModel<[CurrencyModel]>, CHError>) -> Void) {
        if let jsonData: Data = FileManager.default.fileDataFromCachesDirectory(for: Constants.currenciesFilename), let response = try? JSONDecoder().decode(APIResponseModel<[CurrencyModel]>.self, from: jsonData) {
            completion(.success(response))
        } else {
            guard let languagesList = URL(string: APIEndPoint.currency.urlStr) else {
                completion(.failure(.invalidUrl))
                return
            }
            httpUtility.requestData(url: languagesList, resultType: APIResponseModel<[CurrencyModel]>.self) { result in
                if let jsonData: Data = try? JSONEncoder().encode(result.get()) {
                    FileManager.default.saveDataToCachesDirectory(jsonData, filename: Constants.currenciesFilename)
                }
                completion(result)
            }
        }
    }
    
    func updateCurrency(to currency: CurrencyModel, completion: @escaping(_ result: Result<EditProfileResponseModel, CHError>) -> Void) {
        guard let updateCurrency = URL(string: APIEndPoint.updateCurrency.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(httpMethod: .post, postData: ["currency_id": currency.id], url: updateCurrency, resultType: EditProfileResponseModel.self) { result in
            completion(result)
        }
    }
    
    class func currency(for id: String, completion: @escaping (CurrencyModel?) -> Void) {
        CurrenciesListService().getCurrencies { result in
            DispatchQueue.main.async {
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
}
