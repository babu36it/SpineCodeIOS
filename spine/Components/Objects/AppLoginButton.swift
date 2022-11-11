//
//  AppLoginButton.swift
//  spine
//

import SwiftUI

struct AppLoginButton: View {
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
//                    .frame(width: 200.0, height: 45.0)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.system(size: 18))
                    .foregroundColor(K.appColors.appTheme)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.white, lineWidth: 2)
                    )
            })
            .background(Color.white)
            .frame(height: 45)
            .cornerRadius(25)
        }
    }
}

struct AppLoginButton_Previews: PreviewProvider {
    static var previews: some View {
        AppLoginButton(title: "Next", callback: {
            
        })
    }
}
