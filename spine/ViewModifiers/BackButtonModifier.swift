//
//  BackButtonModifier.swift
//  spine
//
//  Created by Mac on 23/12/22.
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
