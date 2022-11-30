//
//  EventTypesViewModel.swift
//  spine
//
//  Created by Mac on 30/11/22.
//

import Foundation

class EventTypesViewModel: ObservableObject {
    private let service: EventServices = .init()
    
    @Published var eventTypes: [EventTypeModel]?
    
    private var imagePath: String?
    
    func imageURL(for file: String?) -> String? {
        guard let imagePath = imagePath, let file = file else { return nil }
        return "\(imagePath)\(file)"
    }
    
    func getEventTypes() {
        service.getEventsTypes { [weak self] result in
            switch result {
            case .success(let types):
                self?.imagePath = types.image
                self?.eventTypes = types.data
            case .failure(let error):
                print(error)
            }
        }
    }
}
