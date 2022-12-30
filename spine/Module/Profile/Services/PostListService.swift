//
//  PostListService.swift
//  spine
//
//  Created by Mac on 23/12/22.
//

import Foundation

class PostListService {
    private let httpUtility: HttpUtility = .shared
    
    func getPosts(page: Int = 0, perPage: Int = 10, userId: String = "0", followers: String = "0", onlyUserPost: String = "0", completion: @escaping (_ result: Result<PageListAPIResponse<PostItem>, CHError>) -> Void) {
        guard let url = URL(string: String(format: APIEndPoint.getPosts.urlStr, page, perPage, userId, followers, onlyUserPost)) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.getData(url: url, resultType: PageListAPIResponse<PostItem>.self, queue: .main, completion: completion)
    }
}
