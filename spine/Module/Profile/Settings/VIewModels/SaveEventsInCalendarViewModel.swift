//
//  SaveEventsInCalendarViewModel.swift
//  spine
//
//  Created by Mac on 13/11/22.
//

import SwiftUI

class SaveEventsInCalendarViewModel: ObservableObject {
    let serviceProvider = SaveEventsInCalendarService(httpUtility: HttpUtility())

    @Published var saveEvent: Bool = false
    @Published var showLoader: Bool = false

    func getSaveEventsInCalendarStatus() {
        showLoader = true
        serviceProvider.getSaveEventsInCalendarStatus { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let apiRes):
                    self?.saveEvent = apiRes.status
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
                self?.showLoader = false
            }
        }
    }
}
