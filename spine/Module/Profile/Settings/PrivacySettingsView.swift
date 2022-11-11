//
//  PrivacySettingsView.swift
//  spine
//
//  Created by Mac on 05/07/22.
//

import SwiftUI

struct PrivacySettingsView: View {
    @AppStorage("findability") var findability = false
    @AppStorage("advertising") var advertising = false
    @AppStorage("customisation") var customisation = false
    @AppStorage("necessary") var necessary = false
    @AppStorage("item1") var item1 = true
    @AppStorage("item2") var item2 = true
    @AppStorage("googleMap") var googleMap = true
    @AppStorage("googleRecaptcha") var recaptcha = true
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)
            ScrollView {
                Divider().padding(.top, 20)
                CustomToggle(value: $findability, title: "Findability", subtitle: C.StaticText.findability)
                CustomToggle(value: $advertising, title: "Personalised advertising", subtitle: C.StaticText.findability)
                CustomToggle(value: $customisation, title: "Site customisation", subtitle: C.StaticText.findability)
                //CustomToggle(value: $necessary, title: "Strictly Necessary", subtitle: C.StaticText.necessary)
                CustomToggleView(title: "Strictly Necessary", subtitle: C.StaticText.necessary)
                
                CustomBasicToggle(value: $item1, title: "Lorem ipsum")
                CustomBasicToggle(value: $item2, title: "Lorem ipsum")
                CustomBasicToggle(value: $googleMap, title: "Google Maps")
                CustomBasicToggle(value: $recaptcha, title: "Google reCaptcha")
                
                Title4(title: C.StaticText.privacyPolicy, fColor: .lightBlackText)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }.padding()//.padding(.top, 20)
            Spacer()
        }
        .navigationBarTitle("HELP & INFO", displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
    }
}

struct PrivacySettingsView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacySettingsView()
    }
}
