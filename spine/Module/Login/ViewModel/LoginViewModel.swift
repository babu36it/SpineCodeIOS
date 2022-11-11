//
//  LoginViewModel.swift
//  spine


import Foundation
import ObjectMapper

class  LoginViewModel{
    
}

extension LoginViewModel {
    // MARK: - signIn Webservice
    func signIn(_ request: signInRequestModel,  completion: @escaping (_ response:signInResponseModel?,_ result: Bool) -> Void) {
        ShowHud.show()
        AlamofireClient<signInResponseModel>.responseObjectNew(APIRequest(.signin(parameters: request.toJSON()))) { (response, error) in
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
                completion(response, true)
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
               // res.save()
                completion(response, true)
            } else  {
                if let error = error {
                   ShowToast.show(toatMessage: error.errorMessage ?? "")
                }
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
                print(res)
                res.save()
                completion(response,true)
            } else  {
                if let error = error {
                    ShowToast.show(toatMessage: error.errorMessage ?? "")
              }
                completion(response,false)
            }
        }
    }
}
