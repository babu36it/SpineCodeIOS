//
//  MessagingSettingsView.swift
//  spine
//
//  Created by Mac on 04/07/22.
//

import SwiftUI

enum WhoCanMessage: String, CaseIterable, Identifiable {
    var id: String { rawValue }
    case hosts = "Hosts of an event you're going to"
    case members = "Members of an event you're going to"
    case anyone = "Anyone on Spine"
}

struct MessagingSettingsView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("WhoCanMessage") private var whoCanMsg: WhoCanMessage = .anyone
    
    var body: some View {
        VStack(spacing: 0) {
            
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)
            VStack {
                List {
                    Section {
                        ForEach(WhoCanMessage.allCases) { item in
                            WhoCanMsgCell(item: item, selectedItem: $whoCanMsg)
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
                NavTitle(title: item.rawValue)
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
