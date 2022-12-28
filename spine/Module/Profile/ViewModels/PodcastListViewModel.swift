//
//  PodcastListViewModel.swift
//  spine
//
//  Created by Mac on 28/12/22.
//

import Foundation

class PodcastListViewModel: ObservableObject {
    private let service: PodcastViewServiceProvider = .init()
    
    private var isAlreadyFetching: Bool = false

    private(set) var podcastResponse: PodcastResponse? {
        didSet {
            podcasts = podcastResponse?.data
        }
    }
    @Published var podcasts: [PodcastDetail]?
    
    func getPodcasts() {
        if !isAlreadyFetching {
            isAlreadyFetching = true
            service.getPodcasts(postData: nil) { [weak self] result in
                self?.isAlreadyFetching = false
                switch result {
                case .success(let res):
                    self?.podcastResponse = res
                case .failure(let err):
                    print(err)
                }
            }
        }
    }
}
