//
//  EventsListViewModel.swift
//  spine
//
//  Created by Mac on 01/12/22.
//

import Foundation

class EventsListViewModel: ObservableObject {
    private let service: EventServices = .init()
    
    private var shouldFetchMore: Bool = true
    
    private var eventResponse: EventAPIResponse? {
        didSet {
            if let isEmptyRecords = eventRecords?.isEmpty, !isEmptyRecords, let newRecords = eventResponse?.data {
                eventRecords?.append(contentsOf: newRecords)
            } else {
                eventRecords = eventResponse?.data
            }
        }
    }
    
    @Published var eventRecords: [EventAPIResponse.Records]?
    
    var message: String? { eventResponse?.message }
    
    var userImagePath: String? { eventResponse?.userImage }
    var eventImagePath: String? { eventResponse?.image }

    func imagePath(forUserImage image: String?) -> String? {
        if let serverPath: String = eventResponse?.userImage, let image = image, !serverPath.isEmpty, !image.isEmpty {
            return "\(serverPath)\(image)"
        }
        return nil
    }
    
    func imagePath(forEventImage image: String?) -> String? {
        if let serverPath: String = eventResponse?.image, let image = image, !serverPath.isEmpty, !image.isEmpty {
            return "\(serverPath)\(image)"
        }
        return nil
    }
    
    func getEvents(forType type: EventRequest.RequestType, eventTypeId: String? = nil) {
        if shouldFetchMore {
            var page: Int = 1
            var pageLimit: Int = 10
            if let currentPage: Int = Int(eventResponse?.currentPage ?? "0"), currentPage > 0 {
                page = currentPage
            }
            if let currentPageLimit: Int = Int(eventResponse?.currentPerPage ?? "0"), currentPageLimit > 0 {
                pageLimit = currentPageLimit
            }
            let eventRequest = EventRequest(page: page, perPage: pageLimit, type: type, eventTypeID: eventTypeId)
//            let eventRequest = EventRequest(page: page, perPage: pageLimit, type: .past, eventTypeID: nil)

            service.getEvents(for: eventRequest) { [weak self] (result: Result<EventAPIResponse, CHError>) -> Void in
                switch result {
                case .success(let response):
                    self?.eventResponse = response
                    if let recordsCount: Int = response.data?.count, recordsCount < pageLimit {
                        self?.shouldFetchMore = false
                    }
                case .failure(let error):
                    print(error)
                    self?.eventResponse = nil
                }
            }
        }
    }
}
