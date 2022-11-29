//
//  EventCategoryListService.swift
//  spine
//
//  Created by Mac on 28/11/22.
//

import Foundation

class EventCategoryListService {
    private let httpUtility: HttpUtility = .shared
    
    func getEventCategories(completion: @escaping(_ result: Result<APIResponseModel<[EventCategoryModel]>, CHError>) -> Void) {
        guard let url = URL(string: APIEndPoint.getEventCategories.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.getCachedResponse(url: url, cachedFilename: CachedFileNames.eventCategories, completion: completion)
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
