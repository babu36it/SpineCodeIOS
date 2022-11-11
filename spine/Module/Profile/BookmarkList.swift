//
//  BookmarkList.swift
//  spine
//
//  Created by Mac on 30/06/22.
//

import SwiftUI

struct BookmarkList: View {
    let events: [EventDetail]
    
    var body: some View {
        ScrollView {
            if events.isEmpty {
                EmptyItemView(title: "saved posts")
            } else {
                LazyVStack(spacing: 20) { //todo lazy vstack
                    HStack(spacing: 20) {
                        CollectionView(title: "ALL POSTS")
                        CollectionView(title: "EVENTS")
                    }
                    HStack(spacing: 20) {
                        CollectionView(title: "STORIES")
                        CollectionView(title: "PODCASTS")
                    }
                    HStack(spacing: 20) {
                        CollectionView(title: "IMAGES")
                        CollectionView(title: "VIDEOS")
                    }
                    HStack(spacing: 20) {
                        CollectionView(title: "QUESTIONS")
                        CollectionView(title: "SPINE IMPULSES")
                    }
                }.padding()
            }
        }
    }
}

struct BookmarkList_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkList(events: [])
    }
}



struct CollectionView: View {
    let title: String
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: 2) {
                CollectionCell()
                CollectionCell()
            }
            HStack(spacing: 2) {
                CollectionCell()
                CollectionCell()
            }
            Title4(title: title)
                .padding(.vertical, 5)
        }
    }
}


struct CollectionCell: View {
    //let size: CGFloat = 75
    let size: CGFloat = (UIScreen.main.bounds.width - 70) / 4 //70 = 20+20+20+10
    var body: some View {
        Image("thumbnail1")
            .resizable()
            //.scaledToFill()
            .frame(width: size, height: size)
    }
}
