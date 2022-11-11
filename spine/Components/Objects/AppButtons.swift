//
//  AppButtons.swift
//  spine

import SwiftUI

struct AppButtons: View {
    let title: String
    var anim: Bool = false
    //let callback: ()->()
    var callback: (() -> Void)?

    var body: some View {
//        Button(title) {
//            callback()
//        }
//        //.disabled(true)
//        //.padding()
//        .frame(width: 200.0, height: 45.0)
//        .background(Color.init(K.appColors.purple))
//        .foregroundColor(.white)
//        .font(.custom(FontStyle.Montserrat_SemiBold.rawValue, size: 16))
//        .clipShape(Capsule())
//        .scaleEffect(CGFloat(anim ? 1.2 : 1))
//        .contentShape(Rectangle())
        
        if nil != callback {
            Button(action: callback!, label: {
                Text(title)
                    .frame(width: 200.0, height: 45.0)
            })
            .frame(width: 200.0, height: 45.0)
            .background(K.appColors.primaryBlack)
            .foregroundColor(.white)
            .font(.custom(FontStyle.Montserrat_SemiBold.rawValue, size: 16))
            .clipShape(Capsule())
        }
        
    }
}

struct AppButtons_Previews: PreviewProvider {
    static var previews: some View {
        AppButtons(title: "Next", callback: {
            
        })
    }
}
