//
//  Router.swift
//  spine


import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
//            if AppUtility.shared.userSettings.islogin {
//                MainTabView()
//            }
//            else {
                LoginVC()
//            }
        }
        .navigationBarHidden(true)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
