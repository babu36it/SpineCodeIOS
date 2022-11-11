//
//  ChangePasswordVC.swift
//  Populist
//
//  Created by Bharat Jadav on 02/07/21.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI

struct ChangePasswordVC: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var strTitle: String
    @State var isFromLogin: Bool
    @State var mobileNo: String
    
    @State private var oldPassword  : String = ""
    @State private var newPassword  : String = ""
    @State private var confPassword : String = ""
    
    //Alert Parameters
    @State private var sessionExpire: Int? = 0
    @State var shouldShowAlert    = false
    @State var message  = ""
    @State var closure  : AlertAction?
    @State var isSuccess = true
    
    var viewModel : ProfileViewModel? = ProfileViewModel()
    @State var showLoader: Bool = false
    @State private var errorMessage : String = ""
    
    var btnBack : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        })
        {
            HStack {
                Image(K.imgNames.backButton) // set image here
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                Text(strTitle)
                    .font(.custom(FontStyle.Montserrat_SemiBold.rawValue, size: 20))
                    .foregroundColor(Color.init(K.appColors.primaryBlack))
            }
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                if !isFromLogin {
                    FloatingLabelTextField($oldPassword, placeholder: K.placeHolders.oldPassword)
                        .isSecureTextEntry(true)
                        .floatingStyle(ThemeTextFieldStyle())
                        .padding()
                        .keyboardType(.default)
                        .frame(height: 50)
                }
                
                FloatingLabelTextField($newPassword, placeholder: K.placeHolders.newPassword)
                    .isSecureTextEntry(true)
                    .floatingStyle(ThemeTextFieldStyle())
                    .padding()
                    .keyboardType(.default)
                    .frame(height: 50)
                FloatingLabelTextField($confPassword, placeholder: K.placeHolders.confPassword)
                    .isSecureTextEntry(true)
                    .floatingStyle(ThemeTextFieldStyle())
                    .padding()
                    .keyboardType(.default)
                    .frame(height: 50)
                AppButtons(title: K.appButtonTitle.saveChanges, callback: {
                    self.errorMessage = self.formValidation()
                    if self.errorMessage == "" {
                        self.showLoader = true
                        self.updatePassword()
                    }
                    else {
                        self.shouldShowAlert = true
                        self.isSuccess = false
                        self.message = self.errorMessage
                    }
                })
                Spacer()
            }
            .padding(.top, 30)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: btnBack)
            .navigationBarBackButtonHidden(true)
            .onTapGesture {
                self.hideKeyboard()
            }
            if shouldShowAlert {
                AlertView(shown: $shouldShowAlert, closureA: $closure, isSuccess: self.isSuccess, message: self.message, buttonTitle: K.appButtonTitle.ok, isShowButton: true, isShowCancel: false).buttonAction {
                    shouldShowAlert = false
                    if AppUtility.shared.apiErrorCode == ServerErrorCode.sessionExpire.rawValue {
                        self.sessionExpire = Session.expire.rawValue
                        AppUtility.shared.apiErrorCode = ServerErrorCode.none.rawValue
                    }
                }
            }
            //Navigate To Login Session Expire
            NavigationLink(destination:  LoginVC(), tag: 2, selection: self.$sessionExpire) {
                EmptyView()
            }
            IndicatorView(isAnimating: $showLoader)
        }
    }
    
    func formValidation() -> String {
        if isFromLogin {
            if _newPassword.wrappedValue.isValid == false {
                return K.Messages.newPasswordErr
            }
            else if !AppUtility.shared.isValidPassword(_newPassword.wrappedValue) {
                return K.Messages.passwordValidErr
            }
            else if _confPassword.wrappedValue.isValid == false {
                return K.Messages.confirmPassError
            }
            else if _confPassword.wrappedValue != _newPassword.wrappedValue {
                return K.Messages.passMatchError
            }
            else {
                return ""
            }
        }
        else {
            if _oldPassword.wrappedValue.isValid == false {
                return K.Messages.passwordError
            }
            else if _newPassword.wrappedValue.isValid == false {
                return K.Messages.newPasswordErr
            }
            else if !AppUtility.shared.isValidPassword(_newPassword.wrappedValue) {
                return K.Messages.passwordValidErr
            }
            else if _confPassword.wrappedValue.isValid == false {
                return K.Messages.confirmPassError
            }
            else if _confPassword.wrappedValue != _newPassword.wrappedValue {
                return K.Messages.passMatchError
            }
            else {
                return ""
            }
        }
    }
}

struct ChangePasswordVC_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordVC(strTitle: K.appHeaderTitle.changePassword, isFromLogin: true, mobileNo: "")
    }
}

//MARK:- API Webservice Call
extension ChangePasswordVC {
    func updatePassword() {
        if isFromLogin {
            var params = [String : Any]()
            params["phone"] = mobileNo
            params["password"] = _newPassword.wrappedValue
            
            self.viewModel?.resetPassword(parameters: params, completion: { (success, error) in
                if success {
                    DispatchQueue.main.async {
                        AppUtility.shared.userSettings.islogin = false
                        self.sessionExpire = Session.expire.rawValue
                        //NavigationUtil.popToRootView()
                    }
                }
                else {
                    if let err = error as NSError?, err.code == ServerErrorCode.sessionExpire.rawValue {
                        AppUtility.shared.apiErrorCode = ServerErrorCode.sessionExpire.rawValue
                    }
                    self.shouldShowAlert = true
                    self.isSuccess = false
                    self.message = AppUtility.shared.apiResponseMessage
                }
                self.showLoader = false
            })
            
        }
        else {
            var params = [String : Any]()
            params["password"]      = _oldPassword.wrappedValue
            params["new_password"]  = _newPassword.wrappedValue
            
            self.viewModel?.updatePassword(parameters: params, completion: { (success, error) in
                if success {
                    DispatchQueue.main.async {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                else {
                    self.shouldShowAlert = true
                    self.isSuccess = success
                    self.message = AppUtility.shared.apiResponseMessage
                    if let err = error as NSError?, err.code == ServerErrorCode.sessionExpire.rawValue {
                        AppUtility.shared.apiErrorCode = ServerErrorCode.sessionExpire.rawValue
                    }
                }
                self.showLoader = false
            })
        }
    }
}
