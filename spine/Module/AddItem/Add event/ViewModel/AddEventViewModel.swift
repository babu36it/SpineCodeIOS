//
//  AddEventViewModel.swift
//  spine
//
//  Created by Mac on 29/09/22.
//

import UIKit

class AddEventViewModel: ObservableObject {
    private let eventService = AddEventServiceProvider()

    @Published private(set) var userEvents: [EventModel]?

    @Published var selectedEvent: EventModel? {
        didSet {
            if let currID = selectedEvent?.feeCurrency {
                CurrenciesListService.currency(for: currID) { [weak self] curr in
                    self?.selectedCurrency = curr
                }
            }
            if let langID = selectedEvent?.language {
                LanguagesListService.language(for: langID) { [weak self] lang in
                    self?.selectedLanguage = lang
                }
            }
            if let tzoneStr = selectedEvent?.timezone {
                TimezoneListService.timezone(for: tzoneStr) { [weak self] tzone in
                    self?.selectedTimezone = tzone
                }
            }
            if let catName = selectedEvent?.eventCategories {
                EventCategoryListService.eventCategory(for: catName) { [weak self] eCat in
                    self?.selectedEventCategory = eCat
                }
            }
            
            getSelectedEventImages()
        }
    }
    @Published var selectedLanguage: LanguageModel? {
        didSet {
            if let langID = selectedLanguage?.id, let langName = selectedLanguage?.name {
                selectedEvent?.language = langID
                selectedEvent?.languageName = langName
            }
        }
    }
    @Published var selectedCurrency: CurrencyModel? {
        didSet {
            if let selectedCurrency = selectedCurrency {
                selectedEvent?.feeCurrency = selectedCurrency.id
                selectedEvent?.currencyCode = selectedCurrency.code
                selectedEvent?.currencyName = selectedCurrency.title
                selectedEvent?.currencySymbol = selectedCurrency.symbol
                selectedEvent?.currencyCountry = selectedCurrency.country
            }
        }
    }
    @Published var selectedTimezone: TimezoneModel? {
        didSet {
            if let tzone = selectedTimezone?.timezone {
                selectedEvent?.timezone = tzone
            }
        }
    }
    @Published var selectedEventCategory: EventCategoryModel? {
        didSet {
            if let catName = selectedEventCategory?.categoryName {
                selectedEvent?.eventCategories = catName
            }
        }
    }
    
    @Published var eventImages: [UIImage] = []
    
    private(set) var imagePath: String?
    private(set) var draftEvent: EventModel?
    var eventTypes = [EventTypeModel]()
    var eventCategories: [EventCategoryModel]?

    var currency: String {
        get { selectedCurrency?.code ?? "" }
        set { }
    }
    var language: String {
        get { selectedLanguage?.name ?? "" }
        set { }
    }
    var timezone: String {
        get { selectedTimezone?.timezone ?? "" }
        set { }
    }
    var eventCategory: String {
        get { selectedEventCategory?.categoryName ?? "" }
        set { }
    }

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
            switch result {
            case .success(let value):
                self.eventTypes = value.data ?? []
            case .failure(let err):
                print(err.rawValue)
            }
        }
    }
        
    func getUserEvents() {
        eventService.getUserEvents { [weak self] result in
            switch result {
            case .success(let success):
                self?.imagePath = success.image
                self?.userEvents = success.data
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func publishSelectedEvent(params: [String: Any]? = nil, media: [Media]? = nil, completion: @escaping (Int?) -> Void) {
        eventService.publishEvent(params, media: media) { result in
            switch result {
            case .success(let success):
                completion(success.eventID)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getSelectedEventImages() {
        eventImages.removeAll()
        
        if let imagePath = imagePath, let imageURLs = selectedEvent?.imageURLs(for: imagePath) {
            for imageURL in imageURLs {
                let imageDownloader = DefaultImageDownloader(imagePath: imageURL)

                let cacheKey = imageDownloader.cacheKey
                if let cachedImage = RemoteImageCache.shared.getImage(for: cacheKey) {
                    eventImages.append(cachedImage)
                } else {
                    imageDownloader.downloadImageData { imgData, _ in
                        if let imgData = imgData, let image = UIImage(data: imgData) {
                            DispatchQueue.main.async { [weak self] in
                                self?.eventImages.append(image)
                            }
                        }
                    }
                }
            }
        }
    }
}
