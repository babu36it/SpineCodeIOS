//
//  PinVerificationVC.swift
//  Populist
//
//  Created by Bharat Jadav on 28/06/21.
//

import SwiftUI
import SVPinView
import UIKit
import Firebase

struct PinVerificationVC: View {
    @Environment(\.presentationMode) var presentationMode
    @State var showLoader: Bool = false
    @State var code = ""
    @Binding var ID : String
    @State private var isValidated: Bool   = false
    @State var isSignup : Int? = 0
    @State private var selection : Int? = 0
    
    //Alert Parameters
    @State private var sessionExpire: Int? = 0
    @State var shouldShowAlert    = false
    @State var message  = ""
    @State var closure  : AlertAction?
    @State var isSuccess = true
    
    var params : [String : Any]
    var viewModel : LoginViewModel? = LoginViewModel()
    
    var body: some View {
        ZStack {
            let mobileNo = params["phone"] as? String ?? ""
            VStack() {
                HeaderView()
                HeaderTitleView(title: K.appHeaderTitle.pinVerification)
                VStack {
                    Text(K.appText.pinSent)
                        .padding()
                        .frame(height: 20)
                        .multilineTextAlignment(.center)
                        .font(.custom(FontStyle.Montserrat_Medium.rawValue, size: 14))
                        .foregroundColor(Color.init(K.appColors.grey1))
                    Text(verbatim: mobileNo.toPhoneNumber())
                        .padding()
                        .frame(height: 20)
                        .multilineTextAlignment(.center)
                        .font(.custom(FontStyle.Montserrat_Medium.rawValue, size: 14))
                        .foregroundColor(Color.init(K.appColors.purple))
                    HStack {
                        OTPWithKAPin(numberofElement: 6) { (pinNumber) in
                            self.code = pinNumber
                        }
                    }
                    .frame(height: 40)
                    .padding()
                    NavigationLink(destination: ChangePasswordVC(strTitle: K.appHeaderTitle.resetPassword, isFromLogin: true, mobileNo: mobileNo), tag: 1, selection: self.$selection) {
                        EmptyView()
                    }
                    
                    NavigationLink(destination: PersonalDetailsVC(strTitle: K.appHeaderTitle.manageProfile, isFromSignup: true), tag: 2, selection: self.$selection) {
                        EmptyView()
                    }
                    
                    AppButtons(title: K.appButtonTitle.verify, callback: {
                        
                    })
                    .disabled(true)
                    .padding(.top)
                    .onTapGesture {
                        let credential =  PhoneAuthProvider.provider().credential(withVerificationID: self.ID, verificationCode: self.code)
                        showLoader = true
                        Auth.auth().signIn(with: credential) { (res, err) in
                            if err != nil{
                                self.message = err?.localizedDescription ?? ""
                                self.shouldShowAlert = true
                                self.isSuccess = false
                                return
                            }
                            if isSignup == 2 {
                                self.userRegistration()
                            }
                            else if isSignup == 3 {
                                self.updateMobileNumber(mobile: mobileNo)
                            }
                            else {
                                self.selection = self.isSignup
                                self.isValidated = true
                            }
                            showLoader = false
                        }
                    }
                    
                    Text(K.appButtonTitle.resendPin)
                        .font(.custom(FontStyle.Montserrat_SemiBold.rawValue, size: 16))
                        .foregroundColor(Color.init(K.appColors.purple))
                        .padding(.top)
                        .onTapGesture {
                            self.sendPinNumber(mobileNo)
                        }
                    HStack {
                        Text(K.appText.notYourMobile)
                            .font(.custom(FontStyle.Montserrat_Regular.rawValue, size: 16))
                            .foregroundColor(Color.init(K.appColors.grey1))
                        Text(K.appButtonTitle.change)
                            .font(.custom(FontStyle.Montserrat_SemiBold.rawValue, size: 16))
                            .foregroundColor(Color.init(K.appColors.purple))
                    }
                    .padding(.top)
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                Spacer()
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarHidden(true)
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
                    else {
                        DispatchQueue.main.async {
                            self.presentationMode.wrappedValue.dismiss()
                        }
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
    
    func sendPinNumber(_ mobileNo : String) {
        self.showLoader = true
        PhoneAuthProvider.provider().verifyPhoneNumber("+91"+mobileNo, uiDelegate: nil) { (ID, err) in
            if err != nil{
                self.message = err?.localizedDescription ?? ""
                self.shouldShowAlert = true
                self.isSuccess = false
                self.showLoader = false
                return
            }
            self.ID = ID!
            self.showLoader = false
        }
    }
}

//MARK:- API Webservice Call
extension PinVerificationVC {
    func userRegistration() {
        self.viewModel?.getRegisterUser(parameters: params, completion: { (success, error) in
            if success {
                self.selection = self.isSignup
                self.isValidated = true
            }
            else {
                self.message = AppUtility.shared.apiResponseMessage
                self.shouldShowAlert = true
                self.isSuccess = false
            }
            showLoader = false
        })
    }
    
    func updateMobileNumber(mobile: String) {
        self.viewModel?.updatePhoneNumber(parameters: params, completion: { (success, error) in
            if success {
                self.selection = self.isSignup
                self.isValidated = true
                self.message = AppUtility.shared.apiResponseMessage
                self.shouldShowAlert = true
                self.isSuccess = success
                AppUtility.shared.userSettings.userMobile = mobile
            }
            else {
                self.message = AppUtility.shared.apiResponseMessage
                self.shouldShowAlert = true
                self.isSuccess = success
                if let err = error as NSError?, err.code == ServerErrorCode.sessionExpire.rawValue {
                    AppUtility.shared.apiErrorCode = ServerErrorCode.sessionExpire.rawValue
                }
            }
            showLoader = false
        })
    }
}

//struct PinVerificationVC_Previews: PreviewProvider {
//    static var previews: some View {
//        PinVerificationVC(ID: "", params: <#Binding<[String : Any]>#>)
//    }
//}

struct OTPWithKAPin: UIViewRepresentable {
    var otpCode: String?
    var numberofElement: Int = 6
    var getotp : (_ code: String) -> ()
    
    class Coordinator: NSObject {
        var parent: OTPWithKAPin
        
        init(_ parent: OTPWithKAPin) {
            self.parent = parent
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) ->  SVPinView {
        let pinView:SVPinView = SVPinView()
        
        pinView.pinLength = numberofElement
        pinView.secureCharacter = "\u{25CF}"
        pinView.interSpace = CGFloat(10)
        pinView.textColor = UIColor.black
        pinView.shouldSecureText = true
        pinView.style = .underline
        
        pinView.borderLineColor = UIColor(named: K.appColors.grey2)!.withAlphaComponent(1.0)
        pinView.activeBorderLineColor = UIColor(named: K.appColors.grey2)!.withAlphaComponent(1.0)
        pinView.borderLineThickness = 1
        pinView.activeBorderLineThickness = 2
        
        pinView.font = UIFont(fontStyle: FontStyle.Montserrat_Regular, size: 16) ?? UIFont.systemFont(ofSize: 16)
        pinView.keyboardType = .phonePad
        pinView.keyboardAppearance = .default
        pinView.placeholder = "******"
        pinView.isContentTypeOneTimeCode = true
        pinView.updateFocusIfNeeded()
        pinView.becomeFirstResponderAtIndex = 0
        
        pinView.didFinishCallback = {  pin in
            AppUtility.shared.printToConsole("The pin entered is \(pin)")
        }
        
        pinView.didChangeCallback = { pin in
            self.getotp(pin)
        }
        
        return pinView
    }
    
    func updateUIView(_ uiView: SVPinView, context: Context) {
        
    }
}
