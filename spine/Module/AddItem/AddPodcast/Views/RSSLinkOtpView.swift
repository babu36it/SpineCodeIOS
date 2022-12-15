//
//  RSSLinkOtpView.swift
//  spine
//
//  Created by Mac on 31/05/22.
//

import SwiftUI

struct RSSLinkOtpView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var rssLinkOTPVM = RssLinkOTPViewModel()
    
    var body: some View {
        VStack {
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4).padding(.top, 10)
                .padding(.bottom, 20)
            VStack(spacing: 30) {
                Text("A verification code has been sent to the\n email address of the entered RSS feed\n (\(UserCredentials.retrieve()?.email ?? "NA")).\n\n Enter this code to verify you are the\n owner of the podcast. Please check junk\n folder in case code is not received.")
                    .font(.Poppins(type: .regular, size: 16))
                    .multilineTextAlignment(.center)
                HStack {
                    OTPWithKAPin(numberofElement: 4, color: UIColor(.primary)) { currentCode in
                        print("currentCode =====> \(currentCode)")
                        print("userID")
                    } didFinishCallback: { OTPNumber in
                        rssLinkOTPVM.verificationCode = OTPNumber
                    }
                }.frame(height: 40).padding()
                
                LargeButton(title: "NEXT", width: UIScreen.main.bounds.size.width - 60, height: 40, bColor: Color.lightBrown, fSize: 15, fColor: .white) {
                    rssLinkOTPVM.validateOTP()
                }.padding(.top, 20)
                
                Button("Resend code") {
                    rssLinkOTPVM.resendOTP()
                }
                NavigationLink("", isActive: $rssLinkOTPVM.isValidCode) {
                    PodcastInfoView()
                }
            }
            Spacer()
        }.modifier(LoadingView(isLoading: $rssLinkOTPVM.showLoader))
        .navigationBarTitle(Text("ENTER CODE"), displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
    }
}

struct RSSLinkOtpView_Previews: PreviewProvider {
    static var previews: some View {
        RSSLinkOtpView()
    }
}

