//
//  ForgotPasswordVC.swift
//  spine
//
//  Created by OM Apple on 03/05/22.
//

import SwiftUI


struct ForgotPasswordVC: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    @State private var emailId   : String = ""
    @State private var isLoginValid: Bool = false
    @State private var isNavigationBarHidden = true
    
    @State private var errorMessage: String = "0"
    @State var showLoader: Bool = false
    
    @State var shouldShowAlert    = false
    @State var message  = ""
    @State var closure  : AlertAction?
    @State var isSuccess = true
    @State private var selection : Int? = 0
    
    var viewModel : LoginViewModel? = LoginViewModel.shared
    var btnBack: some View { Button(action: {
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
        ZStack(alignment: .center) {
            VStack {
                HeaderTitleView(title: K.appHeaderTitle.forgotPassword).padding(.top, 100).font(AppUtility.shared.appFont(type: .regular, size: 18))
                VStack {
                    VStack {
                        TextField("Email", text: $emailId)
                            .foregroundColor(.white)
                            .accentColor(.white)
                            .padding()
                            .frame(height: 45)
                            .background(Color.clear)
                            .cornerRadius(25)
                            .autocapitalization(.none)
                            .font(AppUtility.shared.appFont(type: .regular, size: 16))
                            .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.white, lineWidth: 2))
                            .padding(.bottom, 20)
                            .keyboardType(.emailAddress)
                            .onChange(of: emailId) { newValue in
                                print(newValue)
                            }
                        
                      
                        
                        AppLoginButton(title: K.appButtonTitle.submit, callback: {
                            self.errorMessage = self.forgotPasswordValidation()
                            if self.errorMessage == "" {
                               self.doForgotPassword()
                            }
                            else {
                                self.shouldShowAlert = true
                                self.isSuccess = false
                                self.message = self.errorMessage
                            }
                        }
                        )
                       
                    }.padding(.top, 30)
                        .padding([.leading, .trailing], 30)
                }
                .padding([.leading, .trailing], 35)
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
    
    
    func forgotPasswordValidation() -> String {
        if _emailId.wrappedValue.isValid == false {
            return K.Messages.emailError
        } else if _emailId.wrappedValue.isValidEmail() == false {
            return K.Messages.validEmailError
        }
        else {
            return ""
        }
    }
}
extension ForgotPasswordVC {
    func doForgotPassword() {
        let request = ForgotPasswordRequestModel()
        request.email = self._emailId.wrappedValue
        viewModel?.forgotPassword(request) { (response, status) in
            if response?.status == true {
               
                if let message  = response?.message{
                   ShowToast.show(toatMessage: message)
                }
                self.presentationMode.wrappedValue.dismiss()
            }else{
              
                if let message  = response?.message{
                   ShowToast.show(toatMessage: message)
                }
                
            }
        }
    }
}


struct ForgotPasswordVC_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordVC()
     }
}
