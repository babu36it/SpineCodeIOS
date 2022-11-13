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
    @Published var images: [UIImage] = []
    @Published var backgroundImages: [UIImage] = []

    private(set) var alertTitle: String?
    private(set) var alertMessage: String?
    private(set) var shouldDismiss: Bool = false

    @Published var profileType: BusinessProfileType = .practitioner
    @Published var professionalAcc = false
    @Published var apiResponse: EditProfileResponseModel?
    @Published var showLoader = false
    
    @Published var showAlert = false
    @Published var userImage: UIImage?
    @Published var backgroundImage: UIImage?

    private var userDetails: UserDetailResponse? {
        didSet {
            getUserImage()
            getUserBackgroundImage()
        }
    }
    
    private var imageCancellable: AnyCancellable?
    private func getUserImage() {
        if let userDetails: UserDetailResponse = userDetails, let imageURL: URL = .init(string: "\(userDetails.image)\(userDetails.data.userImage)") {
            imageCancellable?.cancel()
            let imagePublisher = imageDownloadTask(with: imageURL)
            imageCancellable = imagePublisher.sink { [weak self] imgObj in
                self?.userImage = imgObj
            }
        }
    }
    
    private var bgImageCancellable: AnyCancellable?
    private func getUserBackgroundImage() {
        if let userDetails: UserDetailResponse = userDetails, let imageURL: URL = .init(string: "\(userDetails.image)\(userDetails.data.bgImage)") {
            bgImageCancellable?.cancel()
            let imagePublisher = imageDownloadTask(with: imageURL)
            bgImageCancellable = imagePublisher.sink { [weak self] imgObj in
                self?.backgroundImage = imgObj
            }
        }
    }

    private func imageDownloadTask(with imageURL: URL) -> any Publisher<UIImage?, Never> {
        URLSession.shared.dataTaskPublisher(for: imageURL)
            .map { (data, response) in UIImage(data: data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
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
                        self.alertTitle = "Oo Oh!"
                        self.alertMessage = "Error in retrieving the profile data"
                        self.showAlert = true
                    }
                }
            }
        }
    }
    
    func saveProfile() {
        let userProfileObj: UserProfileViewModel = profileType == .company ? companyProfile : practnrProfile

        var errorMessage: String?
        if userProfileObj.name.isEmpty {
            errorMessage = "Please enter valid name"
        } else if userProfileObj.displayName.isEmpty {
            errorMessage = "Please enter valid display name"
        } else if userProfileObj.aboutMe.isEmpty {
            errorMessage = "Please enter valid status"
        }
        guard errorMessage == nil else {
            alertTitle = "Invalid Input"
            alertMessage = errorMessage
            showAlert = true
            return
        }
        
        var requestParams: [String: Any] = [:]
        
        requestParams["name"] = userProfileObj.name
        requestParams["display_name"] = userProfileObj.displayName
        requestParams["bio"] = userProfileObj.aboutMe
        requestParams["category"] = userProfileObj.category
        requestParams["interested"] = userProfileObj.interestedIn

        if professionalAcc {
            requestParams["account_type"] = "1"
            requestParams["listing_type"] = profileType == .company ? "2" : "1"
            requestParams["offer_desciption"] = userProfileObj.offerDescription
            requestParams["key_perfomance"] = userProfileObj.perfArea
            requestParams["desease_pattern"] = userProfileObj.diseasePattrns
            requestParams["languages"] = userProfileObj.language
            requestParams["qualification"] = userProfileObj.qualification
            
            requestParams["company_name"] = userProfileObj.companyName
            requestParams["street_1"] = userProfileObj.street1
            requestParams["street_2"] = userProfileObj.street2
            requestParams["street_3"] = userProfileObj.street3
            requestParams["city"] = userProfileObj.city
            requestParams["postcode"] = userProfileObj.postCode
            requestParams["country"] = userProfileObj.country
            requestParams["metaverse_address"] = userProfileObj.metaverseAddrs
            requestParams["website"] = userProfileObj.website
            requestParams["contact_email"] = userProfileObj.email
            requestParams["business_phone"] = "\(userProfileObj.phoneCode)\(userProfileObj.phoneNumber)"
            requestParams["business_mobile"] = "\(userProfileObj.mobileCode)\(userProfileObj.mobileNumber)"
        } else {
            requestParams["account_type"] = "0"
            requestParams["listing_type"] = "0"
        }

        self.showLoader = true
        if let userImageObj: UIImage = images.first {
            serviceProvider.updateUserImage(userImageObj) { [weak self] imgUploadRes in
                print(imgUploadRes)
                if let userBgImageObj: UIImage = self?.backgroundImages.first {
                    self?.serviceProvider.updateUserBackgroundImage(userBgImageObj) { [weak self] bgUploadRes in
                        print(bgUploadRes)
                        self?.updateUserInformation(requestParams)
                    }
                } else {
                    self?.updateUserInformation(requestParams)
                }
            }
        } else {
            if let userBgImageObj: UIImage = backgroundImages.first {
                serviceProvider.updateUserBackgroundImage(userBgImageObj) { [weak self] bgUploadRes in
                    print(bgUploadRes)
                    self?.updateUserInformation(requestParams)
                }
            } else {
                updateUserInformation(requestParams)
            }
        }
    }
    
    private func updateUserInformation(_ userInfo: [String: Any]) {
        serviceProvider.saveProfile(postData: userInfo) { result in
            DispatchQueue.main.async { [weak self] in
                self?.showLoader = false
                switch result {
                case .success(let value):
                    self?.apiResponse = value
                    self?.alertTitle = "Success"
                    self?.alertMessage = value.message
                    self?.shouldDismiss = true
                    self?.showAlert = true
                case .failure(let error):
                    if error == .tokenExpired {
                        self?.saveProfile()
                    } else {
                        self?.alertTitle = "Oo Oh!"
                        self?.alertMessage = "Error in saving the profile data"
                        self?.showAlert = true
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
