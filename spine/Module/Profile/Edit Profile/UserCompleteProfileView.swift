//
//  UserCompleteProfileView.swift
//  spine
//
//  Created by Mac on 03/07/22.
//

import SwiftUI

struct UserCompleteProfileView: View {
    
    @Binding var profileType: BusinessProfileType
    @Binding var professionalAcc: Bool
    @EnvironmentObject var profile: UserProfileViewModel
    
    var body: some View {
        LazyVStack(spacing: 30) {
            
            HStack(spacing: 10) {
                LargeButton(disable: false, title: "Practitioner listing", width: 150, height: 30, bColor: profileType == .practitioner ? .lightBrown : .lightBrown.opacity(0.5), fSize: 14, fColor: .white) {
                    profileType = .practitioner
                }
                LargeButton(disable: false, title: "Company listing", width: 150, height: 30, bColor: profileType == .company ? .lightBrown : .lightBrown.opacity(0.5), fSize: 14, fColor: .white) {
                    profileType = .company
                }
            }
            
            VStack(alignment: .leading) {
                EventDetailTitle(text: profileType == .practitioner ? "Name" : "Company Name")
                CustomTextFieldWithCount(searchText: $profile.name, placeholder: "Enter", count: 40)
            }
            VStack(alignment: .leading) {
                EventDetailTitle(text: "Display name")
                CustomTextFieldWithCount(searchText: $profile.displayName, placeholder: "Enter", count: 40)
            }
            
            VStack(alignment: .leading) {
                EventDetailTitle(text: profileType == .practitioner ? "About me" : "About us")
                CustomTextEditorWithCount(txt: $profile.aboutMe, placeholder: "Say something about you")
            }
            
            VStack(spacing: 30) {
                VStack(alignment: .leading) {
                    EventDetailTitle(text: profileType == .practitioner ? "Offer Description": "Offer Description of our company")
                    CustomTextEditorWithCount(txt: $profile.offerDescription, placeholder: "Add a description")
                }
                
                VStack(alignment: .leading) {
                    EventDetailTitle(text: "Key performance areas and methods")
                    CustomTextEditorWithCount(txt: $profile.perfArea, placeholder: "Add a description")
                }
                
                VStack(alignment: .leading) {
                    EventDetailTitle(text: "Desease patterns I treat")
                    CustomTextEditorWithCount(txt: $profile.diseasePattrns, placeholder: "Add a description")
                }
            }
            
            VStack(spacing: 30) {
                VStack(alignment: .leading) {
                    EventDetailTitle(text: "Category")
                    CustomTextFieldWithCount(searchText: $profile.category, placeholder: "Enter")
                }
                
                VStack(alignment: .leading) {
                    EventDetailTitle(text: "Languages of practise")
                    CustomTextFieldWithCount(searchText: $profile.language, placeholder: "Enter")
                }
                
                VStack(alignment: .leading) {
                    EventDetailTitle(text: "Qualifications")
                    CustomTextEditorWithCount(txt: $profile.qualification, placeholder: "Add a description")
                }
            }
            
            LazyVStack(spacing: 30) {
                
                VStack(alignment: .leading) {
                    Button {
                        
                    } label: {
                        Text(profileType == .practitioner ? "My Business Location" : "Our Business Location")
                            .underline()
                    }.tint(.primary)
                    Text("the more infos, the better to find your service")
                }.font(.Poppins(type: .regular, size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                

                
                VStack(alignment: .leading) {
                    EventDetailTitle(text: "Company name")
                    CustomTextFieldWithCount(searchText: $profile.companyName, placeholder: "company name if corporated")
                }
                
                VStack(alignment: .leading) {
                    EventDetailTitle(text: "Street")
                    CustomTextFieldWithCount(searchText: $profile.street1, placeholder: "Enter").padding(.bottom, 5)
                    CustomTextFieldWithCount(searchText: $profile.street2, placeholder: "Enter").padding(.bottom, 5)
                    CustomTextFieldWithCount(searchText: $profile.street3, placeholder: "Enter").padding(.bottom, 5)
                }
                
                VStack(alignment: .leading) {
                    EventDetailTitle(text: "City")
                    CustomTextFieldWithCount(searchText: $profile.city, placeholder: "Enter")
                }
                
                VStack(alignment: .leading) {
                    EventDetailTitle(text: "Postcode")
                    CustomTextFieldWithCount(searchText: $profile.postCode, placeholder: "Enter")
                }
                
                VStack(alignment: .leading) {
                    EventDetailTitle(text: "Country")
                    CustomTextFieldWithCount(searchText: $profile.country, placeholder: "Enter")
                }
                VStack(alignment: .leading) {
                    EventDetailTitle(text: "Connect with my google listing")
                    CustomTextFieldWithCount(searchText: $profile.googleListing, placeholder: "Enter")
                }
                
                VStack(alignment: .leading) {
                    EventDetailTitle(text: "Connect with my metaverse address")
                    CustomTextFieldWithCount(searchText: $profile.metaverseAddrs, placeholder: "Enter")
                }
                
                VStack(alignment: .leading) {
                    EventDetailTitle(text: "Website")
                    CustomTextFieldWithCount(searchText: $profile.website, placeholder: "Enter")
                }
                
                VStack(alignment: .leading) {
                    EventDetailTitle(text: "Contact email")
                    CustomTextFieldWithCount(searchText: $profile.email, placeholder: "Enter")
                }
                
            }
            
            VStack(spacing: 30) {
                VStack(alignment: .leading) {
                    EventDetailTitle(text: "Business phone number (public)")
                    HStack {
                        CustomTextFieldWithCount(searchText: $profile.phoneCode, placeholder: "Enter").frame(width: 80)
                        CustomTextFieldWithCount(searchText: $profile.phoneNumber, placeholder: "Enter")
                    }
                }
                
                VStack(alignment: .leading) {
                    EventDetailTitle(text: "Business mobile number(public)")
                    HStack {
                        CustomTextFieldWithCount(searchText: $profile.mobileCode, placeholder: "Enter").frame(width: 80)
                        CustomTextFieldWithCount(searchText: $profile.mobileNumber, placeholder: "Enter")
                    }
                }
                
                VStack(alignment: .leading) {
                    HStack(spacing: 2) {
                        EventDetailTitle(text: "Our donation link")
                        EventDetailDesc(text: "(will be displayed at DONATE)")
                    }
                    CustomTextFieldWithCount(searchText: $profile.donationLink, placeholder: "link to paypal or other gates for donation")
                }
            }
            
            LargeButton(title: "SAVE", width: 100, height: 30, bColor: .lightBrown, fSize: 12, fColor: .white) {
                print("saved")
            }
            
            Toggle(professionalAcc ? "SWITCH TO STANDARD ACCOUNT" : "SWITCH TO PROFESSIONAL ACCOUNT", isOn: $professionalAcc)
                .font(.Poppins(type: .regular, size: 14))
                .foregroundColor(.lightBrown)
                .tint(Color.lightBrown)
            
        }.padding(5)
    }
}


//struct UserCompleteProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserCompleteProfileView()
//    }
//}
