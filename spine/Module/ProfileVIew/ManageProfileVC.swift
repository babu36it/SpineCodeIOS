//
//  ManageProfileVC.swift
//  Populist
//
//  Created by Bharat Jadav on 01/07/21.
//

import SwiftUI

struct ManageProfileVC: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var strTitle : String
    
    var btnBack : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        })
        {
            HStack {
                Image(K.imgNames.backButton) // set image here
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                Text(strTitle)
                    .font(.custom(FontStyle.Montserrat_SemiBold.rawValue, size: 20))
                    .foregroundColor(Color.init(K.appColors.primaryBlack))
            }
        }
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack {
                    NavigationLink(destination: PersonalDetailsVC(strTitle: K.appHeaderTitle.manageProfile, isFromSignup: false)) {
                        ProfileCell(strTitle: K.appHeaderTitle.personalDetails, strImage: K.imgNames.userBg, isHideBG: true)
                    }
                    NavigationLink(destination: UpdateMobileVC(strTitle: K.appHeaderTitle.manageMobile)) {
                        ProfileCell(strTitle: K.placeHolders.mobile, strImage: K.imgNames.phoneBg, isHideBG: true)
                    }
                    NavigationLink(destination: ChangePasswordVC(strTitle: K.appHeaderTitle.changePassword, isFromLogin: false, mobileNo: "")) {
                        ProfileCell(strTitle: K.appHeaderTitle.changePassword, strImage: K.imgNames.lock, isHideBG: true)
                    }
                }
                .padding(.top)
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: btnBack)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ManageProfileVC_Previews: PreviewProvider {
    static var previews: some View {
        ManageProfileVC(strTitle: K.appHeaderTitle.manageProfile)
    }
}
