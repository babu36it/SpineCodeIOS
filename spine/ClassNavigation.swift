//
//  ClassNavigation.swift
//  spine


import Foundation
import SwiftUI

class ClassNavigation<Content: View>: ObservableObject {
    init(rootView : Content) {
        _ = NavigationLink(destination: rootView) {
            LoginVC()
        }
    }
}

class ViewRouter: ObservableObject {
    var currentPage: K.AppStates = .loginView
}
