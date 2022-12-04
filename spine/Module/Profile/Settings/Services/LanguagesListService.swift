//
//  LanguagesListService.swift
//  spine
//
//  Created by Mac on 13/11/22.
//

import Foundation

class LanguagesListService {
    private let httpUtility: HttpUtility = .shared
    
    func getLanguages(completion: @escaping(_ result: Result<APIResponseModel<[LanguageModel]>, CHError>) -> Void) {
        guard let url = URL(string: APIEndPoint.languages.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }

        httpUtility.getCachedResponse(url: url, cachedFilename: CachedFileNames.languages, completion: completion)
    }
    
    func updateLanguage(to language: LanguageModel, completion: @escaping(_ result: Result<GenericPostAPIResponse, CHError>) -> Void) {
        guard let updateLanguage = URL(string: APIEndPoint.updateLanguage.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(httpMethod: .post, postData: ["language_id": language.id], url: updateLanguage, resultType: GenericPostAPIResponse.self) { result in
            completion(result)
        }
    }
    
    class func language(for id: String, completion: @escaping (LanguageModel?) -> Void) {
        LanguagesListService().getLanguages { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let languageRes):
                    let langModel = languageRes.data?.first { $0.id == id }
                    completion(langModel)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
