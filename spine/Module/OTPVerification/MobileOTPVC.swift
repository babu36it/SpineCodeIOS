//
//  MobileOTPVC.swift
//  spine
//
//  Created by Mac on 17/11/22.
//

import SwiftUI

struct MobileOTPVC: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    //Alert Parameters
    @State var shouldShowAlert = false
    @State var closure: AlertAction?

    @StateObject var viewModel: MobileOTPViewModel
    
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
        
        ZStack(alignment: .center) {
            VStack() {
                VStack {
                    Text(K.appText.otpSent)
                        .font(AppUtility.shared.appFont(type: .regular, size: 14))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.init(white: 0.93))
                        .padding()
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                    HStack {
                        OTPWithKAPin(numberofElement: 6) { currentCode in
                            print("currentCode =====> \(currentCode)")
                            print(viewModel.userID)
                        } didFinishCallback: { OTPNumber in
                            viewModel.verifyOTP(OTPNumber) { status, error in
                                if let error = error {
                                    print(error)
                                } else {
                                    viewModel.mobileNumberVerified { status, error in
                                        if status {
                                            AppUtility.shared.redirectToMainScreen()
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .frame(height: 40)
                    .padding()
                }
                Spacer()
            }
            .onTapGesture {
                self.hideKeyboard()
            }
            
            if viewModel.shouldShowAlert {
                AlertView(shown: $viewModel.shouldShowAlert, closureA: $closure, isSuccess: self.viewModel.isSuccess, message: self.viewModel.errorMessage, buttonTitle: K.appButtonTitle.ok, isShowButton: true, isShowCancel: false).buttonAction {
                    viewModel.shouldShowAlert = false
                }
            }
            
            IndicatorView(isAnimating: $viewModel.showLoader)
        }
        .background(
            Image(ImageName.ic_background)
                .resizable()
                .scaleEffect()
                .edgesIgnoringSafeArea(.all)
        )
        .navigationTitle("OTP Verification")
        .navigationBarItems(leading: btnBack)
        .navigationBarBackButtonHidden(true)
        .accentColor(.white)
    }
}
