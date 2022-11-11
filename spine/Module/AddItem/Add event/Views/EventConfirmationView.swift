//
//  EventConfirmationView.swift
//  spine
//
//  Created by Mac on 16/06/22.
//

import SwiftUI

struct EventConfirmationView: View {
    @Environment(\.dismiss) var dismiss
    let screenWidth = UIScreen.main.bounds.size.width
    var body: some View {
        VStack(alignment: .leading) {
            VStack(spacing: 0) {
                HStack {
                    ButtonWithSystemImage(image: ImageName.multiply, size: 15) {
                        dismiss()
                    }
                    Spacer()
                    Title2(title: "THANK YOU")
                    Spacer()
                    
                }.padding()
                LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)
            }
            
            VStack(spacing: 30) {
                
                LargeCheckMark()
                Title3(title: "Your event is live on the Spiritual\n Network App")
                    .multilineTextAlignment(.center)
                
                LargeButton(title: "GO TO EVENT", width: screenWidth - Kconstant.filterPadding, height: 40, bColor: Color.lightBrown, fSize: 15, fColor: .white) {
                    print("Tapped")
                }
                
                LargeButton(title: "ADD ANOTHER EVENT", width: screenWidth - Kconstant.filterPadding, height: 40, bColor: Color.lightBrown, fSize: 15, fColor: .white) {
                    print("Tapped")
                }
                
            }.padding(.horizontal, Kconstant.filterPadding/2)
                .padding(.top, 20)
            
            Spacer()
        }.padding(.vertical, 10)
    }
}

struct EventConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        EventConfirmationView()
    }
}
