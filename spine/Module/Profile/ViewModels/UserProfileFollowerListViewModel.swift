//
//  UserProfileFollowerListViewModel.swift
//  spine
//
//  Created by Mac on 29/12/22.
//

import Foundation

class UserProfileFollowerListViewModel: ObservableObject {
    private let service: UserProfileFollowerListService = .init()
    
    private var followerAPIResponse: PageListAPIResponse<FollowerItem>? {
        didSet {
            if let followerItems: [FollowerItem] = followerAPIResponse?.data, !followerItems.isEmpty {
                if allFollowers == nil {
                    allFollowers = followerItems
                } else {
                    allFollowers?.append(contentsOf: followerItems)
                }
            }
        }
    }
    private var allFollowers: [FollowerItem]? {
        didSet {
            filterFollowers()
        }
    }
    private var isAlreadyFetching: Bool = false

    @Published var selectedTab: FollowTab = .followers
    @Published var searchTxt = "" {
        didSet {
            filterFollowers()
        }
    }
    @Published var followers: [FollowerItem]?
    @Published private(set) var shouldFetchNextBatch: Bool = true

    var userImagePath: String? {
        followerAPIResponse?.image
    }
    
    init(tab: FollowTab) {
        self.selectedTab = tab
    }
    
    private func filterFollowers() {
        if searchTxt.trimmed().isEmpty {
            followers = allFollowers
        } else {
            followers = allFollowers?.filter { ($0.userName?.lowercased().contains(searchTxt) ?? false) || ($0.userDisplayName?.lowercased().contains(searchTxt) ?? false) }
        }
    }
    
    func getFollowers(forUser userId: String) {
        if !isAlreadyFetching, shouldFetchNextBatch {
            isAlreadyFetching = true
            var page: Int = 1
            var pageLimit: Int = 10
            if let currentPage: Int = Int(followerAPIResponse?.currentPage ?? "0"), currentPage > 0 {
                page = currentPage + 1
            }
            if let currentPageLimit: Int = Int(followerAPIResponse?.currentPerPage ?? "0"), currentPageLimit > 0 {
                pageLimit = currentPageLimit
            }

            service.getFollowers(page: page, perPage: pageLimit, userId: userId) { [weak self] result in
                self?.isAlreadyFetching = false
                switch result {
                case .success(let res):
                    self?.followerAPIResponse = res
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
