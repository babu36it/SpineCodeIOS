//
//  ToolBarButton.swift
//  spine
//
//  Created by Mac on 23/12/22.
//

import Foundation
import SwiftUI

struct ToolBarButton: ViewModifier {
    var image = "multiply"
    var action: () -> Void
    func body(content: Content) -> some View {
        content
            .toolbar {
                Button {
                    action()
                } label: {
                    Image(systemName: image)
                }.foregroundColor(.primary)
            }
    }
}
