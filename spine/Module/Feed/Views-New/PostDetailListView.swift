//
//  PostDetailListView.swift
//  spine
//
//  Created by Mac on 18/07/22.
//

import SwiftUI

struct PostDetailListView: View {
    @Environment(\.dismiss) var dismiss
    let postList = [feedItem3, feedItem3]
    @State var comments = [comment3, comment4]
    
    var body: some View {
        VStack(spacing: 0) {
            
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4).padding(.bottom, 10)
            ScrollView {
                
                ForEach(postList) { item in
                    LazyVStack {
                        HStack {
                            ProfileImgWithTitleAndName(imageStr: item.profileImg, title: item.profTitle, subtitle: item.profSubtitle, showBadge: item.isNew)
                            Spacer()
                            Title5(title: item.days, fColor: .gray)
                        }.padding(.horizontal)
                        
                        BannerImageView(image: item.images.first ?? "", heightF: 1.5)
                        ButtonListHView(item: item)
                        Title4(title: "Guided meditation with Laura Melina Seller Lorem ipsum dolor sit amet, consecter adipising elit mode.")
                            .padding(.horizontal, 10)
                        Divider().padding(.horizontal, 20)
                        LazyVStack {
                            ForEach($comments, id: \.self) { $comment in
                                CommentPersonView(comment: comment)
                            }
                        }.padding(.horizontal)
                        Divider().padding(.horizontal, 20)
                    }
                }
                
            }
        }
        
        .navigationBarTitle("TOM RED - POSTS", displayMode: .inline)
        .navigationBarItems(trailing:
                                Button(action: { }, label: {
            Title4(title: "+ Follow", fColor: .lightBrown)
        }).tint(.blue)
        )
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
    }
}

struct PostDetailListView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailListView()
    }
}
