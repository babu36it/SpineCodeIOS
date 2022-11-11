//
//  StandardUser.swift
//  spine
//
//  Created by Mac on 03/07/22.
//

import SwiftUI

enum BusinessProfileType {
    case practitioner
    case company
}

struct StandardUser: View {
    
    @EnvironmentObject var practnrProfile: UserProfileViewModel
//    @State var name = ""
//    @State var displayName = ""
//    @State var aboutMe = ""
//    @State var interestedIn = ""
//    @State var categories = ""
    
    @Binding var professionalAcc: Bool
    
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading) {
                HStack(spacing: 2) {
                    EventDetailTitle(text: "Name")
                    EventDetailDesc(text: "(will not be displayed)")
                }
                CustomTextFieldWithCount(searchText: $practnrProfile.name, placeholder: "Enter", count: 40)
            }
            VStack(alignment: .leading) {
                EventDetailTitle(text: "Display name")
                CustomTextFieldWithCount(searchText: $practnrProfile.displayName, placeholder: "Enter", count: 40)
            }
            
            VStack(alignment: .leading) {
                HStack(spacing: 2) {
                    EventDetailTitle(text: "Status")
                    EventDetailDesc(text: "(shown under your profile picture)")
                }
                CustomTextEditorWithCount(txt: $practnrProfile.aboutMe, placeholder: "Say something about you", count: 140)
            }
            
            VStack(alignment: .leading) {
                HStack(spacing: 2) {
                    EventDetailTitle(text: "Im interested in")
                    EventDetailDesc(text: "(will not be displayed)")
                }
                CustomTextFieldWithCount(searchText: $practnrProfile.interestedIn, placeholder: "Any text for search engines in the app", count: 40)
            }
            VStack(alignment: .leading) {
                HStack(spacing: 2) {
                    EventDetailTitle(text: "Categories I like")
                    EventDetailDesc(text: "(will not be displayed)")
                }
                CustomTextFieldWithCount(searchText: $practnrProfile.categories, placeholder: "Enter", count: 40)
            }
            
            VStack(alignment: .leading) {
                HStack(spacing: 2) {
                    EventDetailTitle(text: "My donation link")
                    EventDetailDesc(text: "(will be displayed at DONATE)")
                }
                CustomTextFieldWithCount(searchText: $practnrProfile.donationLink, placeholder: "link to paypal or other gates for donation")
            }
             
            Toggle(professionalAcc ? "SWITCH TO STANDARD ACCOUNT":"SWITCH TO PROFESSIONAL ACCOUNT", isOn: $professionalAcc)
                .font(.Poppins(type: .regular, size: 14))
                .foregroundColor(.lightBrown)
                .tint(Color.lightBrown)
            
        }.padding(5)
    }
}

//struct StandardUser_Previews: PreviewProvider {
//    static var previews: some View {
//        StandardUser()
//    }
//}
