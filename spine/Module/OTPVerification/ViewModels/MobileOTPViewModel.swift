//
//  MobileOTPViewModel.swift
//  spine
//
//  Created by Mac on 16/11/22.
//

import Foundation
import FirebaseAuth

enum OTPError: Error {
    case lengh
}

class MobileOTPViewModel: ObservableObject {
    @Published var errorMessage: String = ""
    @Published var showLoader: Bool = false
    
    @Published var shouldShowAlert = false
    @Published var isSuccess = true
    
    @Published var phoneNumber = ""
    @Published var yPickerPosition: CGFloat = 200
    @Published var countryCode = "44"
    @Published var countryFlag = "🇬🇧"

    @Published var userID: String = ""
    
    func mobileNumberVerified(completion: @escaping (Bool, Error?) -> Void) {
        showLoader = true
        let request = MobileVerificationRequestModel()
        request.mobile = phoneNumber
        request.userID = userID
        LoginViewModel.shared.mobileVerificationCode(request) { [weak self] response, status in
            if response?.status == true {
                completion(true, nil)
            } else {
                self?.errorMessage = response?.message ?? "Unable to verify the mobile "
                self?.shouldShowAlert = true
                self?.isSuccess = false

                completion(false, nil)
            }
            self?.showLoader = false
        }
    }
    
    func signInWithPhoneNumber(completion: @escaping (Bool, Error?) -> Void) {
        let userPhone: String = "+\(countryCode)\(phoneNumber)"
        guard phoneNumber.count >= 10 else {
            errorMessage = K.Messages.mobileLengthErr
            shouldShowAlert = true
            isSuccess = false

            completion(false, OTPError.lengh)
            return
        }
        
        // Change language code to french.
        // Auth.auth().languageCode = "fr"

        PhoneAuthProvider.provider()
          .verifyPhoneNumber(userPhone, uiDelegate: nil) { [weak self] verificationID, error in
              if let error = error {
                  self?.errorMessage = error.localizedDescription
                  self?.shouldShowAlert = true
                  self?.isSuccess = false
                  completion(false, error)
              } else {
                  UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                  completion(true, nil)
              }
          }
    }
    
    func verifyOTP(_ otp: String, completion: @escaping (Bool, Error?) -> Void) {
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else { return }
        // Sign in using the verificationID and the code sent to the user
        // ...
        let credential: PhoneAuthCredential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: otp)
        Auth.auth().signIn(with: credential) { [weak self] authResult, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
                self?.shouldShowAlert = true
                self?.isSuccess = false

                completion(false, error)
            } else {
                print(String(describing: authResult))
                completion(true, nil)
            }
        }
    }
}
