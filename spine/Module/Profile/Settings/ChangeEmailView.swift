//
//  ChangeEmailView.swift
//  spine
//
//  Created by Mac on 04/07/22.
//

import SwiftUI

struct ChangeEmailView: View {
    @Environment(\.dismiss) var dismiss
    @State var email = ""
    @State var showAlert = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)
            
            VStack(spacing: 30) {
                CustomTextFieldWithCount(searchText: $email, placeholder: "Enter")
                    .onSubmit {
                        if email.isValidEmail() {
                            
                        } else {
                            showAlert = true
                        }
                    }
                FooterView(text: "Your email address will not change until you confirm it via email")
            }.padding(.top, 40)
            .padding(.horizontal, 20)
            Spacer()
            
        }
        .alert("Email is invalid", isPresented: $showAlert, actions: {
            //Button("OK") {}
        })
        .navigationBarTitle("CHANGE EMAIL", displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
    }
}

struct ChangeEmailView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeEmailView()
    }
}

