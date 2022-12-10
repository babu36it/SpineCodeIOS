//
//  CurrenciesListViewModel.swift
//  spine
//
//  Created by Mac on 13/11/22.
//

import Foundation

class CurrenciesListViewModel: ObservableObject {
    let serviceProvider = CurrenciesListService()
    var didSelectCurrency: ((CurrencyModel?) -> Bool)? = nil

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
            if didSelectCurrency == nil, let currID: String = AppUtility.shared.userInfo?.data?.defaultCurrencyID {
                selectedCurrency = currencies?.first { $0.id == currID }
            }
            filteredCurrencies = currencies
        }
    }

    func getCurrencies() {
        showLoader = true
        serviceProvider.getCurrencies { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let apiRes):
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
                        AppUtility.shared.refreshUserInfo()
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
        get { "\(code) - \(currency) (\(symbol))" }
        set { }
    }
}

extension CurrenciesListViewModel: SelectionListable {
    typealias ListItemable = CurrencyModel

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
        selectedCurrency = item
        if let didSelectCurrency = didSelectCurrency {
            completion(didSelectCurrency(selectedCurrency))
        } else {
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
    }
    
    var selectedItem: ListItemable? {
        get { selectedCurrency }
        set { selectedCurrency = newValue }
    }
    
    var listItems: [ListItemable] {
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
