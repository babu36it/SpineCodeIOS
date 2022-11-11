//
//  DeactivateAccntView.swift
//  spine
//
//  Created by Mac on 05/07/22.
//

import SwiftUI

struct DeactivateAccntView: View {
    @Environment(\.dismiss) var dismiss
    let screenWidth = UIScreen.main.bounds.size.width - 40
    
    var body: some View {
        VStack(spacing: 0) {
            
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)
            
            VStack(spacing: 40) {
                VStack(spacing: 20) {
                    Header4(title: C.StaticText.deactivateAccntTitle)
                    Title3(title: C.StaticText.deactivateAccntText)
                    LargeButton(title: "DEACTIVATE MY ACCOUNT", width: screenWidth, height: 50, bColor: .lightBrown, fSize: 15, fColor: .white) {
                        print("tapped deactivate")
                    }
                }
                
                VStack(spacing: 20) {
                    Header4(title: C.StaticText.deleteAccntTitle)
                    Title3(title: C.StaticText.deleteAccntText)
                    LargeButton(title: "DELETE MY ACCOUNT", width: screenWidth, height: 50, bColor: .lightBrown, fSize: 15, fColor: .white) {
                        print("tapped delete")
                    }
                }
            }.padding()
            Spacer()
        }
        .navigationBarTitle("DEACTIVATE MY ACCOUNT", displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
    }
}

struct DeactivateAccntView_Previews: PreviewProvider {
    static var previews: some View {
        DeactivateAccntView()
    }
}

