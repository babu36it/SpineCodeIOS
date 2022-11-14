//
//  CurrenciesListViewModel.swift
//  spine
//
//  Created by Mac on 13/11/22.
//

import Foundation

class CurrenciesListViewModel: ObservableObject {
    let serviceProvider = CurrenciesListService(httpUtility: HttpUtility())

    @Published var showLoader: Bool = false
    @Published var selectedCurrency: CurrencyModel?

    @Published var filteredCurrencies: [CurrencyModel]?
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
                    self?.currencies = apiRes.data
                case .failure(let error):
                    print(error)
                }
                self?.showLoader = false
            }
        }
    }
    
    func updateLanguage(completion: @escaping (Result<Bool, CHError>) -> Void) {
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
