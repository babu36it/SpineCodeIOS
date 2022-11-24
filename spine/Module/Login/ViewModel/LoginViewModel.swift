//
//  LoginViewModel.swift
//  spine


import Foundation
import ObjectMapper

class LoginViewModel {
    func signIn(emailId: String, password: String, deviceToken: String, deviceType: String = "iPhone", completion: @escaping (_ response:signInResponseModel?,_ result: Bool) -> Void) {
        let request = signInRequestModel()
        request.email = emailId
        request.password = password
        request.devicetoken = "saaadasd"
        request.devicetype = "iPhone"
        
        signIn(request, completion: completion)
    }
}

extension LoginViewModel {
    // MARK: - signIn Webservice
    func signIn(_ request: signInRequestModel, completion: @escaping (_ response:signInResponseModel?,_ result: Bool) -> Void) {
        ShowHud.show()
        AlamofireClient<signInResponseModel>.responseObjectNew(APIRequest(.signin(parameters: request.toJSON()))) { (response, error) in
            ShowHud.hide()
            if let res = response {
                if res.status == true {
                    res.save()
                }
                AppUtility.shared.refreshUserInfo()
                completion(response, true)
            } else  {
                if let error = error {
                   ShowToast.show(toatMessage: error.errorMessage ?? "")
                }
                completion(response, false)
            }
        }
    }
    
    // MARK: - socialsignin Webservice
    func socialLogin(_ request: socialLoginRequestModel,  completion: @escaping (_ response:signInResponseModel?,_ result: Bool) -> Void) {
        ShowHud.show()
        AlamofireClient<signInResponseModel>.responseObjectNew(APIRequest(.socialLogin(parameters: request.toJSON()))) { (response, error) in
            ShowHud.hide()
            if let res = response {
                if res.status == true {
                    res.save()
                }
                completion(response, true)
            } else  {
                if let error = error {
                   ShowToast.show(toatMessage: error.errorMessage ?? "")
                }
                completion(response, false)
            }
        }
    }

    // MARK: - signUp Webservice
    func signUp(_ request: signUpRequestModel,  completion: @escaping (_ response:signInResponseModel?,_ result: Bool) -> Void) {
        ShowHud.show()
        AlamofireClient<signInResponseModel>.responseObjectNew(APIRequest(.signup(parameters: request.toJSON()))) { (response, error) in
            ShowHud.hide()
            if let res = response {
                completion(res, true)
            } else  {
                if let error = error {
                   ShowToast.show(toatMessage: error.errorMessage ?? "")
                }
                completion(response, false)
            }
        }
    }
    
    // MARK: - forgotPassword Webservice
    func forgotPassword(_ request: forgotPasswordRequestModel,  completion: @escaping (_ response:forgotPasswordResponseModel?,_ result: Bool) -> Void) {
        ShowHud.show()
        AlamofireClient<forgotPasswordResponseModel>.responseObjectNew(APIRequest(.forgotpassword(parameters: request.toJSON()))) { (response, error) in
            ShowHud.hide()
            if let res = response {
                print(res)
                completion(response, true)
            } else  {
                if let error = error {
                   ShowToast.show(toatMessage: error.errorMessage ?? "")
                }
                completion(response, false)
            }
        }
    }
    
    // MARK: - mobileVerificationCode Webservice
    func mobileVerificationCode(_ request: mobileVerificationRequestModel,  completion: @escaping (_ response:signInResponseModel?,_ result: Bool) -> Void) {
        ShowHud.show()
        AlamofireClient<signInResponseModel>.responseObjectNew(APIRequest(.userMobileVerification(parameters: request.toJSON()))) { (response, error) in
            ShowHud.hide()
            if let res = response {
                print(res)
                res.save()
                completion(response, true)
            } else  {
//                if let error = error {
//                   ShowToast.show(toatMessage: error.errorMessage ?? "")
//                }
                completion(response, false)
            }
        }
    }
    // MARK: - verifyOTP Webservice
    func verifyOTP(userID : String ,_ completion: @escaping (_ response:signInResponseModel?,_ status: Bool) -> Void) {
        ShowHud.show()
      
        AlamofireClient<signInResponseModel>.responseObjectNew(APIRequest(.userAccountVerify(userID: userID))) { (response, error) in
            ShowHud.hide()
            if let res = response {
                if res.status == true {
                    res.save()
                }
                completion(response,true)
            } else  {
                if let error = error {
                    ShowToast.show(toatMessage: error.errorMessage ?? "")
              }
                completion(response,false)
            }
        }
    }
    
    // MARK: - verifyOTP Webservice
    func resendEmailOTP(userID: String ,_ completion: @escaping (_ response:signInResponseModel?,_ status: Bool) -> Void) {
        ShowHud.show()
      
        AlamofireClient<signInResponseModel>.responseObjectNew(APIRequest(.resendEmailOTP(userID: userID))) { (response, error) in
            ShowHud.hide()
            if let res = response {
                completion(res, true)
            } else if let error = error {
                ShowToast.show(toatMessage: error.errorMessage ?? "")
                completion(response, false)
            }
        }
    }

    func userDetails(completion: @escaping (_ response:signInResponseModel?,_ status: Bool) -> Void) {
        EditProfileService().fetchUserDetails { result in
            switch result {
            case .success(let userResponse):
                if let jsonData: Data = try? JSONEncoder().encode(userResponse), let jsonString: String = String(data: jsonData, encoding: .utf8), let responseModel: signInResponseModel = .init(JSONString: jsonString) {
                    completion(responseModel, true)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
