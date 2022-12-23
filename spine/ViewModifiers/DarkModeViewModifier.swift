//
//  DarkModeViewModifier.swift
//  spine
//
//  Created by Mac on 23/12/22.
//

import Foundation
import SwiftUI

public struct DarkModeViewModifier: ViewModifier {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    public func body(content: Content) -> some View {
        content
            .environment(\.colorScheme, isDarkMode ? .dark : .light)
            .preferredColorScheme(isDarkMode ? .dark : .light) // tint on status bar
    }
}
