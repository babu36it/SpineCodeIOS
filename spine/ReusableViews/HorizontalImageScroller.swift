//
//  HorizontalImageScroller.swift
//  spine
//
//  Created by Mac on 17/06/22.
//

import SwiftUI

struct HorizontalImageScroller: View {
    let images: [UIImage]
    
    private let screenWidth = UIScreen.main.bounds.size.width

    var body: some View {
        ZStack {
            Color.black
            if !images.isEmpty { //to avoid crash when no images added
                TabView {
                    ForEach(images, id: \.self){ image in
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: screenWidth, height: screenWidth/1.7)
                            .edgesIgnoringSafeArea(.top)
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .interactive))
            }
        }
        .frame(height: screenWidth/1.7)
    }
}
