//
//  PreferencesVC.swift
//  Populist
//
//  Created by Bharat Jadav on 02/07/21.
//

import SwiftUI

struct PreferencesVC: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var strTitle : String
    @State var showLoader: Bool = false
    
    //Alert Parameters
    @State private var sessionExpire: Int? = 0
    @State var shouldShowAlert    = false
    @State var message  = ""
    @State var closure  : AlertAction?
    @State var isSuccess = true
    
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
                    NotificationCell(strTitle: K.appHeaderTitle.notifications, strImage: K.imgNames.notificationTab, callback: { show, error in
                        self.shouldShowAlert = true
                        self.isSuccess = show
                        self.message = AppUtility.shared.apiResponseMessage
                        if let err = error as NSError?, err.code == ServerErrorCode.sessionExpire.rawValue {
                            AppUtility.shared.apiErrorCode = ServerErrorCode.sessionExpire.rawValue
                        }
                    })
                }
                .padding(.top)
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: btnBack)
            .navigationBarBackButtonHidden(true)
            IndicatorView(isAnimating: $showLoader)
            if shouldShowAlert {
                AlertView(shown: $shouldShowAlert, closureA: $closure, isSuccess: self.isSuccess, message: self.message, buttonTitle: K.appButtonTitle.ok, isShowButton: true, isShowCancel: false).buttonAction {
                    shouldShowAlert = false
                    if AppUtility.shared.apiErrorCode == ServerErrorCode.sessionExpire.rawValue {
                        self.sessionExpire = Session.expire.rawValue
                        AppUtility.shared.apiErrorCode = ServerErrorCode.none.rawValue
                    }
                }
            }
            //Navigate To Login Session Expire
            NavigationLink(destination:  LoginVC(), tag: 2, selection: self.$sessionExpire) {
                EmptyView()
            }
        }
    }
}

struct PreferencesVC_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesVC(strTitle: K.appHeaderTitle.preference)
    }
}
