//
//  CMSPageVC.swift
//  Populist
//
//  Created by Bharat Jadav on 10/06/21.
//

import SwiftUI
import WebKit

struct CMSPageVC: View {
    @Environment(\.presentationMode) var presentationMode
    @State var showLoader: Bool = true
    @State var strTitle : String = ""
    @State var strDesc  : String = ""
    @State var isSelected : Int = 1
    var cmsViewModel : CMSViewModel? = CMSViewModel()
    
    
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
            VStack() {
                 if showLoader == false {
                     HeaderView()
                     HeaderTitleView(title: strTitle)
                     SwiftUIWebView(viewModel: WebViewModel(htmlContent: self.strDesc))
                         .padding()
                     Text(K.appButtonTitle.cancel)
                         .font(.custom(FontStyle.Montserrat_SemiBold.rawValue, size: 16))
                         .foregroundColor(Color.init(K.appColors.purple))
                         .padding(.top)
                         .onTapGesture {
                             self.presentationMode.wrappedValue.dismiss()
                         }
                     Spacer()
                 }
            }.onAppear(perform: fetchDetails)
            .edgesIgnoringSafeArea(.top)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: btnBack)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            IndicatorView(isAnimating: $showLoader)
        }
    }
    
    func fetchDetails() {
        cmsViewModel?.getCMSPageDetails(resourceType: .cmsPagesTermsCondition, completion: { (success, error) in
            self.strDesc = cmsViewModel?.cmsData?.desc?.stringValue ?? ""
            self.showLoader = false
        })
    }
}

struct CMSPageVC_Previews: PreviewProvider {
    static var previews: some View {
        CMSPageVC()
    }
}
