//
//  LanguagesListViewModel.swift
//  spine
//
//  Created by Mac on 13/11/22.
//

import Foundation

class LanguagesListViewModel: ObservableObject {
    private struct Constants {
        static let languageFilename: String = "languages.json"
    }
    
    let serviceProvider = LanguagesListService(httpUtility: HttpUtility())

    @Published var selectedLanguage: LanguageModel?
    @Published var filteredLanguages: [LanguageModel]?
    
    @Published var showAlertView: Bool = false
    @Published var alertTitleStr: String = ""
    @Published var alertMessageStr: String = ""
    @Published var showLoader: Bool = false

    @Published var searchQuery: String = "" {
        didSet {
            if searchQuery.isEmpty {
                filteredLanguages = languages
            } else {
                let query: String = searchQuery.lowercased()
                filteredLanguages = languages?.filter { $0.name.lowercased().contains(query) }
            }
        }
    }
    
    private var languages: [LanguageModel]? {
        didSet {
            if let langId: String = AppUtility.shared.userInfo?.data?.defaultLanguageID {
                selectedLanguage = languages?.first { $0.id == langId }
            }
            filteredLanguages = languages
        }
    }

    func getLanguages() {
        if let jsonData: Data = FileManager.default.fileDataFromCachesDirectory(for: Constants.languageFilename), let response: [LanguageModel] = try? JSONDecoder().decode([LanguageModel].self, from: jsonData) {
            languages = response
        } else {
            showLoader = true
            serviceProvider.getLanguages { result in
                DispatchQueue.main.async { [weak self] in
                    switch result {
                    case .success(let apiRes):
                        if let jsonData: Data = try? JSONEncoder().encode(apiRes.data) {
                            FileManager.default.saveDataToCachesDirectory(jsonData, filename: Constants.languageFilename)
                        }
                        self?.languages = apiRes.data
                    case .failure(let error):
                        print(error)
                    }
                    self?.showLoader = false
                }
            }
        }
    }
    
    func updateLanguage(completion: @escaping (Result<Bool, CHError>) -> Void) {
        if let selectedLanguage = selectedLanguage {
            showLoader = true
            serviceProvider.updateLanguage(to: selectedLanguage) { result in
                DispatchQueue.main.async { [weak self] in
                    switch result {
                    case .success(_):
                        completion(.success(true))
                    case .failure(let error):
                        print(error)
                        completion(.failure(error))
                    }
                    self?.showLoader = false
                }
            }
        }
    }
}

extension LanguageModel: SelectionListItemable {
    var itemId: String {
        get { id }
        set { }
    }
    
    var title: String {
        get { name }
        set { }
    }
}

extension LanguagesListViewModel: SelectionListable {
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
        selectedLanguage = item as? LanguageModel
        updateLanguage { result in
            switch result {
            case .success:
                AppUtility.shared.refreshUserInfo()
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
    
    var selectedItem: (any SelectionListItemable)? {
        get { selectedLanguage }
        set { selectedLanguage = newValue as? LanguageModel }
    }
    
    var listItems: [any SelectionListItemable] {
        get { filteredLanguages ?? [] }
        set { }
    }
    
    var searchText: String {
        get { searchQuery }
        set { searchQuery = newValue }
    }
    
    var navTitle: String { return "Select Language" }
    
    func getListItems() {
        getLanguages()
    }
}
