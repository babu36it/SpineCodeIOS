//
//  AboutVC.swift
//  Populist
//
//  Created by Bharat Jadav on 02/07/21.
//

import SwiftUI

struct AboutVC: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var strTitle : String
    @State var isNavBarHidden : Bool = false
    
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
                    NavigationLink(destination: CMSPageVC(strTitle: K.appText.termsCondition, isSelected: 1)) {
                        ProfileCell(strTitle: K.appText.termsCondition, strImage: K.imgNames.terms, isHideBG: true)
                    }
                    NavigationLink(destination: CMSPageVC(strTitle: K.appText.privacyPolicy, isSelected: 2)) {
                        ProfileCell(strTitle: K.appText.privacyPolicy, strImage: K.imgNames.privacy, isHideBG: true)
                    }
                    NavigationLink(destination: CMSPageVC(strTitle: K.appText.licences, isSelected: 3)) {
                        ProfileCell(strTitle: K.appText.licences, strImage: K.imgNames.licence, isHideBG: true)
                    }
                }
                .padding(.top)
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: btnBack)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(false)
        }
    }
}

struct AboutVC_Previews: PreviewProvider {
    static var previews: some View {
        AboutVC(strTitle: K.appHeaderTitle.about)
    }
}
