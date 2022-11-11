//
//  UserProfileViewModel.swift
//  spine
//
//  Created by Mac on 03/07/22.
//

import SwiftUI
import Foundation

class UserProfileViewModel: ObservableObject {
    @Published var name = ""
    @Published var displayName = ""
    @Published var aboutMe = ""
    @Published var interestedIn = ""
    @Published var categories = ""
    @Published var donationLink = ""
    @Published var offerDescription = ""
    @Published var perfArea = ""
    @Published var diseasePattrns = ""
    @Published var category = ""
    @Published var language = ""
    @Published var qualification = ""
    
    @Published var companyName = ""
    @Published var street1 = ""
    @Published var street2 = ""
    @Published var street3 = ""
    @Published var city = ""
    @Published var postCode = ""
    @Published var country = ""
    @Published var googleListing = ""
    @Published var metaverseAddrs = ""
    @Published var website = ""
    @Published var email = ""
    
    @Published var phoneCode = ""
    @Published var phoneNumber = ""
    @Published var mobileCode = ""
    @Published var mobileNumber = ""
}
