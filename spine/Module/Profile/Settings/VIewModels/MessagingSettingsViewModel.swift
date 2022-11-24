//
//  MessagingSettingsViewModel.swift
//  spine
//
//  Created by Mac on 13/11/22.
//

import SwiftUI

enum WhoCanMessage: Int, CaseIterable, Identifiable, CustomStringConvertible {
    var id: Int { rawValue }
    case hosts = 1
    case members = 2
    case anyone = 3
    
    var description: String {
        switch self {
        case .hosts: return "Hosts of an event you're going to"
        case .members: return "Members of an event you're going to"
        case .anyone: return "Anyone on Spine"
        }
    }
}

class MessagingSettingsViewModel: ObservableObject {
    let serviceProvider = MessagingSettingsViewService()

    @Published var authorization: WhoCanMessage = .anyone {
        didSet {
            updateMessagingAuthorization()
        }
    }
    @Published var showLoader: Bool = false
    
    func getMessageAuthorizationStatus() {
        showLoader = true
        serviceProvider.getMessageAuthorizationStatus() { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let apiRes):
                    let messageAuth: Int = Int(apiRes.data.messageAuth) ?? 0
                    self?.authorization = WhoCanMessage(rawValue: messageAuth) ?? .anyone
                case .failure(let error):
                    print(error)
                }
                self?.showLoader = false
            }
        }
    }
    
    func updateMessagingAuthorization() {
        showLoader = true
        serviceProvider.updateMessagingAuthorization("\(authorization.rawValue)") { result in
            DispatchQueue.main.async { [weak self] in
                self?.showLoader = false
            }
        }
    }
}
