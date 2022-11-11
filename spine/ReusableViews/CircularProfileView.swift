//
//  CircularProfileView.swift
//  spine
//
//  Created by Mac on 28/10/22.
//

import Foundation
import SwiftUI

// Duplicate CircularBorderedProfileView1
struct CircularBorderedProfileView: View {
    let image: String
    let size: CGFloat
    let borderWidth: CGFloat
    var showShadow = false
    var showBadge = false
    var borderClr: Color = .white
    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .frame(width: size, height: size)
                .clipShape(Circle())
                .overlay(Circle().stroke(borderClr, lineWidth: borderWidth))
                .shadow(color: .gray, radius: showShadow ? 5 : 0)
            if showBadge {
                CustomDotView(height: size/5)
                    .offset(x: sqrt((size * size) / 2)/2, y: -sqrt((size * size) / 2)/2)
            }
        }
    }
}

struct CircularBorderedProfileView1: View {
    let imageUrl: String
    let size: CGFloat
    let borderWidth: CGFloat
    var showShadow = false
    var showBadge = false
    var borderClr: Color = .white
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.gray
            }.background(.white)
            .frame(width: size, height: size)
            .clipShape(Circle())
            .overlay(Circle().stroke(borderClr, lineWidth: borderWidth))
            .shadow(color: .gray, radius: showShadow ? 5 : 0)
            
            if showBadge {
                CustomDotView(height: size/5)
                    .offset(x: sqrt((size * size) / 2)/2, y: -sqrt((size * size) / 2)/2)
            }
        }
    }
}

struct AddCircularBorderedProfileView: View {
    let image: UIImage
    let size: CGFloat
    let borderWidth: CGFloat
    var showShadow = false
    var showBadge = false
    var body: some View {
        ZStack {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: borderWidth))
            .shadow(color: .gray, radius: showShadow ? 5 : 0)
            if showBadge {
                CustomDotView(height: 12)
                   // .offset(x: size/2 )
                    .offset(x: sqrt((size * size) / 2)/2, y: -sqrt((size * size) / 2)/2)
            }
        }
    }
}
