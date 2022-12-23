//
//  FilterPodcastView.swift
//  spine
//
//  Created by Mac on 22/05/22.
//

import SwiftUI

struct FilterPodcastView: View {
    @Environment(\.dismiss) var dismiss
    let screenWidth = UIScreen.main.bounds.size.width
    @State var showPopOver = false
    @State var languages: [String] = []
    @State var categories: [String] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                GradientDivider()
                VStack(alignment: .leading, spacing: 40) {
                    Title2(title: "What can we help you find?")
                        .padding(.top)
                    
                    VStack(alignment: .leading) {
                        Title4(title: "Language")
                        NavigationLink(destination: MultipleSelectionList(type: .language, selections: $languages)) {
                            CustomSearchBar1(items: $languages.count)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Title4(title: "Category")
                        NavigationLink(destination: MultipleSelectionList(type: .category, selections: $categories)) {
                            CustomSearchBar1(items: $categories.count)
                        }
                    }
                    
                    LargeButton(title: "FIND PODCASTS", width: screenWidth - Kconstant.filterPadding, height: 40, bColor: Color.lightBrown, fSize: 15, fColor: .white) {
                        dismiss()
                    }
                    Spacer()
                    
                }.padding(.horizontal, Kconstant.filterPadding/2)
            }
            .navigationTitle("FILTER")
            .navigationBarTitleDisplayMode(.inline)
            .modifier(ToolBarButton(action: {
                dismiss()
            }))
        }
    }
}

struct FilterPodcastView_Previews: PreviewProvider {
    static var previews: some View {
        FilterPodcastView()
    }
}




