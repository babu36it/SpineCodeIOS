//
//  FilterPodcastView.swift
//  spine
//
//  Created by Mac on 22/05/22.
//

import SwiftUI

struct FilterPodcastView: View {
    @StateObject var viewModel = FilterPodcastViewModel()
    @Environment(\.dismiss) var dismiss
    let screenWidth = UIScreen.main.bounds.size.width
    @State var showPopOver = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                GradientDivider()
                VStack(alignment: .leading, spacing: 40) {
                    Title2(title: "What can we help you find?")
                        .padding(.top)
                    
                    VStack(alignment: .leading) {
                        Title4(title: "Language")
                        NavigationLink(destination: SingleItemSelectionView(selectedItem: $viewModel.selectedLanguage, itemType: .language, items: viewModel.languages)) {
                            CustomSearchBar2(items: viewModel.selectedLanguage?.name ?? "")
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Title4(title: "Categories")
                        NavigationLink(destination: MultipleSelectionList1(title: "Categories", selections: $viewModel.selectedCategories, listItems: viewModel.categories)) {
                            CustomSearchBar2(items: viewModel.selectedCategories.map {$0.name}.joined(separator: ",") )
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




