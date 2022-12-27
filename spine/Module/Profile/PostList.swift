//
//  PostList.swift
//  spine
//
//  Created by Mac on 29/06/22.
//

import SwiftUI

struct PostList: View {
    @EnvironmentObject var postsListVM: PostListViewModel
    
    let postsSection: [SectionDetail]
    let padding: CGFloat = 5
    
    var body: some View {
        ScrollView {
            if let posts = postsListVM.posts, !posts.isEmpty {
                LazyVStack(spacing: padding) { //lazyVstack - todo
                    ForEach(posts, id: \.id) { post in
                        PostItemRow(postItem: post)
                    }
                    if !posts.isEmpty, postsListVM.shouldFetchNextBatch {
                        progress
                            .onAppear {
                                fetchData()
                            }
                    }
                }
            } else {
                EmptyItemView(title: "published posts")
            }
        }
        .onAppear {
            fetchData()
        }
    }
    
    private var progress: some View {
        ProgressView()
    }
    
    private func fetchData() {
        if let userId: String = AppUtility.shared.userInfo?.data?.usersId {
            postsListVM.getPosts(forUser: userId)
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

struct PostItemRow: View {
    let postItem: PostItem
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.lightBrown
            Title3(title: postItem.title ?? "Empty Post!", fColor: .white)
                .padding()
        }
    }
}
