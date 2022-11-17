//
//  spineApp.swift
//  spine

import SwiftUI

@main
struct spineApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
   
    var body: some Scene {
        WindowGroup {
            //if signInResponseModel.isUserLoggedIn()  {
            if AppUtility.shared.userSettings.authToken.isEmpty {
                TutorialView()
                    .modifier(DarkModeViewModifier())
            } else {
                TabBarView()
                    .modifier(DarkModeViewModifier())
            }
        }
    }
}
