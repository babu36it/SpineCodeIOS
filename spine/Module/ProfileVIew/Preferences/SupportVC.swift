//
//  SupportVC.swift
//  Populist
//
//  Created by Bharat Jadav on 02/07/21.
//

import SwiftUI

struct SupportVC: View {
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
                    ProfileCell(strTitle: "support@votepopulist.org", strImage: K.imgNames.email, isHideArror: true, isHideBG: true)
                        .onTapGesture {
                            EmailHelper.shared.sendEmail(subject: "Feedback", body: "", to: "support@votepopulist.org")
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

struct SupportVC_Previews: PreviewProvider {
    static var previews: some View {
        SupportVC(strTitle: K.appHeaderTitle.support)
    }
}
