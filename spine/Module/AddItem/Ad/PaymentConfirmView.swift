//
//  PaymentConfirmView.swift
//  spine
//
//  Created by Mac on 11/08/22.
//

import SwiftUI

struct PaymentConfirmView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)
                VStack {
                    Image(systemName: ImageName.checkmarkCircle)
                        .resizable()
                        .font(Font.title.weight(.light))
                        .frame(width: 35, height: 35)
                        .foregroundColor(.lightBrown)
                    Title3(title: "Once your ad is approved and\n payment is received, it will be\n published as promoted post on the\n Spiritual Network.\nThis can take up to 24 hours.", lineLimit: nil)
                        .multilineTextAlignment(.center)
                }.padding(30)
                Spacer()
            }
            .navigationBarTitle(Text("THANK YOU"), displayMode: .inline)
            .modifier(BackButtonModifier(action: {
                self.dismiss()
            }))
        }
        
        
    }
}

struct PaymentConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentConfirmView()
    }
}
