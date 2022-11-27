//
//  LoginViewModel.swift
//  spine


import Foundation
import ObjectMapper

class LoginViewModel {
    typealias SignInResponse = (_ response: SignInResponseModel?, _ result: Bool) -> Void
    
    private var isSigningIn: Bool = false
    private var completionHandlers: [SignInResponse] = []
    
    static let shared: LoginViewModel = .init()
    
    private init() { }
    
    func signIn(emailId: String, password: String, deviceToken: String = "saaadasd", deviceType: String = "iPhone", completion: @escaping SignInResponse) {
        let request = SignInRequestModel()
        request.email = emailId
        request.password = password
        request.devicetoken = deviceToken
        request.devicetype = deviceType
        
        if !isSigningIn {
            isSigningIn = true
            signIn(request) { [weak self] res, result in
                guard let self = self else { return }
                completion(res, result)
                
                while !self.completionHandlers.isEmpty {
                    let handler = self.completionHandlers.removeLast()
                    handler(res, result)
                }
                self.isSigningIn = false
            }
        } else {
            completionHandlers.append(completion)
        }
    }
}

extension LoginViewModel {
    // MARK: - signIn Webservice
    private func signIn(_ request: SignInRequestModel, completion: @escaping (_ response: SignInResponseModel?, _ result: Bool) -> Void) {
        ShowHud.show()
        AlamofireClient<SignInResponseModel>.responseObjectNew(APIRequest(.signin(parameters: request.toJSON()))) { (response, error) in
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
    func socialLogin(_ request: SocialLoginRequestModel, completion: @escaping (_ response: SignInResponseModel?, _ result: Bool) -> Void) {
        ShowHud.show()
        AlamofireClient<SignInResponseModel>.responseObjectNew(APIRequest(.socialLogin(parameters: request.toJSON()))) { (response, error) in
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
    func signUp(_ request: SignUpRequestModel, completion: @escaping (_ response: SignInResponseModel?, _ result: Bool) -> Void) {
        ShowHud.show()
        AlamofireClient<SignInResponseModel>.responseObjectNew(APIRequest(.signup(parameters: request.toJSON()))) { (response, error) in
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
    func forgotPassword(_ request: ForgotPasswordRequestModel, completion: @escaping (_ response: ForgotPasswordResponseModel?, _ result: Bool) -> Void) {
        ShowHud.show()
        AlamofireClient<ForgotPasswordResponseModel>.responseObjectNew(APIRequest(.forgotpassword(parameters: request.toJSON()))) { (response, error) in
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
    func mobileVerificationCode(_ request: MobileVerificationRequestModel, completion: @escaping (_ response: SignInResponseModel?, _ result: Bool) -> Void) {
        ShowHud.show()
        AlamofireClient<SignInResponseModel>.responseObjectNew(APIRequest(.userMobileVerification(parameters: request.toJSON()))) { (response, error) in
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
    func verifyOTP(userID : String ,_ completion: @escaping (_ response: SignInResponseModel?, _ status: Bool) -> Void) {
        ShowHud.show()
      
        AlamofireClient<SignInResponseModel>.responseObjectNew(APIRequest(.userAccountVerify(userID: userID))) { (response, error) in
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
    func resendEmailOTP(userID: String, _ completion: @escaping (_ response: SignInResponseModel?, _ status: Bool) -> Void) {
        ShowHud.show()
      
        AlamofireClient<SignInResponseModel>.responseObjectNew(APIRequest(.resendEmailOTP(userID: userID))) { (response, error) in
            ShowHud.hide()
            if let res = response {
                completion(res, true)
            } else if let error = error {
                ShowToast.show(toatMessage: error.errorMessage ?? "")
                completion(response, false)
            }
        }
    }

    func userDetails(completion: @escaping (_ response: SignInResponseModel?, _ status: Bool) -> Void) {
        EditProfileService().fetchUserDetails { result in
            switch result {
            case .success(let userResponse):
                if let jsonData: Data = try? JSONEncoder().encode(userResponse), let jsonString: String = String(data: jsonData, encoding: .utf8), let responseModel: SignInResponseModel = .init(JSONString: jsonString) {
                    completion(responseModel, true)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
