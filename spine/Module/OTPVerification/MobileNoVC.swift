//
//  MobileNoVC.swift
//  spine
//
//

import SwiftUI

struct MobileNoVC: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var mobile: String = ""
    
    @State private var errorMessage: String = ""
    @State var showLoader: Bool = false
    
    @State var shouldShowAlert = false
    @State var message  = ""
    @State var closure: AlertAction?
    @State var isSuccess = true
    
    var viewModel: LoginViewModel? = LoginViewModel()
    var userID: String = ""
    
    
    var btnBack: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(ImageName.ic_back) // set image here
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
            }
        }
    }
    var body: some View {
        //        NavigationView {
        ZStack(alignment: .center) {
            VStack {
                VStack {
                    Text(K.appText.enterPhone)
                        .font(AppUtility.shared.appFont(type: .SemiBold, size: 14))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.init(white: 0.93))
                        .padding()
                    
                    HStack {
                        Text("GB +44")
                            .font(AppUtility.shared.appFont(type: .SemiBold, size: 16))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.init(white: 0.93))
                        Divider().frame(width: 1, height: 30, alignment: .center).background(Color.white)
                        TextField("Phone number", text: $mobile)
                            .foregroundColor(.white)
                            .accentColor(.white)
                            .frame(height: 35)
                            .background(Color.clear)
                            .autocapitalization(.none)
                            .font(AppUtility.shared.appFont(type: .regular, size: 16))
                            .keyboardType(.phonePad)
                            .onChange(of: mobile) { newValue in
                                print(newValue)
                            }
                    }
                    .padding([.top, .bottom], 5)
                    .padding([.leading, .trailing], 15)
                    .overlay(RoundedRectangle(cornerRadius: 35).stroke(Color.white, lineWidth: 2))
                    .padding(.bottom, 40)
                    
                    AppLoginButton(title: K.appButtonTitle.next, callback: {
                        self.errorMessage = self.mobileValidation()
                        if self.errorMessage == "" {
//                            self.message = "OTP Send successfully on mobile number"
                            self.doSendOTP()
                        }
                        else {
                            self.shouldShowAlert = true
                            self.isSuccess = false
                            self.message = self.errorMessage
                        }
                    })
                }
                .padding([.leading, .trailing], 60)
                Spacer()
            }
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
        .background(
            Image(ImageName.ic_background)
                .resizable()
                .scaleEffect()
                .edgesIgnoringSafeArea(.all)
        )
        .navigationBarItems(leading: btnBack)
        .navigationBarBackButtonHidden(true)
    }
    
    func mobileValidation() -> String {
        if _mobile.wrappedValue.count < 11 {
            return K.Messages.mobileLengthErr
        }
        else {
            return ""
        }
    }
}

//MARK:- Service Call
extension MobileNoVC {
    
    func doSendOTP() {
        self.hideKeyboard()
        let request = mobileVerificationRequestModel()
        request.mobile = self._mobile.wrappedValue
        request.userID = userID
        viewModel?.mobileVerificationCode(request) { (response, status) in
            if response?.status == true {
                if let message  = response?.message{
                   ShowToast.show(toatMessage: message)
                }
                self.presentationMode.wrappedValue.dismiss()
            } else if let message  = response?.message{
                ShowToast.show(toatMessage: message)
            }
        }
    }
}

struct MobileNoVC_Previews: PreviewProvider {
    static var previews: some View {
        MobileNoVC()
    }
}
