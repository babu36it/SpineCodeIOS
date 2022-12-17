//
//  IndicatorView.swift

import SwiftUI

struct IndicatorView1: View {
    @Binding var isAnimating: Bool
    
    var body: some View {
        VStack {
            if isAnimating {
                ZStack {
                    Color.black.opacity(0.30)
                        .edgesIgnoringSafeArea(.all)
                    
                    ActivityIndicator()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct IndicatorView: View {
    @Binding var isAnimating: Bool
    
    var body: some View {
        if isAnimating {
            ZStack {
                Color.black.opacity(0.30)
                    .edgesIgnoringSafeArea(.all)
                ZStack {
                    Color.lightBrown
                        .frame(width: 80, height: 80)
                        .cornerRadius(10)
                    ProgressView()//.tint(.lightBrown)
                        .scaleEffect(2)
                }
            }
        }
    }
}


struct IndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorView(isAnimating: .constant(true))
    }
}
