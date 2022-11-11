//
//  StoryListView.swift
//  spine
//
//  Created by Mac on 15/07/22.
//

import SwiftUI

struct StoryListView: View {
    let stories = [story1, story2, story3, story4, story5, story6, story7, story8]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            Title4(title: "Discover moments of People’s lifes and get inspired by them.", fColor: .gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40).padding(.top, 10)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
                ForEach(stories, id: \.self) { item in
                    StoryCell(storyDetail: item)
                }
            }
        }
        .navigationBarTitle("STORIES", displayMode: .inline)
        .navigationBarItems(trailing: CustomButton(image: "ic_search") {
        })
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
    }
}

struct StoryListView_Previews: PreviewProvider {
    static var previews: some View {
        StoryListView()
    }
}
