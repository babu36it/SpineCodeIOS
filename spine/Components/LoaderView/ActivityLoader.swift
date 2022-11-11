//
//  ActivityLoader.swift
//  spine

import SwiftUI

struct ActivityLoader: UIViewRepresentable {
    var animate : Bool
    
    //Make UI
    func makeUIView(context: UIViewRepresentableContext<ActivityLoader>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: .large)
    }
    
    //update UI
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityLoader>) {
        uiView.startAnimating()
    }
}
