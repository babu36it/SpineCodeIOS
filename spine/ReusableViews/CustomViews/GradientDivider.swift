//
//  GradientDivider.swift
//  spine
//
//  Created by Mac on 23/12/22.
//

import SwiftUI

struct GradientDivider: View {
    var body: some View {
        LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top)
            .frame(height: 4)
    }
}

struct GradientDivider_Previews: PreviewProvider {
    static var previews: some View {
        GradientDivider()
    }
}
