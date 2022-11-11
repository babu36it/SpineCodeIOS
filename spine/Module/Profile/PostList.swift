//
//  PostList.swift
//  spine
//
//  Created by Mac on 29/06/22.
//

import SwiftUI

struct PostList: View {
    let postsSection: [SectionDetail]
    let padding: CGFloat = 5
    
    var body: some View {
        ScrollView {
            if postsSection.count == 0 {
                EmptyItemView(title: "published posts")
            } else {
                VStack(spacing: padding) { //lazyVstack - todo
                    ForEach(postsSection, id: \.self) { postSec in
                        if postSec.title == .video {
                            ThreeItemRow(posts: postSec)
                        } else {
                            if let item = postSec.items.first {
                                OneItemRow(post: item)
                            }
                        }
                    }
                }
            }
        }
    }
}


//struct PostList_Previews: PreviewProvider {
//    static var previews: some View {
//        PostList()
//    }
//}


struct ThreeItemRow: View {
    let posts: SectionDetail
    let imgH: CGFloat = 230
    let padding: CGFloat = 5
    let screenWidth = UIScreen.main.bounds.size.width - 5
    var body: some View {
        HStack(spacing: padding) {
            ZStack(alignment: .topTrailing) {
                if let item = posts.items[0] {
                    ImageWithTxt(item: item, width: screenWidth/2, height: imgH + padding)
                }
            }
            
            
            VStack(spacing: padding) {
                if posts.items.count > 1 {
                    ZStack(alignment: .topTrailing) {
                        if let item = posts.items[1] {
                            ImageWithTxt(item: item, width: screenWidth/2, height: imgH/2)
                        }
                    }
                }
                if posts.items.count > 2 {
                    ZStack(alignment: .topTrailing) {
                        if let item = posts.items[2] {
                            ImageWithTxt(item: item, width: screenWidth/2, height: imgH/2)
                        }
                    }
                }
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct ImageWithTxt: View {
    let item: PostDetail
    let width: CGFloat
    let height: CGFloat
    var body: some View {
        Image(item.img)
            .resizable()
            .frame(width: width, height: height)
//        if item.postType == .photo {
//            Text("1/\(item.imgCount)")
//                .foregroundColor(.white)
//                .padding()
//        } else
        if item.postType == .video {
            Image(systemName: ImageName.playCircle)
                .foregroundColor(.white)
                .padding()
        }
    }
}

struct TwoItemRow: View {
    let imgH: CGFloat = 230
    let padding: CGFloat = 5
    let screenWidth = UIScreen.main.bounds.size.width
    var body: some View {
        HStack(spacing: padding) {
            Image(ImageName.podcastDetailBanner)
                .resizable()
                .frame(width: screenWidth/2, height: imgH/2)
            Image(ImageName.podcastDetailBanner)
                .resizable()
                .frame(width: screenWidth/2, height: imgH/2)
        }
    }
}

struct OneItemRow: View {
    let post: PostDetail
    let imgH: CGFloat = 230
    let padding: CGFloat = 5
    let screenWidth = UIScreen.main.bounds.size.width
    var body: some View {
        ZStack {
            Image("grayBackground")
                .resizable()
                .frame(width: screenWidth, height: imgH + padding)
            Title3(title: post.txt, fColor: .white)
        }
    }
}
