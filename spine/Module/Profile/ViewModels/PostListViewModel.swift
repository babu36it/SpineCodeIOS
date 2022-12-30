//
//  PostListViewModel.swift
//  spine
//
//  Created by Mac on 23/12/22.
//

import Foundation

class PostListViewModel: ObservableObject {
    private let service: PostListService = .init()
    
    private var isAlreadyFetching: Bool = false
    @Published private(set) var shouldFetchNextBatch: Bool = true

    private(set) var postListResponse: PageListAPIResponse<PostItem>? {
        didSet {
            if let postItems: [PostItem] = postListResponse?.data, !postItems.isEmpty {
                if posts == nil {
                    posts = postItems
                } else {
                    posts?.append(contentsOf: postItems)
                }
            }
        }
    }
    @Published var posts: [PostItem]?
    
    func getPosts(forUser userId: String) {
        if !isAlreadyFetching, shouldFetchNextBatch {
            isAlreadyFetching = true
            var page: Int = 1
            var pageLimit: Int = 10
            if let currentPage: Int = Int(postListResponse?.currentPage ?? "0"), currentPage > 0 {
                page = currentPage + 1
            }
            if let currentPageLimit: Int = Int(postListResponse?.currentPerPage ?? "0"), currentPageLimit > 0 {
                pageLimit = currentPageLimit
            }

            service.getPosts(page: page, perPage: pageLimit, userId: userId) { [weak self] result in
                self?.isAlreadyFetching = false
                switch result {
                case .success(let res):
                    self?.postListResponse = res
                    let resItemsCount: Int = res.data?.count ?? 0
                    if resItemsCount < pageLimit {
                        self?.shouldFetchNextBatch = false
                    }
                case .failure(let err):
                    print(err)
                }
            }
        }
    }
}
