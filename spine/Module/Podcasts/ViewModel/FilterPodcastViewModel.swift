//
//  FilterPodcastViewModel.swift
//  spine
//
//  Created by Mac on 23/12/22.
//

import Foundation

class FilterPodcastViewModel: ObservableObject {
    let addPodcastServiceProvider = AddPodcastServiceProvider()
    var languages: [ItemModel] = []
    var categories: [ItemModel] = []
    @Published var selectedLanguage: ItemModel?
    @Published var selectedCategories: [ItemModel] = []
    @Published var showLoader = false
    let dispatchGrp = DispatchGroup()
    
    init() {
        downloadAllData() //will be called in viewDidload
    }
    
    func downloadAllData() {
        self.showLoader = true
        self.getCategoryList()
        self.getLanguageList()
        dispatchGrp.notify(queue: .main) {
            self.showLoader = false
        }
    }
}

extension FilterPodcastViewModel {
    
    func getLanguageList() {
        dispatchGrp.enter()
        addPodcastServiceProvider.getLanguageList { result in
            DispatchQueue.main.async {
                self.dispatchGrp.leave()
                switch result {
                case .success(let value):
                    //map{ItemModel(id: $0.id, name: $0.name)}
                    self.languages = (value.data ?? []).map{ItemModel(id: $0.id, name: $0.name)}//.map{ $0.name }
                case .failure(let error):
                    if error == .tokenExpired {
                        self.getLanguageList()
                    } else {
                        ShowToast.show(toatMessage: "Error occured")
                    }
                }
            }
        }
    }
    
    func getCategoryList() {
        dispatchGrp.enter()
        addPodcastServiceProvider.getCategoryList { result in
            DispatchQueue.main.async {
                self.dispatchGrp.leave()
                switch result {
                case .success(let value):
                    //compactMap({ ItemModel(id: $0.id, name: $0.categoryName) }) ?? []
                    self.categories = value.data?.compactMap({ ItemModel(id: $0.id, name: $0.categoryName) }) ?? []
                        //.compactMap({ $0.categoryName }) ?? []
                case .failure(let error):
                    if error == .tokenExpired {
                        self.getCategoryList()
                    } else {
                        ShowToast.show(toatMessage: "Error occured")
                    }
                }
            }
        }
    }
}
