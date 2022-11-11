//
//  CurrentScreen.swift
//  CustomTabBar


import SwiftUI

struct CurrentScreen: View {
    @Binding var currentView: Tab

    var body: some View {
        ZStack {
            if self.currentView == Tab.Ballots {
//                BallotListVC()
            }
            else if self.currentView == Tab.Notification {
//                NotificationVC()
            }
            else if self.currentView == Tab.Profile {
//                ProfileVC()
            }
        }
    }
}

struct CurrentScreen_Previews: PreviewProvider {
    static var previews: some View {
        CurrentScreen(currentView: .constant(.Ballots))
    }
}
