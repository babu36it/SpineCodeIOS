//
//  EventsListViewModel.swift
//  spine
//
//  Created by Mac on 01/12/22.
//

import Foundation

class EventsListViewModel: ObservableObject {
    private let service: EventServices = .init()

    private var isDataFetchComplete: [EventRequest.RequestType: Bool] = [:]
    private(set) var eventRecords: [EventRequest.RequestType: [EventAPIResponse.Records]] = [:]

    @Published var eventResponses: [EventRequest.RequestType: EventAPIResponse] = [:]

    func message(forRequestType type: EventRequest.RequestType) -> String? {
        eventResponses[type]?.message
    }
    func userImagePath(forRequestType type: EventRequest.RequestType) -> String? {
        eventResponses[type]?.userImage
    }
    func eventImagePath(forRequestType type: EventRequest.RequestType) -> String? {
        eventResponses[type]?.image
    }

    func shouldFetchData(for type: EventRequest.RequestType) -> Bool {
        let shouldFetch: Bool = (isDataFetchComplete[type] == nil || isDataFetchComplete[type] == false)
        return shouldFetch
    }
    func fetchCompleted(for type: EventRequest.RequestType) {
        isDataFetchComplete[type] = true
    }
    
    func imagePath(forUserImage image: String?, onRequestType type: EventRequest.RequestType) -> String? {
        if let serverPath: String = eventResponses[type]?.userImage, let image = image, !serverPath.isEmpty, !image.isEmpty {
            return "\(serverPath)\(image)"
        }
        return nil
    }
    
    func imagePath(forEventImage image: String?, onRequestType type: EventRequest.RequestType) -> String? {
        if let serverPath: String = eventResponses[type]?.image, let image = image, !serverPath.isEmpty, !image.isEmpty {
            return "\(serverPath)\(image)"
        }
        return nil
    }
    
    private func updateEventResponse(eventResponse: EventAPIResponse, forRequestType type: EventRequest.RequestType) {
        if let newRecords = eventResponse.data {
            if let existingRecords = eventRecords[type], !existingRecords.isEmpty {
                var updatedRecords = existingRecords
                updatedRecords.append(contentsOf: newRecords)
                eventRecords[type] = updatedRecords
            } else {
                eventRecords[type] = newRecords
            }
        }
        eventResponses[type] = eventResponse
    }
    
    func getEvents(forType type: EventRequest.RequestType, eventTypeId: String? = nil) {
        if shouldFetchData(for: type) {
            var page: Int = 1
            var pageLimit: Int = 10
            if let currentPage: Int = Int(eventResponses[type]?.currentPage ?? "0"), currentPage > 0 {
                page = currentPage + 1
            }
            if let currentPageLimit: Int = Int(eventResponses[type]?.currentPerPage ?? "0"), currentPageLimit > 0 {
                pageLimit = currentPageLimit
            }
            let eventRequest = EventRequest(page: page, perPage: pageLimit, type: type, eventTypeID: eventTypeId)
//            let eventRequest = EventRequest(page: page, perPage: pageLimit, type: .past, eventTypeID: nil)

            service.getEvents(for: eventRequest) { [weak self] (result: Result<EventAPIResponse, CHError>) -> Void in
                switch result {
                case .success(let response):
                    self?.updateEventResponse(eventResponse: response, forRequestType: type)
                    if let recordsCount: Int = response.data?.count, recordsCount < pageLimit {
                        self?.fetchCompleted(for: type)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    deinit {
        print("EventListViewModel - deinit \(self)")
    }
}
