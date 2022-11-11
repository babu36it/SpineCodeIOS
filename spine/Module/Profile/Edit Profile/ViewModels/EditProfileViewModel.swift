//
//  EditProfileViewModel.swift
//  spine
//
//  Created by Mac on 09/11/22.
//

import Foundation
import SwiftUI
import Combine

class EditProfileViewModel: ObservableObject {
    let serviceProvider = EditProfileService(httpUtility: HttpUtility())
    @State var practnrProfile = UserProfileViewModel()
    @State var companyProfile = UserProfileViewModel()
    
    @Published var profileType: BusinessProfileType = .practitioner
    @Published var professionalAcc = false
    @Published var apiResponse: EditProfileResponseModel?
    @Published var showLoader = false
    
    @Published var showError = false
    @Published var showSuccess = false
    @Published var errorMessage: String?

    @Published var userImage: UIImage?
    private var userDetails: UserDetailResponse? {
        didSet {
            getUserImage()
        }
    }
    
    private var imageCancellable: AnyCancellable?
    private func getUserImage() {
        if let userDetails: UserDetailResponse = userDetails, let imageURL: URL = .init(string: "\(userDetails.image)\(userDetails.data.userImage)") {
            imageCancellable?.cancel()
            let session: URLSession = .shared
            let imagePublisher = session.dataTaskPublisher(for: imageURL)
                .map { (data, response) in UIImage(data: data) }
                .replaceError(with: nil)
                .receive(on: DispatchQueue.main)
            imageCancellable = imagePublisher.sink { [weak self] imgObj in
                self?.userImage = imgObj
            }
        }
    }
    
    func getUserProfile() {
        self.showLoader = true
        serviceProvider.fetchUserDetails() { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.showLoader = false
                switch result {
                case .success(let value):
                    self.userDetails = value
                    self.update(userProfile: self.practnrProfile, with: value.data)
                    self.update(userProfile: self.companyProfile, with: value.data)
                case .failure(let error):
                    print("error")
                    if error == .tokenExpired {
                        self.getUserProfile()
                    } else {
                        self.errorMessage = "Error in retrieving the profile data"
                        self.showError = true
                    }
                }
            }
        }
    }
    
    func saveProfile() {
        var requestParams: [String: Any] = [:]
        if profileType == .company {
            guard !companyProfile.name.isBlank else {
                errorMessage = "Please input valid name"
                showError = true
                return
            }
            guard !companyProfile.displayName.isBlank else {
                errorMessage = "Please input valid display name"
                showError = true
                return
            }
            guard !companyProfile.aboutMe.isBlank else {
                errorMessage = "Please input valid status"
                showError = true
                return
            }

            requestParams["account_type"] = "1"
            requestParams["listing_type"] = profileType == .company ? "2" : "1"
            requestParams["name"] = companyProfile.name
            requestParams["display_name"] = companyProfile.displayName
            requestParams["bio"] = companyProfile.aboutMe
            requestParams["category"] = companyProfile.category
            requestParams["interested"] = companyProfile.interestedIn
            requestParams["offer_desciption"] = companyProfile.offerDescription
            requestParams["key_perfomance"] = companyProfile.perfArea
            requestParams["desease_pattern"] = companyProfile.diseasePattrns
            requestParams["languages"] = companyProfile.language
            requestParams["qualification"] = companyProfile.qualification
            
            requestParams["company_name"] = companyProfile.companyName
            requestParams["street_1"] = companyProfile.street1
            requestParams["street_2"] = companyProfile.street2
            requestParams["street_3"] = companyProfile.street3
            requestParams["city"] = companyProfile.city
            requestParams["postcode"] = companyProfile.postCode
            requestParams["country"] = companyProfile.country
            requestParams["metaverse_address"] = companyProfile.metaverseAddrs
            requestParams["website"] = companyProfile.website
            requestParams["contact_email"] = companyProfile.email
            requestParams["business_phone"] = "\(companyProfile.phoneCode)\(companyProfile.phoneNumber)"
            requestParams["business_mobile"] = "\(companyProfile.mobileCode)\(companyProfile.mobileNumber)"
        } else {
            guard !practnrProfile.name.isBlank else {
                errorMessage = "Please input valid name"
                showError = true
                return
            }
            guard !practnrProfile.displayName.isBlank else {
                errorMessage = "Please input valid display name"
                showError = true
                return
            }
            guard !practnrProfile.aboutMe.isBlank else {
                errorMessage = "Please input valid status"
                showError = true
                return
            }

            requestParams["account_type"] = "0"
            requestParams["listing_type"] = "0"
            requestParams["name"] = practnrProfile.name
            requestParams["display_name"] = practnrProfile.displayName
            requestParams["bio"] = practnrProfile.aboutMe
            requestParams["category"] = practnrProfile.category
            requestParams["interested"] = practnrProfile.interestedIn
        }

        self.showLoader = true
        serviceProvider.saveProfile(postData: requestParams) { result in
            DispatchQueue.main.async { [weak self] in
                self?.showLoader = false
                switch result {
                case .success(let value):
                    self?.apiResponse = value
                    self?.showSuccess = true
                case .failure(let error):
                    print("error")
                    if error == .tokenExpired {
                        self?.saveProfile()
                    } else {
                        self?.errorMessage = "Error in saving the profile data"
                        self?.showError = true
                    }
                }
            }
        }
    }
}

extension EditProfileViewModel {
    func update(userProfile: UserProfileViewModel, with profileResponse: UserDetailResponseData) {
        userProfile.name = profileResponse.name
        userProfile.displayName = profileResponse.displayName
        userProfile.aboutMe = profileResponse.bio
        userProfile.interestedIn = profileResponse.interested
//        userProfile.categories = profileResponse.categories
//        userProfile.donationLink = profileResponse.donationLink
        userProfile.offerDescription = profileResponse.offerDesciption
        userProfile.perfArea = profileResponse.keyPerfomance
        userProfile.diseasePattrns = profileResponse.deseasePattern
        userProfile.category = profileResponse.category
        userProfile.language = profileResponse.languages
        userProfile.qualification = profileResponse.qualification
            
        userProfile.companyName = profileResponse.companyName
        userProfile.street1 = profileResponse.street1
        userProfile.street2 = profileResponse.street2
        userProfile.street3 = profileResponse.street3
        userProfile.city = profileResponse.city
        userProfile.postCode = profileResponse.postcode
        userProfile.country = profileResponse.country
//        userProfile.googleListing = profileResponse.googleListing
        userProfile.metaverseAddrs = profileResponse.metaverseAddress
        userProfile.website = profileResponse.website
        userProfile.email = profileResponse.email
            
//        userProfile.phoneCode = profileResponse.phoneCode
        userProfile.phoneNumber = profileResponse.businessPhone
//        userProfile.mobileCode = profileResponse.mobileCode
        userProfile.mobileNumber = profileResponse.mobile
    }
}
