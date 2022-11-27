//
//  TimezoneListViewModel.swift
//  spine
//
//  Created by Mac on 28/11/22.
//

import Foundation

class TimezoneListViewModel: ObservableObject {
    let serviceProvider = TimezoneListService()
    var didSelectTimezone: ((TimezoneModel?) -> Bool)? = nil
    
    @Published var selectedTimezone: TimezoneModel?
    @Published var filteredTimezones: [TimezoneModel]?
    
    @Published var showAlertView: Bool = false
    @Published var alertTitleStr: String = ""
    @Published var alertMessageStr: String = ""
    @Published var showLoader: Bool = false

    @Published var searchQuery: String = "" {
        didSet {
            if searchQuery.isEmpty {
                filteredTimezones = timezones
            } else {
                let query: String = searchQuery.lowercased()
                filteredTimezones = timezones?.filter { $0.timezone.lowercased().contains(query) }
            }
        }
    }
    
    private var timezones: [TimezoneModel]? {
        didSet {
            filteredTimezones = timezones
        }
    }

    func getTimezones() {
        showLoader = true
        serviceProvider.getTimezones { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let apiRes):
                    self?.timezones = apiRes.data
                case .failure(let error):
                    print(error)
                }
                self?.showLoader = false
            }
        }
    }
}

extension TimezoneModel: SelectionListItemable {
    var itemId: String {
        get { id }
        set { }
    }
    
    var title: String {
        get { timezone }
        set { }
    }
}

extension TimezoneListViewModel: SelectionListable {
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
    
    func didSelect(item: any SelectionListItemable, completion: @escaping (Bool) -> Void) {
        selectedTimezone = item as? TimezoneModel
        if let didSelectTimezone = didSelectTimezone {
            completion(didSelectTimezone(selectedTimezone))
        }
    }
    
    var selectedItem: (any SelectionListItemable)? {
        get { selectedTimezone }
        set { selectedTimezone = newValue as? TimezoneModel }
    }
    
    var listItems: [any SelectionListItemable] {
        get { filteredTimezones ?? [] }
        set { }
    }
    
    var searchText: String {
        get { searchQuery }
        set { searchQuery = newValue }
    }
    
    var navTitle: String { return "Select Timezone" }
    
    func getListItems() {
        getTimezones()
    }
}
