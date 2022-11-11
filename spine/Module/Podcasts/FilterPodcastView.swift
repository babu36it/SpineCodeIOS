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
            VStack(alignment: .leading) {
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        Title2(title: "FILTER")
                        Spacer()
                        ButtonWithSystemImage(image: ImageName.multiply, size: 18) {
                            dismiss()
                        }
                    }.padding()
                    LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)
                }
                
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
                    
                }.padding(.horizontal, Kconstant.filterPadding/2)
                
                Spacer()
            }.padding(.vertical, 10)
                .navigationBarHidden(true)
        }
        
        
    }
}

struct FilterPodcastView_Previews: PreviewProvider {
    static var previews: some View {
        FilterPodcastView()
    }
}




