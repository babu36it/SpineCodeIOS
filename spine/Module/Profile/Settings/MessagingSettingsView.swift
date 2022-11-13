//
//  MessagingSettingsView.swift
//  spine
//
//  Created by Mac on 04/07/22.
//

import SwiftUI

struct MessagingSettingsView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var authorizationViewModel: MessagingSettingsViewModel = .init()
    
    var body: some View {
        VStack(spacing: 0) {
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)
            VStack {
                List {
                    Section {
                        ForEach(WhoCanMessage.allCases) { item in
                            WhoCanMsgCell(item: item, selectedItem: $authorizationViewModel.authorization)
                        }
                        .listRowSeparator(.hidden)
                    } header: {
                        VStack {
                            FooterView(text: "WHO CAN MESSAGE YOU?", fsize: 12)
                            Divider()
                        }
                    } footer: {
                        FooterView(text: "Controls who can manage you directly on Spine. Members will see amessage icon next to your name or your profile when they're able to message you").padding(.top)
                            .listRowSeparator(.hidden)
                    }
                }.listStyle(.plain)
            }
        }
        .onAppear(perform: {
            authorizationViewModel.getMessageAuthorizationStatus()
        })
        .modifier(LoadingView(isLoading: $authorizationViewModel.showLoader))
        .navigationBarTitle("MESSAGING", displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
    }
}

struct MessagingSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        MessagingSettingsView()
    }
}

struct WhoCanMsgCell: View {
    let item: WhoCanMessage
    @Binding var selectedItem: WhoCanMessage
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                NavTitle(title: item.description)
                Spacer()
                if selectedItem == item {
                    Image(systemName: ImageName.checkmark).foregroundColor(.lightBrown).frame(width: 10, height: 10)
                }
            }
            Divider()
        }.onTapGesture {
            selectedItem = item
        }
    }
}
