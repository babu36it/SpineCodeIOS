//
//  spineApp.swift
//  spine

import SwiftUI
import FBSDKCoreKit
@main
struct spineApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
   
    var body: some Scene {
        WindowGroup {
            //if signInResponseModel.isUserLoggedIn()  {
            if AppUtility.shared.userSettings.authToken != "" {
                TabBarView()
                    .modifier(DarkModeViewModifier())
            } else {
                TutorialView()
                    .modifier(DarkModeViewModifier())
           }
        }
    }
}
