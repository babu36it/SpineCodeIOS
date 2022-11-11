//
//  TabBar.swift
//  CustomTabBar


import SwiftUI

struct TabBar: View {
    @Binding var currentView: Tab

    var body: some View {
        HStack() {
            TabBarItem(currentView: self.$currentView, title: "", imageName: K.imgNames.bellTab, paddingEdges: .leading, tab: .Notification)
                .padding(.leading, 20)
            Spacer()
            TabBarItem(currentView: self.$currentView, title: K.appHeaderTitle.ballots, imageName: K.imgNames.homeTab, paddingEdges: .horizontal, tab: .Ballots)
            Spacer()
            TabBarItem(currentView: self.$currentView, title: "", imageName: K.imgNames.profileTab, paddingEdges: .trailing, tab: .Profile)
                .padding(.trailing, 20)
        }
        .frame(height: 72.0)
        .background(Color.init(K.appColors.grey4))
        .shadow(color: Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.05), radius: 0, x: 0, y: -2)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(currentView: .constant(.Ballots))
    }
}
