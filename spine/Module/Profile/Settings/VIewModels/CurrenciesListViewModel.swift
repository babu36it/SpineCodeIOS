//
//  CurrenciesListViewModel.swift
//  spine
//
//  Created by Mac on 13/11/22.
//

import Foundation

class CurrenciesListViewModel: ObservableObject {
    let serviceProvider = CurrenciesListService(httpUtility: HttpUtility())

    @Published var selectedCurrency: CurrencyModel?
    @Published var filteredCurrencies: [CurrencyModel]?

    @Published var showAlertView: Bool = false
    @Published var alertTitleStr: String = ""
    @Published var alertMessageStr: String = ""
    @Published var showLoader: Bool = false

    @Published var searchQuery: String = "" {
        didSet {
            if searchQuery.isEmpty {
                filteredCurrencies = currencies
            } else {
                let query: String = searchQuery.lowercased()
                filteredCurrencies = currencies?.filter { $0.code.lowercased().contains(query) || $0.currency.lowercased().contains(query) }
            }
        }
    }
    
    private var currencies: [CurrencyModel]? {
        didSet {
            filteredCurrencies = currencies
        }
    }

    func getCurrencies() {
        showLoader = true
        serviceProvider.getCurrencies { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let apiRes):
                    if let currID: String = AppUtility.shared.userInfo?.data?.defaultCurrencyID {
                        self?.selectedCurrency = apiRes.data?.first { $0.id == currID }
                    }
                    self?.currencies = apiRes.data
                case .failure(let error):
                    print(error)
                }
                self?.showLoader = false
            }
        }
    }
    
    func updateCurrency(completion: @escaping (Result<Bool, CHError>) -> Void) {
        if let selectedCurrency = selectedCurrency {
            showLoader = true
            serviceProvider.updateCurrency(to: selectedCurrency) { result in
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

extension CurrencyModel: SelectionListItemable {
    var itemId: String {
        get { id }
        set { }
    }
    
    var title: String {
        get { "\(code) - \(currency)"}
        set { }
    }
}

extension CurrenciesListViewModel: SelectionListable {
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
        updateCurrency { result in
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
        get { selectedCurrency }
        set { selectedCurrency = newValue as? CurrencyModel }
    }
    
    var listItems: [any SelectionListItemable] {
        get { filteredCurrencies ?? [] }
        set { }
    }
    
    var searchText: String {
        get { searchQuery }
        set { searchQuery = newValue }
    }

    var navTitle: String { return "Select Currency" }
    
    func getListItems() {
        getCurrencies()
    }
}
