//
//  TabBarItem.swift
//  CustomTabBar


import SwiftUI

struct TabBarItem: View {
    @Binding var currentView: Tab
    
    var title       : String
    let imageName   : String
    let paddingEdges: Edge.Set
    let tab: Tab
    
    var body: some View {
        HStack(spacing:0) {
            Image(self.currentView == tab ? imageName.appending("_fill") : imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 24, alignment: .center)
                .padding()
                
            if title != "" {
                Text(title)
                    .foregroundColor(self.currentView == tab ? K.appColors.primaryBlack : Color.init(K.appColors.grey1))
                    .font(.custom(FontStyle.Montserrat_SemiBold.rawValue, size: 17))
                    .padding(.leading, -5)
                    .padding(.trailing)
                
            }
        }
        .frame(height: 48)
        .background(self.currentView == tab ? Color.init(K.appColors.grey3) : Color.clear)
        .onTapGesture {
//            if self.currentView != self.tab {
                self.currentView = self.tab
//            }
        }
        .cornerRadius(30.0)
    }
}

struct TabBarItem_Previews: PreviewProvider {
    static var previews: some View {
        TabBarItem(currentView: .constant(.Ballots), title: K.appHeaderTitle.ballots, imageName: K.imgNames.homeTab, paddingEdges: .leading, tab: .Ballots)
    }
}
