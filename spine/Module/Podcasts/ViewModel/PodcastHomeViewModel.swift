//
//  PodcastHomeViewModel.swift
//  spine
//
//  Created by Mac on 16/12/22.
//

import Foundation

class PodcastHomeViewModel: ObservableObject {
    let serviceProvider = PodcastViewServiceProvider()
    @Published var podcastEpisodes: [PodcastEpisodeDetail] = []
    @Published var podcasts: [PodcastDetail] = []
    @Published var showLoader = false
    var podcastDetails: [PodcastEpisodeCustom] = []
    let dispatchGrp = DispatchGroup()
    
    func podcastEpisodes(for id: String)-> [PodcastEpisodeDetail] {
        return podcastDetails.filter {$0.id == id}.first?.podcastEpisodes ?? []
    }
    
    func selectedPodcast(for id: String) -> PodcastDetail? {
        return podcasts.filter {$0.id == id}.first
    }
    
    func getPodcastsAndEpisodes() {
        print(Date())
        self.showLoader = true
        self.getPodcastEpisodes()
        self.getPodcastList()
        dispatchGrp.notify(queue: .main) {
            self.showLoader = false
            print(Date())
        }
    }
}


extension PodcastHomeViewModel {
    func getPodcastEpisodes() {
        dispatchGrp.enter()
        serviceProvider.getPodcastEpisodes(postData: nil) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    var episodes: [PodcastEpisodeDetail] = []
                    if value.status {
                        self.podcastDetails = value.data
                        for episodeSection in value.data {
                            episodes.append(contentsOf: episodeSection.podcastEpisodes)
                        }
                        self.podcastEpisodes = episodes
                    } else {
                        ShowToast.show(toatMessage: value.message)
                    }
                case .failure(let error):
                    debugPrint("error")
                    if error == .tokenExpired {
                        self.getPodcastEpisodes()
                    } else {
                       // self.status = .failure
                    }
                }
                self.dispatchGrp.leave()
            }
        }
    }
    
    func getPodcastList() {
        dispatchGrp.enter()
        self.serviceProvider.getPodcasts(postData: nil) { result in
            DispatchQueue.main.async {
               // self.showLoader = false
                switch result {
                case .success(let value):
                    if value.status {
                        self.podcasts = value.data
                        print("api 1")
                    } else {
                        ShowToast.show(toatMessage: value.message)
                    }
                case .failure(let error):
                    debugPrint("error")
                    if error == .tokenExpired {
                        self.getPodcastList()
                    } else {
                        ShowToast.show(toatMessage: error.rawValue)
                    }
                }
                self.dispatchGrp.leave()
            }
        }
    }
}
