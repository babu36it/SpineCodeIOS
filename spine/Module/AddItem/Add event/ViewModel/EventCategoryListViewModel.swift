//
//  EventCategoryListViewModel.swift
//  spine
//
//  Created by Mac on 28/11/22.
//

import Foundation

class EventCategoryListViewModel: ObservableObject {
    let serviceProvider = EventCategoryListService()
    var didSelectCategory: ((EventCategoryModel?) -> Bool)? = nil
    
    @Published var selectedCategory: EventCategoryModel?
    @Published var filteredCategories: [EventCategoryModel]?
    
    @Published var showAlertView: Bool = false
    @Published var alertTitleStr: String = ""
    @Published var alertMessageStr: String = ""
    @Published var showLoader: Bool = false

    @Published var searchQuery: String = "" {
        didSet {
            if searchQuery.isEmpty {
                filteredCategories = categories
            } else {
                let query: String = searchQuery.lowercased()
                filteredCategories = categories?.filter { $0.categoryName.lowercased().contains(query) }
            }
        }
    }
    
    private var categories: [EventCategoryModel]? {
        didSet {
            filteredCategories = categories
        }
    }

    func getEventCategories() {
        showLoader = true
        serviceProvider.getEventCategories { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let apiRes):
                    self?.categories = apiRes.data
                case .failure(let error):
                    print(error)
                }
                self?.showLoader = false
            }
        }
    }
}

extension EventCategoryModel: SelectionListItemable {
    var itemId: String {
        get { id }
        set { }
    }
    
    var title: String {
        get { categoryName }
        set { }
    }
}

extension EventCategoryListViewModel: SelectionListable {
    typealias ListItemable = EventCategoryModel
    
    var showAlert: Bool {
        get { self.showAlertView }
        set { self.showAlertView = newValue }
    }
    
    var alertTitle: String {
        get { alertTitleStr }
        set { alertTitleStr = newValue }
    }
    
    var alertMessage: String {
        get { alertMessageStr }
        set { alertMessageStr = newValue }
    }
    
    func didSelect(item: ListItemable, completion: @escaping (Bool) -> Void) {
        selectedCategory = item
        if let didSelectCategory = didSelectCategory {
            completion(didSelectCategory(selectedCategory))
        }
    }
    
    var selectedItem: ListItemable? {
        get { selectedCategory }
        set { selectedCategory = newValue }
    }
    
    var listItems: [ListItemable] {
        get { filteredCategories ?? [] }
        set { }
    }
    
    var searchText: String {
        get { searchQuery }
        set { searchQuery = newValue }
    }
    
    var navTitle: String { return "Select Category" }
    
    func getListItems() {
        getEventCategories()
    }
}
