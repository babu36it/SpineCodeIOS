//
//  ProfileCell.swift
//  Populist
//
//  Created by Bharat Jadav on 01/07/21.
//

import SwiftUI

struct ProfileCell: View {
    @State var strTitle : String = ""
    @State var strImage : String = ""
    @State var isHideArror  : Bool = false
    @State var isHideBG     : Bool = false
    
    var body: some View {
        HStack {
            Image(strImage)
                .frame(width : 30.0, height : 50.0)
                .padding(.leading, 10)
            Text(strTitle)
                .font(.custom(FontStyle.Montserrat_Regular.rawValue, size: 16))
                .foregroundColor(Color.init(K.appColors.primaryBlack))
                .padding(.leading, 10)
            Spacer()
            if isHideArror == false {
                Image(K.imgNames.arrowRight)
                    .frame(width : 50.0, height : 50.0)
            }
        }
        .background(isHideBG ? .clear : Color.init(K.appColors.grey4)).cornerRadius(10)
        .padding([.leading, .trailing], 10)
    }
}

struct ProfileCell_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCell(strTitle: K.appHeaderTitle.profile, strImage: K.imgNames.user)
    }
}
