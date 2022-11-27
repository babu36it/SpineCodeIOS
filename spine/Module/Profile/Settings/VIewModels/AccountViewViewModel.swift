//
//  AccountViewViewModel.swift
//  spine
//
//  Created by Mac on 19/11/22.
//

import Foundation

class AccountViewViewModel: ObservableObject {
    let serviceProvider = NotificationTypeService()
    
    @Published var showLoader: Bool = false
    @Published var pushNotifications: PushNotificationViewModel = .init()
    @Published var emailNotifications: EmailNotificationViewModel = .init()
    
    @Published var language: LanguageModel?
    @Published var currency: CurrencyModel?
    
    @Published var accountSettings: AccountSettingModel? {
        didSet {
            guard let accountSettings = accountSettings else { return }
            pushNotifications.update(with: accountSettings)
            emailNotifications.update(with: accountSettings)
        }
    }
    @Published var error: CHError?
    
    func loadAccountSettings() {
        getAccountSettings()
        getSelectedLanguage()
        getSelectedCurrency()
    }
    
    func getSelectedLanguage() {
        if let langId: String = AppUtility.shared.userInfo?.data?.defaultLanguageID {
            LanguagesListService.language(for: langId) { [weak self] model in
                self?.language = model
            }
        }
    }
    
    func getSelectedCurrency() {
        if let currId: String = AppUtility.shared.userInfo?.data?.defaultCurrencyID {
            CurrenciesListService.currency(for: currId) { [weak self] model in
                self?.currency = model
            }
        }
    }

    private func getAccountSettings() {
        showLoader = true
        serviceProvider.getAccountSettings { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let accountSettings):
                    self?.accountSettings = accountSettings.data
                case .failure(let error):
                    self?.error = error
                }
                
                self?.showLoader = false
            }
        }
    }
}
