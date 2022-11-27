//
//  EventCategoryListService.swift
//  spine
//
//  Created by Mac on 28/11/22.
//

import Foundation

class EventCategoryListService {
    private struct Constants {
        static let eventCategoriesFilename: String = "event_categories.json"
    }

    private let httpUtility: HttpUtility = .shared
    
    func getEventCategories(completion: @escaping(_ result: Result<APIResponseModel<[EventCategoryModel]>, CHError>) -> Void) {
        if let jsonData: Data = FileManager.default.fileDataFromCachesDirectory(for: Constants.eventCategoriesFilename), let response: APIResponseModel<[EventCategoryModel]> = try? JSONDecoder().decode(APIResponseModel<[EventCategoryModel]>.self, from: jsonData) {
            completion(.success(response))
        } else {
            guard let eventCategoriesList = URL(string: APIEndPoint.getEventCategories.urlStr) else {
                completion(.failure(.invalidUrl))
                return
            }
            httpUtility.requestData(url: eventCategoriesList, resultType: APIResponseModel<[EventCategoryModel]>.self) { result in
                if let jsonData: Data = try? JSONEncoder().encode(result.get()) {
                    FileManager.default.saveDataToCachesDirectory(jsonData, filename: Constants.eventCategoriesFilename)
                }
                completion(result)
            }
        }
    }
    
    class func eventCategory(for name: String, completion: @escaping (EventCategoryModel?) -> Void) {
        EventCategoryListService().getEventCategories { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let categoryRes):
                    let categoryModel = categoryRes.data?.first { $0.categoryName == name }
                    completion(categoryModel)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
