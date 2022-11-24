//
//  LinkRssViewModel.swift
//  spine
//
//  Created by Mac on 18/10/22.
//

import Foundation

class LinkRssViewModel: ObservableObject {
    let serviceProvider = ValidateRssServiceProvider()
    @Published var searchText = ""
    @Published var status: RssStaus? //= .failure
    @Published var showLoader = false
    
    func validateRss() {
        AddPodcastData.shared.rssLink = searchText
        let parameters = ["link": searchText]
        self.showLoader = true
        serviceProvider.validateRss(postData: parameters) { result in
            DispatchQueue.main.async {
                self.showLoader = false
                switch result {
                case .success(let value):
                    //self.status = value.status ? .success : .failure
                    if value.status {
                        self.status = .success
                    } else {
                        self.status = .failure
                    }
                case .failure(let error):
                    print("error")
                    if error == .tokenExpired {
                        self.validateRss()
                    } else {
                        self.status = .failure
                    }
                    
                }
            }
        }
    }
}
