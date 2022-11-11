//
//  HeaderTitleView.swift
//  spine


import SwiftUI

struct HeaderTitleView : View {
    let title : String
    
    init(title : String) {
        self.title = title
    }
    var body: some View {
        Text(self.title)
//            .font(.custom(FontStyle.Montserrat_SemiBold.rawValue, size: 24))
            .font(.system(size: 24))
            .foregroundColor(Color.white)
            .padding(.top)
    }
}

struct HeaderTitleView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderTitleView(title: K.appHeaderTitle.spine)
    }
}
