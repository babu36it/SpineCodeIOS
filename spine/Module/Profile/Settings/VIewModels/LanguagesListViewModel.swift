//
//  LanguagesListViewModel.swift
//  spine
//
//  Created by Mac on 13/11/22.
//

import Foundation

class LanguagesListViewModel: ObservableObject {
    let serviceProvider = LanguagesListService(httpUtility: HttpUtility())

    @Published var languages: [LanguageModel]?
    @Published var showLoader: Bool = false
    @Published var selectedLanguage: LanguageModel?
    
    func getLanguages() {
        showLoader = true
        serviceProvider.getLanguages { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let apiRes):
                    self?.languages = apiRes.data
                case .failure(let error):
                    print(error)
                }
                self?.showLoader = false
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
    func didSelect(item: any SelectionListItemable, completion: @escaping (Bool) -> Void) {
        updateLanguage { result in
            switch result {
            case .success:
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
        get { languages ?? [] }
        set { }
    }
    
    var navTitle: String { return "Select Language" }
    
    func getListItems() {
        getLanguages()
    }
}
