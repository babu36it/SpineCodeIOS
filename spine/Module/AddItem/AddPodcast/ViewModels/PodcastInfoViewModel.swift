//
//  PodcastInfoViewModel.swift
//  spine
//
//  Created by Mac on 25/10/22.
//

import Foundation

class PodcastInfoViewModel: ObservableObject {
    let serviceProvider = RssDataServiceProvider(httpUtility: HttpUtility())
    let addPodcastServiceProvider = AddPodcastServiceProvider(httpUtility: HttpUtility())
    var selectedLanguage: ItemModel?
    var selectedCategory: ItemModel? {
        didSet {
            selectedSubCategories = []
            getSubcategoryForId()
        }
    }
    @Published var selectedSubCategories: [ItemModel] = []
    @Published var commentsOn = false
    @Published var showReviewScreen = false
    @Published var showLoader = false
    @Published var showConfirm = false
    
    var rssData: RssDataModel?
    var isFormValid: Bool {
         return (selectedLanguage != nil && selectedCategory != nil && selectedSubCategories.count > 0) ? true : false
    }
    var newSubCategory: String = ""
    var languages: [ItemModel] = []
    var categories: [ItemModel] = []
    var subCategories: [ItemModel] = []
    let dispatchGrp = DispatchGroup()
    
    init() {
        downloadAllData() //will be called in viewDidload
    }
    
    func downloadAllData() {
        self.showLoader = true
        self.getRssData()
        self.getCategoryList()
        self.getLanguageList()
        dispatchGrp.notify(queue: .main) {
            self.showLoader = false
        }
    }
}



extension PodcastInfoViewModel {
    
    func getRssData() {
        let parameters = ["link": AddPodcastData.shared.rssLink]
        dispatchGrp.enter()
        serviceProvider.getRssData(postData: parameters) { result in
            DispatchQueue.main.async {
                self.dispatchGrp.leave()
                switch result {
                case .success(let value):
                    self.rssData = value.data
                case .failure(let error):
                    if error == .tokenExpired {
                        self.getRssData()
                    } else {
                        ShowToast.show(toatMessage: "Error occured")
                    }
                }
            }
        }
    }
    
    func getLanguageList() {
        dispatchGrp.enter()
        addPodcastServiceProvider.getLanguageList { result in
            DispatchQueue.main.async {
                self.dispatchGrp.leave()
                switch result {
                case .success(let value):
                    self.languages = (value.data ?? []).map{ItemModel(name: $0.name, id: $0.id)}
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
                    self.categories = (value.data ?? []).map{ ItemModel(name: $0.category_name, id: $0.id) }
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
    
    func getSubcategoryForId() {
        let parameters = ["categoryIds": selectedCategory?.id ?? ""]
        self.showLoader = true
        addPodcastServiceProvider.getSubCategories(postData: parameters) { result in
            DispatchQueue.main.async {
                self.showLoader = false
                switch result {
                case .success(let value):
                    self.subCategories = (value.data ?? []).map{ ItemModel(name: $0.name, id: $0.id) }
                case .failure(let error):
                    if error == .tokenExpired {
                        self.getSubcategoryForId()
                    } else {
                        ShowToast.show(toatMessage: "Error occured")
                    }
                }
            }
        }
    }
    
    func addPodcastSubCategory() {
        let parameters = ["parent_id": selectedCategory?.id ?? "", "subcategory_name": newSubCategory]
        self.showLoader = true
        addPodcastServiceProvider.addPodcastsSubcategory(postData: parameters) { result in
            DispatchQueue.main.async {
                self.showLoader = false
                switch result {
                case .success(let value):
                    if value.status {
                        self.getSubcategoryForId()
                    }
                case .failure(let error):
                    if error == .tokenExpired {
                        self.addPodcastSubCategory()
                    } else {
                        ShowToast.show(toatMessage: "Error occured")
                    }
                }
            }
        }
    }
    
    func submitPodcast() {
        guard let parameters = self.getPostDataForAddPodcast() else {
            ShowToast.show(toatMessage: "Error occured")
            return
        }
        self.showLoader = true
        addPodcastServiceProvider.submitPodcast(postData: parameters) { result in
            DispatchQueue.main.async {
                self.showLoader = false
                switch result {
                case .success(let value):
                    if value.status {
                        self.showConfirm = true
                    }
                case .failure(let error):
                    if error == .tokenExpired {
                        self.submitPodcast()
                    } else {
                        ShowToast.show(toatMessage: "Error occured")
                    }
                }
            }
        }
    }
    
    func getPostDataForAddPodcast()-> [String: Any]? {
        guard let feed = rssData?.feed, let selLang = self.selectedLanguage, let selCat = self.selectedCategory  else { return nil }
        let subCategoryIds = self.selectedSubCategories.map {$0.id}.joined(separator: ",")
        let parameters = [
            "title": feed.title,
            "description": feed.description,
            "language": selLang.id,
            "category": selCat.id,
            "subcategory": subCategoryIds,
            "allow_comment": "\(self.commentsOn)",
            "rss_feed": AddPodcastData.shared.rssLink
        ]
        return parameters
    }
    
}
