//
//  AddEventViewModel.swift
//  spine
//
//  Created by Mac on 29/09/22.
//

import Foundation

class AddEventViewModel: ObservableObject {
    private let eventService = AddEventServiceProvider()

    @Published var showAddEvent = false

    @Published private(set) var userEvents: [EventModel]?
    var eventTypes = [EventTypeModel]()

    var draftEvent: EventModel?
    
    func didAppear() {
        getEventTypes()
        getUserEvents()
    }
    
    func getEventTypes() {
        eventService.getEventsTypes { result in
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
        
    func getUserEvents() {
        eventService.getUserEvents { [weak self] result in
            switch result {
            case .success(let success):
                print(success)
                self?.userEvents = success.data
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
