//
//  LanguagesListService.swift
//  spine
//
//  Created by Mac on 13/11/22.
//

import Foundation

class LanguagesListService {
    private struct Constants {
        static let languageFilename: String = "languages.json"
    }

    private let httpUtility: HttpUtility = .shared
    
    func getLanguages(completion: @escaping(_ result: Result<APIResponseModel<[LanguageModel]>, CHError>) -> Void) {
        if let jsonData: Data = FileManager.default.fileDataFromCachesDirectory(for: Constants.languageFilename), let response: APIResponseModel<[LanguageModel]> = try? JSONDecoder().decode(APIResponseModel<[LanguageModel]>.self, from: jsonData) {
            completion(.success(response))
        } else {
            guard let languagesList = URL(string: APIEndPoint.languages.urlStr) else {
                completion(.failure(.invalidUrl))
                return
            }
            httpUtility.requestData(url: languagesList, resultType: APIResponseModel<[LanguageModel]>.self) { result in
                if let jsonData: Data = try? JSONEncoder().encode(result.get()) {
                    FileManager.default.saveDataToCachesDirectory(jsonData, filename: Constants.languageFilename)
                }
                completion(result)
            }
        }
    }
    
    func updateLanguage(to language: LanguageModel, completion: @escaping(_ result: Result<EditProfileResponseModel, CHError>) -> Void) {
        guard let updateLanguage = URL(string: APIEndPoint.updateLanguage.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(httpMethod: .post, postData: ["language_id": language.id], url: updateLanguage, resultType: EditProfileResponseModel.self) { result in
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
