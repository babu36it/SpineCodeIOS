//
//  ProfileVC.swift
//  Populist
//
//  Created by Bharat Jadav on 11/06/21.
//

import SwiftUI

struct ProfileVC: View {
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    
    var currentView: Tab = Tab.Profile
    @State private var isValidated          : Bool   = false
    
    var btnBack : some View {
        Button(action: {
        })
        {
            HStack {
                Text(K.appHeaderTitle.mySettings)
                    .font(.custom(FontStyle.Montserrat_SemiBold.rawValue, size: 20))
                    .foregroundColor(Color.init(K.appColors.primaryBlack))
            }
        }.disabled(true)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    NavigationLink(destination: ManageProfileVC(strTitle: K.appHeaderTitle.manageProfile)) {
                        ProfileCell(strTitle: K.appHeaderTitle.profile, strImage: K.imgNames.user)
                    }
                    NavigationLink(destination: PreferencesVC(strTitle: K.appHeaderTitle.preference)) {
                        ProfileCell(strTitle: K.appHeaderTitle.preference, strImage: K.imgNames.settings)
                    }
                    NavigationLink(destination: SupportVC(strTitle: K.appHeaderTitle.support)) {
                        ProfileCell(strTitle: K.appHeaderTitle.support, strImage: K.imgNames.phone)
                    }
                    NavigationLink(destination: AboutVC(strTitle: K.appHeaderTitle.about)) {
                        ProfileCell(strTitle: K.appHeaderTitle.about, strImage: K.imgNames.info)
                    }
//                    NavigationLink(destination: WelcomeView(), isActive: self.$isValidated) {
//                        ProfileCell(strTitle: K.appHeaderTitle.logout, strImage: K.imgNames.power, isHideArror: true)
//                        .onTapGesture {
//                            redirectToMainScreen()
//                            AppUtility.shared.userSettings.authToken = ""
//                            AppUtility.shared.userSettings.islogin = false
//                            self.isValidated = true
//                            //NavigationUtil.popToRootView()
//                        }
//                    }
                    ProfileCell(strTitle: K.appHeaderTitle.logout, strImage: K.imgNames.power, isHideArror: true)
                    .onTapGesture {
                        redirectToMainScreen()
                        AppUtility.shared.userSettings.authToken = ""
                        AppUtility.shared.userSettings.islogin = false
                        self.isValidated = true
                        //NavigationUtil.popToRootView()
                    }
                }
                .padding(.top)
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: btnBack)
            .navigationBarColor(UIColor.init(named: K.appColors.grey4), hideShadow: false)
        }
        //.navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func redirectToMainScreen() {
        if let window = UIApplication.shared.windows.first {
                let homeView = LoginVC()
                window.rootViewController = UIHostingController(rootView: homeView)
                window.makeKeyAndVisible()
            }
    }
    
//    func LaunchLoginView(){
//        let vContoller = UIHostingController(rootView: LoginVC())
//        appDelegate.loadNewRootSwiftUIView(rootViewController: vContoller)
//        NavigationUtil.popToRootView()
//    }
}

struct ProfileVC_Previews: PreviewProvider {
    static var previews: some View {
        ProfileVC()
    }
}
