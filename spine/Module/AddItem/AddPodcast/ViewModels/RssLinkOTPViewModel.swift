//
//  RssLinkOTPViewModel.swift
//  spine
//
//  Created by Mac on 25/10/22.
//

import Foundation

class RssLinkOTPViewModel: ObservableObject {
    let serviceProvider = RssEmailOTPVerificationServiceProvider()
    let validateRssserviceProvider = ValidateRssServiceProvider()
    var verificationCode = ""
    @Published var isValidCode = false
    @Published var showLoader = false
    
    func validateOTP() {
        let parameters = ["otp": verificationCode]
        self.showLoader = true
        serviceProvider.validateRssOTP(postData: parameters) { result in
            DispatchQueue.main.async {
                self.showLoader = false
                switch result {
                case .success(let value):
                    self.isValidCode = value.status
                    if value.status {
                        ShowToast.show(toatMessage: "OTP is successfully validated.")
                    }
                case .failure(let error):
                    if error == .tokenExpired {
                        self.validateOTP()
                    } else {
                        self.isValidCode = false
                        ShowToast.show(toatMessage: "Please enter correct OTP.")
                    }
                }
            }
        }
    }
    
    func resendOTP() {
        let parameters = ["link": AddPodcastData.shared.rssLink]
        self.showLoader = true
        validateRssserviceProvider.validateRss(postData: parameters) { result in
            DispatchQueue.main.async {
                self.showLoader = false
                switch result {
                case .success(let value):
                    if value.status {
                        ShowToast.show(toatMessage: "OTP sent successfully")
                    }
                case .failure(let error):
                    print("error")
                    if error == .tokenExpired {
                        self.resendOTP()
                    } else {
                        ShowToast.show(toatMessage: "Error occured")
                    }
                }
            }
        }
    }
}
