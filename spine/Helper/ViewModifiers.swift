//
//  ViewModifiers.swift
//  spine
//
//  Created by Mac on 07/07/22.
//

import Foundation
import SwiftUI

struct BackButtonModifier: ViewModifier {
    var fColor: Color = .primary
    var action: () -> Void
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                action()
            }){
                Image(systemName: ImageName.chevronLeft)
                    .foregroundColor(fColor)
            })
    }
}

public struct DarkModeViewModifier: ViewModifier {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    public func body(content: Content) -> some View {
        content
            .environment(\.colorScheme, isDarkMode ? .dark : .light)
            .preferredColorScheme(isDarkMode ? .dark : .light) // tint on status bar
    }
}
