//
//  CustomButtons.swift
//  spine
//
//  Created by Mac on 03/08/22.
//

import Foundation
import SwiftUI

struct LargeRectangeButton: View {
    let title: String
    var bColor: Color
    var height: CGFloat = 100
    var onTapped: ()-> Void
    var body: some View {
        ZStack {
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .foregroundColor(bColor).opacity(0.2)
            Button(title){
                onTapped()
            }.font(.Poppins(type: .regular, size: 14))
                .foregroundColor(.lightBrown)
        }.padding(.horizontal, 20)
    }
}

struct BackgroundFlipBtn: View {
    let title: String
    var fSize: CGFloat = 15
    var enabled: Bool = true
    var hPadding: CGFloat = 15
    var vPadding: CGFloat = 5
    var onTapped: () -> Void
    var body: some View {
        Button {
            onTapped()
        } label: {
            Text(title)
                .font(.Poppins(type: .regular, size: fSize))
                .padding(.vertical, vPadding)
                .padding(.horizontal, hPadding)
                .foregroundColor(enabled ? .white : .lightBrown)
                .background(enabled ? Color.lightBrown : .white)
                .cornerRadius(15 + vPadding)
                .overlay(
                    RoundedRectangle(cornerRadius: 15 + vPadding)
                        .stroke(Color.lightBrown, lineWidth: 1.0)
                )
                
        }

    }
}

struct LargeButton: View {
    var disable: Bool = false
    let title: String
    let width: CGFloat
    let height: CGFloat
    let bColor: Color
    let fSize: CGFloat
    let fColor: Color
    var font: String = "Poppins"
    var img: String = ""
    var action: ()-> Void
    var body: some View {
        Button(action: {
            action()
        }) {
            HStack {
                Text(title)
                if img != "" {
                    Image(systemName: img)
                        .font(.title3)
                }
            }
            //.font(.custom(font, size: fSize))
            .font(.Poppins(type: .regular, size: fSize))
            .frame(width: width , height: height, alignment: .center)
        }.disabled(disable)
        .background(bColor).opacity(disable ? 0.7 : 1)
        .foregroundColor(fColor)
        .cornerRadius(width/2)
    }
}

struct CustomButton: View {
    let image: String
    var onTapped: () -> Void
    var body: some View {
        Button {
            onTapped()
        } label: {
            Image(image)
                .resizable()
                .frame(width: 20, height: 20)
        }
    }
}

struct SystemButton: View {
    let image: String
    var font: Font = .title2
    var onTapped: () -> Void
    var body: some View {
        Button {
            onTapped()
        } label: {
            Image(systemName: image)
                .font(font)
        }.tint(.primary)
    }
}

struct ButtonWithCustomImage: View {
    let image: String
    let size: CGFloat
    var mode: ContentMode = .fill
    var btnTapped: ()-> Void
    var body: some View {
        Button {
            btnTapped()
        } label: {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: mode)
                .frame(width: size, height: size)
        }

    }
}

struct ButtonWithCustomImage2: View {
    let image: String
    let size: CGFloat
    var fColor: Color? = .primary
    var btnTapped: ()-> Void
    var body: some View {
        Button {
            btnTapped()
        } label: {
            Image(image)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .foregroundColor(fColor)
        }

    }
}

struct ButtonWithSystemImage: View {
    let image: String
    let size: CGFloat
    var fColor: Color? = .primary
    var btnTapped: ()-> Void
    var body: some View {
        Button {
            btnTapped()
        } label: {
            Image(systemName: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .foregroundColor(fColor)
        }.foregroundColor(fColor)

    }
}

