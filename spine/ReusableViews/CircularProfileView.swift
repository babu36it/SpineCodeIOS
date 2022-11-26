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

extension View {
    func circularBorder(radius: CGFloat, borderWidth: CGFloat = 2, borderColor: Color = .white, shadowRadius: CGFloat = 0, shadowColor: Color = .gray) -> some View {
        self.modifier(AddCircularBoder(radius: radius, borderWidth: borderWidth, borderColor: borderColor, shadowRadius: shadowRadius, shadowColor: shadowColor))
    }
    
    func badgify(size: CGSize, radius: CGFloat = 0, offset: CGSize = .zero, color: Color = .orange) -> some View {
        self.modifier(BadgeView(size: size, radius: radius, offset: offset, color: color))
    }
    
    func profileImage(radius: CGFloat, borderWidth: CGFloat = 2, borderColor: Color = .white, shadowRadius: CGFloat = 0, shadowColor: Color = .gray, badgeSize: CGSize = .zero, badgeCornerRadius: CGFloat = 0, badgeColor: Color = .orange, badgeOffset: CGSize = .zero) -> some View {
        self.modifier(AddCircularBoder(radius: radius, borderWidth: borderWidth, borderColor: borderColor, shadowRadius: shadowRadius, shadowColor: shadowColor))
        .modifier(BadgeView(size: badgeSize, radius: badgeCornerRadius, offset: badgeOffset, color: badgeColor))
    }
}

struct BadgeView: ViewModifier {
    let size: CGSize
    let radius: CGFloat
    let offset: CGSize
    let color: Color
    
    func body(content: Content) -> some View {
        if size == .zero {
            content
        } else {
            ZStack {
                content
                Rectangle()
                    .foregroundColor(color)
                    .cornerRadius(radius == 0 ? min(size.width, size.height) : radius)
                    .frame(width: size.width, height: size.height)
                    .offset(offset)
            }
        }
    }
}

struct AddCircularBoder: ViewModifier {
    let radius: CGFloat
    let borderWidth: CGFloat
    let borderColor: Color
    let shadowRadius: CGFloat
    let shadowColor: Color
    
    func body(content: Content) -> some View {
        content
            .frame(width: radius, height: radius)
            .clipShape(Circle())
            .overlay(Circle().stroke(borderColor, lineWidth: borderWidth))
            .shadow(color: shadowColor, radius: shadowRadius)
    }
}
