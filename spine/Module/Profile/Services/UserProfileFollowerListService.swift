//
//  UserProfileFollowerListService.swift
//  spine
//
//  Created by Mac on 29/12/22.
//

import Foundation

class UserProfileFollowerListService {
    private let httpUtility: HttpUtility = .shared
    
    func getFollowers(page: Int = 0, perPage: Int = 10, userId: String = "0", completion: @escaping (_ result: Result<PageListAPIResponse<FollowerItem>, CHError>) -> Void) {
        guard let url = URL(string: String(format: APIEndPoint.userFollowerList.urlStr, page, perPage, userId)) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.getData(url: url, resultType: PageListAPIResponse<FollowerItem>.self, queue: .main, completion: completion)
    }
}
