//
//  UpdateMobileVC.swift
//  Populist
//
//  Created by Bharat Jadav on 01/07/21.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI
import Firebase

struct UpdateMobileVC: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var strTitle : String
    @State private var mobile   : String = AppUtility.shared.userSettings.userMobile.toPhoneNumber()
    
    @State var showLoader: Bool = false
    @State private var isValidated: Bool   = false
    @State private var errorMessage: String = ""
    
    //Alert Parameters
    @State private var sessionExpire: Int? = 0
    @State var shouldShowAlert    = false
    @State var message  = ""
    @State var closure  : AlertAction?
    @State var isSuccess = true
    
    @State var ID = ""
    @State var params = [String : Any]()
    
    var viewModel : LoginViewModel? = LoginViewModel()
    
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
            ScrollView {
                VStack {
                    FloatingLabelTextField($mobile, placeholder: K.placeHolders.mobile)
                        .floatingStyle(ThemeTextFieldStyle())
                        .padding()
                        .keyboardType(.phonePad)
                        .frame(height: 50)
                        .onChange(of: mobile) {
                            print($0)
                            mobile = mobile.toPhoneNumber()
                        }
                    Spacer()
                    NavigationLink(destination: PinVerificationVC(ID: $ID, isSignup : 3, params: params), isActive: self.$isValidated) {
                        AppButtons(title: K.appButtonTitle.sendPin, callback: {
                            self.errorMessage = self.mobileValidation()
                            if self.errorMessage == "" {
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
                                    params["phone"] = mobileNo
                                }
                            }
                            else {
                                self.message = self.errorMessage
                                self.shouldShowAlert = true
                                self.isSuccess = false
                            }
                        })
                    }
                    .padding(.top, 20)
                }
                .padding(.top, 30)
            }
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
    
    func mobileValidation() -> String {
        if _mobile.wrappedValue.isValid == false {
            return K.Messages.mobileNoError
        }
        else if _mobile.wrappedValue.count < 14 {
            return K.Messages.mobileLengthErr
        }
        else {
            return ""
        }
    }
}

struct UpdateMobileVC_Previews: PreviewProvider {
    static var previews: some View {
        UpdateMobileVC(strTitle: K.appHeaderTitle.manageMobile)
    }
}

//MARK:- API Webservice Call
extension UpdateMobileVC {
    func updateMobileNumber()  {
        self.showLoader = true
        self.viewModel?.updatePhoneNumber(parameters: params, completion: { (success, error) in
            if success {
                self.message = AppUtility.shared.apiResponseMessage
                self.shouldShowAlert = true
                self.isSuccess = success
            }
            else {
                if let err = error as NSError?, err.code == ServerErrorCode.sessionExpire.rawValue {
                    AppUtility.shared.apiErrorCode = ServerErrorCode.sessionExpire.rawValue
                }
                self.message = AppUtility.shared.apiResponseMessage
                self.shouldShowAlert = true
                self.isSuccess = success
            }
            self.showLoader = false
        })
    }
}
