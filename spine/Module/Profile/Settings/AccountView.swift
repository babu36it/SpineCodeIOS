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
    
    @StateObject private var accountViewVM: AccountViewViewModel = .init()
    
    var body: some View {
        VStack(spacing: 0) {
            
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)//.padding(.top, 10)
            List {
                NavigationLink(destination: ChangeEmailView()) {
                    NavTitle(title: "Change Email")
                }
                
                NavigationLink(destination: MessagingSettingsView()) {
                    NavTitle(title: "Messaging")
                }
                
                NavigationLink(destination: SaveEventsInCalndrView()) {
                    NavTitle(title: "Save events to calender")
                        .badge(accountViewVM.accountSettings?.eventCalenderStatus.toBool() == true ? "On": "Off")
                }
                
                NavigationLink(destination: SelectionListView(listViewModel: LanguagesListViewModel())) {
                    NavTitle(title: "Language")
                        .badge(accountViewVM.language?.name)
                }
                .onChange(of: AppUtility.shared.userInfo?.data?.defaultLanguageID) { _ in
                    accountViewVM.getSelectedLanguage()
                }

                NavigationLink(destination: SelectionListView(listViewModel: CurrenciesListViewModel())) {
                    NavTitle(title: "Currency")
                        .badge(accountViewVM.currency?.title)
                }
                .onChange(of: AppUtility.shared.userInfo?.data?.defaultCurrencyID) { _ in
                    accountViewVM.getSelectedCurrency()
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
            }
            .listStyle(.plain)
            .onAppear {
                accountViewVM.loadAccountSettings()
            }
            .padding(.top, 30)
        }
        .modifier(LoadingView(isLoading: $accountViewVM.showLoader))
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


