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
            if let _ = AppUtility.shared.userInfo {
                TabBarView()
                    .modifier(DarkModeViewModifier())
            } else {
                TutorialView()
                    .modifier(DarkModeViewModifier())
            }
        }
    }
}
