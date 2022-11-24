//
//  SaveEventsInCalendarViewModel.swift
//  spine
//
//  Created by Mac on 13/11/22.
//

import SwiftUI

class SaveEventsInCalendarViewModel: ObservableObject {
    let serviceProvider = SaveEventsInCalendarService()

    @Published var saveEvent: Bool = false
    @Published var showLoader: Bool = false

    func getSaveEventsInCalendarStatus() {
        showLoader = true
        serviceProvider.getAccountSettings { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let apiRes):
                    self?.saveEvent = apiRes.data.eventCalenderStatus.toBool() ?? false
                case .failure(let error):
                    print(error)
                }
                self?.showLoader = false
            }
        }
    }
    
    func updateSaveEventsInCalendarStatus(_ status: Bool) {
        showLoader = true
        let eventStatus: String = status ? "1" : "0"
        serviceProvider.updateSaveEventsInCalendarStatus(eventStatus) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let apiRes):
                    print(apiRes)
                case .failure(let error):
                    print(error)
                }
                self?.showLoader = false
            }
        }
    }
}
