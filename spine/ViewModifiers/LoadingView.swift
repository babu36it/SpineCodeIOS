//
//  LoadingView.swift
//  spine
//
//  Created by Mac on 17/12/22.
//

import SwiftUI


struct LoadingView: ViewModifier {
    @Binding var isLoading: Bool
    func body(content: Content) -> some View {
        ZStack {
            content
            if isLoading {
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

