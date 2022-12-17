//
//  CustomImageView.swift
//  spine
//
//  Created by Mac on 10/08/22.
//

import Foundation
import SwiftUI

struct BannerImageStringView: View {
    let imageStr: String
    var width: CGFloat
    var height: CGFloat
    var body: some View {
        Image(imageStr)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
            .clipped()
    }
}

struct BannerImageDataView: View {
    let imageData: UIImage
    var width: CGFloat
    var height: CGFloat
    var body: some View {
        Image(uiImage: imageData)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
            .clipped()
    }
}

struct GreyBackgroundImage: View {
    var height: CGFloat = 220
    var body: some View {
        Rectangle()
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .foregroundColor(.lightBrown2)
            .opacity(0.5)
    }
}


struct LargeCheckMark: View {
    var body: some View {
        Image(systemName: ImageName.checkmarkCircle)
            .resizable()
            .font(Font.title.weight(.light))
            .frame(width: 35, height: 35)
            .foregroundColor(.lightBrown)
    }
}

struct CustomAsyncImage: View {
    let urlStr: String
    let width: CGFloat
    let height: CGFloat
    var body: some View {
        AsyncImage(url: URL(string: urlStr)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            Color.gray
        }.frame(width: width, height: height)
            .clipped()
    }
}

struct CustomAsyncCircularImage: View {
    let urlStr: String
    let size: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: urlStr)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            Color.gray
        }.frame(width: size, height: size)
            .cornerRadius(size)
            .clipped()
    }
}

struct VideoThumbnailImage: View {
    let image: String
    let size: CGFloat
    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
            Image(ImageName.playImageThumb)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size/2, height: size/2)
        }
        
    }
}

struct VideoThumbnailImage1: View {
    let image: String
    let size: CGFloat
    var body: some View {
        ZStack {
            CustomAsyncImage(urlStr: image, width: size, height: size)
            Image(ImageName.playImageThumb)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size/2, height: size/2)
        }
        
    }
}
