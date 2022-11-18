//
//  AccountView.swift
//  spine
//
//  Created by Mac on 04/07/22.
//

import SwiftUI

struct AccountView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("isDarkMode") private var isDarkModeOn = false
    @AppStorage("saveEvent") private var saveEvent = false    
    
    var body: some View {
        VStack(spacing: 0) {
            
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)//.padding(.top, 10)
            List {
                //LazyVStack {
                NavigationLink(destination: ChangeEmailView()) {
                    NavTitle(title: "Change Email")
                }
                
                NavigationLink(destination: MessagingSettingsView()) {
                    NavTitle(title: "Messaging")
                }
                
                NavigationLink(destination: SaveEventsInCalndrView()) {
                    NavTitle(title: "Save events to calender")
                        .badge(saveEvent ? "On": "Off")
                }
                
                NavigationLink(destination: SelectionListView(listViewModel: LanguagesListViewModel())) {
                    NavTitle(title: "Language")
                        .badge(AppUtility.shared.userInfo?.data?.languages)
                }
                
                NavigationLink(destination: SelectionListView(listViewModel: CurrenciesListViewModel())) {
                    NavTitle(title: "Currency")
                        .badge(AppUtility.shared.userInfo?.data?.defaultCurrencyID)
                }
                
                Toggle("Dark mode", isOn: $isDarkModeOn)
                    .font(.Poppins(type: .regular, size: 16))
                    .padding(.vertical, 5)
                    .tint(.lightBrown)
                
                NavigationLink(destination: VerifyAccountView()) {
                    NavTitle(title: "Verify my account")
                }
                
                NavigationLink(destination: DeactivateAccntView()) {
                    NavTitle(title: "Deactivate my account")
                }
                // }
            }.listStyle(.plain)
                //.frame(height: 250)
                .padding(.top, 30)
            
        }
        .navigationBarTitle("ACCOUNT", displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}


