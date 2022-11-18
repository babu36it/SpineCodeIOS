//
//  LanguagesListService.swift
//  spine
//
//  Created by Mac on 13/11/22.
//

import Foundation

class LanguagesListService {
    private let httpUtility: HttpUtility
    
    init(httpUtility: HttpUtility) {
        self.httpUtility = httpUtility
    }
    
    func getLanguages(completion: @escaping(_ result: Result<LanguageListResponse, CHError>) -> Void) {
        if let jsonData: Data = FileManager.default.fileDataFromCachesDirectory(for: "languages.json"), let response: LanguageListResponse = try? JSONDecoder().decode(LanguageListResponse.self, from: jsonData) {
            completion(.success(response))
        } else {
            guard let languagesList = URL(string: APIEndPoint.languages.urlStr) else {
                completion(.failure(.invalidUrl))
                return
            }
            httpUtility.requestData(url: languagesList, resultType: LanguageListResponse.self) { result in
                if let jsonData: Data = try? JSONEncoder().encode(result.get()) {
                    FileManager.default.saveDataToCachesDirectory(jsonData, filename: "languages.json")
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
}
