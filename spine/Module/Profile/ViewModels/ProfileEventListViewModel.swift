//
//  ProfileEventListViewModel.swift
//  spine
//
//  Created by Mac on 24/12/22.
//

import Foundation

class ProfileEventListViewModel: ObservableObject {
    private let service: EventServices = .init()
    
    private var isAlreadyFetching: Bool = false
    
    private var eventAPIResponse: APIResponseModel<[EventModel]>? {
        didSet {
            events = eventAPIResponse?.data
        }
    }
    
    @Published var events: [EventModel]?
    
    var eventImagePath: String? {
        eventAPIResponse?.image
    }
    
    func getEvents() {
        if !isAlreadyFetching {
            isAlreadyFetching = true
            service.getUserEvents { [weak self] result in
                self?.isAlreadyFetching = false
                switch result {
                case .success(let apiResponse):
                    self?.eventAPIResponse = apiResponse
                case .failure(let error):
                    ShowToast.show(toatMessage: error.localizedDescription)
                    print(error)
                }
            }
        }
    }
}
