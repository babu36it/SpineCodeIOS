//
//  AddEventViewModel.swift
//  spine
//
//  Created by Mac on 29/09/22.
//

import Foundation

class AddEventViewModel: ObservableObject {
    
    let addEventServiceProvider = AddEventServiceProvider(httpUtility: HttpUtility())
    var eventTypes = [EventTypeModel]()
    @Published var showAddEvent = false
    
    func getEventTypes() {
        addEventServiceProvider.getEventsTypes { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    self.eventTypes = value.data
                case .failure(let err):
                    print(err.rawValue)
                }
            }
        }
    }
}
