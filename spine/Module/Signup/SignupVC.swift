//
//  SignupVC.swift
//  Populist
//
//  Created by Bharat Jadav on 10/06/21.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI
import Firebase

struct SignupVC: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var isValidated          : Bool   = false
    @State private var errorMessage         : String = ""
    
    @State var shouldShowAlert    = false
    @State var message  = ""
    @State var closure  : AlertAction?
    @State var isSuccess = true
    
    @State var firstName    : String = ""
    @State var lastName     : String = ""
    @State var mobile       : String = ""
    @State var password     : String = ""
    @State var cpassword    : String = ""
    @State var checked      : Bool   = false
    @State var isPhoneVerified : Int = 1
    
    @State var ID = ""
    @State var params = [String : Any]()
    
    var viewModel : LoginViewModel? = LoginViewModel()
    @State var showLoader: Bool = false
        
    var body: some View {
        ZStack {
            NavigationView {
                VStack(alignment: .center) {
                    HeaderView()
                    ScrollView {
                        HeaderTitleView(title: K.appHeaderTitle.createAccount)
                        VStack {
                            VStack {
                                FloatingLabelTextField($firstName, placeholder: K.placeHolders.firstName)
                                    .floatingStyle(ThemeTextFieldStyle())
                                    .padding()
                                    .keyboardType(.default)
                                    .frame(height: 50)
                                
                                FloatingLabelTextField($lastName, placeholder: K.placeHolders.lastName)
                                    .floatingStyle(ThemeTextFieldStyle())
                                    .padding()
                                    .keyboardType(.default)
                                    .frame(height: 50)
                                
                                FloatingLabelTextField($mobile, placeholder: K.placeHolders.mobile)
                                    .floatingStyle(ThemeTextFieldStyle())
                                    .padding()
                                    .keyboardType(.numberPad)
                                    .frame(height: 50)
                                    .onChange(of: mobile) {
                                        print($0)
                                        mobile = mobile.toPhoneNumber()
                                    }
                                
                                FloatingLabelTextField($password, placeholder: K.placeHolders.password)
                                    .isSecureTextEntry(true)
                                    .floatingStyle(ThemeTextFieldStyle())
                                    .padding()
                                    .keyboardType(.default)
                                    .frame(height: 50)
                                
                                FloatingLabelTextField($cpassword, placeholder: K.placeHolders.confPassword)
                                    .isSecureTextEntry(true)
                                    .floatingStyle(ThemeTextFieldStyle())
                                    .padding()
                                    .keyboardType(.default)
                                    .frame(height: 50)
                                HStack(spacing: 20) {
                                    Image(checked ? K.imgNames.check : K.imgNames.uncheck)
                                        .onTapGesture {
                                            self.checked.toggle()
                                        }
                                    NavigationLink(destination: CMSPageVC(strTitle: K.appText.termsCondition, isSelected: 1)) {
                                        HStack {
                                            Text(K.appText.iAgree)
                                                .font(.custom(FontStyle.Montserrat_Regular.rawValue, size: 16))
                                                .foregroundColor(Color.init(K.appColors.grey1))
                                            Text(K.appText.termsCondition)
                                                .font(.custom(FontStyle.Montserrat_SemiBold.rawValue, size: 16))
                                                .foregroundColor(Color.init(K.appColors.purple))
                                        }
                                    }
                                }
                            }
                            .padding(.top)
                            NavigationLink(destination: PinVerificationVC(ID: $ID, isSignup : 2, params: params), isActive: self.$isValidated) {
                                AppButtons(title: K.appButtonTitle.next, callback: {
                                    self.errorMessage = self.signupValidation()
                                    if self.errorMessage == "" {
                                        params["first_name"]    = _firstName.wrappedValue
                                        params["last_name"]     = _lastName.wrappedValue
                                        params["phone"]         = _mobile.wrappedValue
                                        params["password"]      = _password.wrappedValue
                                        params["device_token"]  = AppUtility.shared.fcmToken
                                        params["is_phone_verified"] = isPhoneVerified
                                        
                                        let mobileNo = _mobile.wrappedValue.getOnlyNumbers()
                                        PhoneAuthProvider.provider().verifyPhoneNumber("+91"+mobileNo, uiDelegate: nil) { (ID, err) in
                                            if err != nil{
                                                self.message = err?.localizedDescription ?? ""
                                                self.shouldShowAlert = true
                                                self.isSuccess = false
                                                return
                                            }
                                            
                                            self.ID = ID!
                                            self.isValidated.toggle()
                                        }

                                    }
                                    else {
                                        self.shouldShowAlert = true
                                        self.isSuccess = false
                                        self.message = self.errorMessage
                                    }
                                })
                                .padding(.top)
                            }
                            
                            HStack {
                                Text(K.appText.alreadyAccount)
                                    .font(.custom(FontStyle.Montserrat_Regular.rawValue, size: 16))
                                    .foregroundColor(Color.init(K.appColors.grey1))
                                Text(K.appHeaderTitle.login)
                                    .font(.custom(FontStyle.Montserrat_SemiBold.rawValue, size: 16))
                                    .foregroundColor(Color.init(K.appColors.purple))
                            }
                            .padding()
                            .onTapGesture {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                            
                        }
                    }
                }
                .edgesIgnoringSafeArea(.top)
                .navigationBarHidden(true)
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onTapGesture {
                self.hideKeyboard()
            }
            
            if shouldShowAlert {
                AlertView(shown: $shouldShowAlert, closureA: $closure, isSuccess: self.isSuccess, message: self.message, buttonTitle: K.appButtonTitle.ok, isShowButton: true, isShowCancel: false).buttonAction {
                    shouldShowAlert = false
                }
            }
            
            IndicatorView(isAnimating: $showLoader)
        }
    }
    
    func signupValidation() -> String {
        if _firstName.wrappedValue.isValid == false {
            return K.Messages.firstNameError
        }
        else if _lastName.wrappedValue.isValid == false {
            return K.Messages.lastNameError
        }
        else if _mobile.wrappedValue.isValid == false {
            return K.Messages.mobileNoError
        }
        else if _mobile.wrappedValue.count < 14 {
            return K.Messages.mobileLengthErr
        }
        else if _password.wrappedValue.isValid == false {
            return K.Messages.passwordError
        }
        else if !AppUtility.shared.isValidPassword(_password.wrappedValue) {
            return K.Messages.passwordValidErr
        }
        else if _cpassword.wrappedValue.isValid == false {
            return K.Messages.confirmPassError
        }
        else if _cpassword.wrappedValue != _password.wrappedValue {
            return K.Messages.passMatchError
        }
        else if !checked {
            return K.Messages.termsAcceptError
        }
        else {
            return ""
        }
    }
}

struct SignupVC_Previews: PreviewProvider {
    static var previews: some View {
        SignupVC()
    }
}
