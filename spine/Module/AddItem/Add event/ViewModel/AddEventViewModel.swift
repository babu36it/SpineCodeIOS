//
//  AddEventViewModel.swift
//  spine
//
//  Created by Mac on 29/09/22.
//

import Foundation

class AddEventViewModel: ObservableObject {
    private let eventService = AddEventServiceProvider()

    @Published var selectedEvent: EventModel?
    @Published private(set) var userEvents: [EventModel]?
    
    private(set) var imagePath: String?
    private(set) var draftEvent: EventModel?
    var eventTypes = [EventTypeModel]()

    func didAppear() {
        getEventTypes()
        getUserEvents()
    }
    
    func imageURL(for filename: String?) -> String? {
        if let imagePath = imagePath, let filename = filename {
            return "\(imagePath)\(filename)"
        }
        return nil
    }
    
    func getEventTypes() {
        eventService.getEventsTypes { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    self.imagePath = value.image
                    self.eventTypes = value.data
                case .failure(let err):
                    print(err.rawValue)
                }
            }
        }
    }
        
    func getUserEvents() {
        eventService.getUserEvents { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let success):
                    self?.userEvents = success.data
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
}
