//
//  ChangeEmailView.swift
//  spine
//
//  Created by Mac on 04/07/22.
//

import SwiftUI

struct ChangeEmailView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var changeEmailViewModel: ChangeEmailViewModel = .init()

    var body: some View {
        VStack(spacing: 0) {
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)
            
            VStack(spacing: 30) {
                CustomTextFieldWithCount(searchText: $changeEmailViewModel.emailId, placeholder: "Email", keyboardType: .emailAddress, autoCapitalization: .never)
                FooterView(text: "Your email address will not change until you confirm it via the requested email")
            }.padding(.top, 40)
            .padding(.horizontal, 20)
            Spacer()
        }
        .modifier(LoadingView(isLoading: $changeEmailViewModel.showLoader))
        .alert(changeEmailViewModel.alertTitle, isPresented: $changeEmailViewModel.showAlert, actions: {
            if changeEmailViewModel.shouldDismiss {
                Button("OK") { self.dismiss() }
            }
        }, message: {
            Text(changeEmailViewModel.alertMessage)
        })
        .navigationBarTitle("CHANGE EMAIL", displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
        .navigationBarItems(trailing: LargeButton(title: "UPDATE", width: 60, height: 22, bColor: Color.lightBrown, fSize: 12, fColor: .white) {
            changeEmailViewModel.updateEmailAddress()
        })
    }
}

struct ChangeEmailView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeEmailView()
    }
}

