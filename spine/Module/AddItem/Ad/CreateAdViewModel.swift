//
//  CreateAdViewModel.swift
//  spine
//
//  Created by Mac on 08/08/22.
//

import Foundation
import SwiftUI

enum AdType: String {
    case pictureVideo = "Picture or Video"
    case event = "Event"
    case podcast = "Podcast"
}

class CreateAdViewModel: ObservableObject {
    @Published var selectedDuration: String = ""
    @Published var selectedAdType: String = ""
    @Published var startDateT: Date = Date()
    @Published var startTimeT: Date = Date()
    @Published var images = [UIImage]()
   // @Published var videoUrls = [URL]()
    @Published var selectedMedia: Any?
    
    
    //first
    @Published var destWebsite = ""
    @Published var promoteAd = ""
    
    //second
    @Published var eventTitle: String = ""
    @Published var eventType: String = ""
    @Published var startDate: Date = Date()
    @Published var startTime: Date = Date()
    @Published var endDate: Date = Date()
    @Published var endTime: Date = Date().addingTimeInterval(3600)
    @Published var selectedTimeZone = ""
    @Published var selectedLocation = ""
    
    var getOnlyDuration: String {
        self.selectedDuration.components(separatedBy: " - ").first ?? "NA"
    }
    var getOnlyPrice: String {
        self.selectedDuration.components(separatedBy: " - ").last ?? "NA"
    }
    
    var durationList = [
        "1 week - 100 €",
        "2 week - 180 €",
        "3 week - 250 €",
        "4 week - 300 €"
    ]
    var addTypes = [ AdType.pictureVideo.rawValue, AdType.event.rawValue, AdType.podcast.rawValue ]
}
