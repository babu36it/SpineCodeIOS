//
//  FeedFollowingTabView.swift
//  spine
//
//  Created by Mac on 12/07/22.
//

import SwiftUI

struct FeedFollowingTabView: View {
    let stories = [story1, story2, story3, story4]
    @State var showDetail = false
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 20) {
                ForEach(stories, id: \.self) { story in
                    NavigationLink(destination: InstaTypeStoryViewer(images: story.storyImages)) {
                        StoryCell(storyDetail: story)
                    }
                }
            }
        }//.padding()
    }
}

struct FeedFollowingTabView_Previews: PreviewProvider {
    static var previews: some View {
        FeedFollowingTabView()
    }
}


struct StoryCell: View {
    let storyDetail: StoryDetail
    var body: some View {
        VStack(spacing: 10) {
            CircularBorderedProfileView(image: storyDetail.image, size: 95, borderWidth: 3, showBadge: true, borderClr: .lightBrown).padding(2)
            VStack(spacing: 10) {
                SubHeader6(title: storyDetail.title)
                Title4(title: storyDetail.subTitle)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
            }.foregroundColor(.primary)
            
        }.frame(width: 100)
    }
}

