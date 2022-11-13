//
//  ChangeEmailViewModel.swift
//  spine
//
//  Created by Mac on 12/11/22.
//

import SwiftUI

class ChangeEmailViewModel: ObservableObject {
    let serviceProvider = ChangeEmailService(httpUtility: HttpUtility())
    @Published var emailId: String = ""
    @Published var showAlert = false
    @Published var showLoader: Bool = false
    
    private(set) var alertTitle: String = ""
    private(set) var alertMessage: String = ""
    private(set) var shouldDismiss: Bool = false
    
    func updateEmailAddress() {
        if emailId.isValidEmail() {
            showLoader = true
            serviceProvider.updateUserEmail(emailId) { result in
                DispatchQueue.main.async { [weak self] in
                    switch result {
                    case .success(let apiResponse):
                        self?.alertTitle = "Success"
                        self?.alertMessage = apiResponse.message
                        self?.shouldDismiss = true
                        self?.showAlert = true
                    case .failure(let error):
                        self?.alertTitle = "Error"
                        self?.alertMessage = error.localizedDescription
                        self?.showAlert = true
                    }
                    self?.showLoader = false
                }
            }
        } else {
            alertTitle = "Invalid Email"
            alertMessage = "Please enter a valid email."
            showAlert = true
        }
    }
}
