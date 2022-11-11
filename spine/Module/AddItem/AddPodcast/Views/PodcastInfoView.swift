//
//  PodcastInfoView.swift
//  spine
//
//  Created by Mac on 31/05/22.
//

import SwiftUI

struct PodcastInfoView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var podcastInfoVM = PodcastInfoViewModel()
    
    var body: some View {
        ScrollView {
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4).padding(.top, 10)
            VStack(spacing: 30) {
                
                HStack(alignment: .top) {
                    Header5(title: "Podcast image")
                        .padding(.top, 10)
                    Spacer()
                    CustomAsyncImage(urlStr: podcastInfoVM.rssData?.feed.image ?? "", width: 120, height: 120)
                }
                
                VStack(alignment: .leading) {
                    Header5(title: "Podcast title")
                    CustomTextView(text: podcastInfoVM.rssData?.feed.title ?? "No Title")
                }
                
                VStack(alignment: .leading) {
                    Header5(title: "About the podcast")
                    ScrollableLabel(text: podcastInfoVM.rssData?.feed.description ?? "No Description")
                }
                
                VStack(alignment: .leading) {
                    Header5(title: "Primary language spoken in your the podcast")
                    NavigationLink(destination: SingleItemSelectionView(selectedItem: $podcastInfoVM.selectedLanguage, itemType: .language, items: podcastInfoVM.languages)) {
                        CustomNavigationView1(selectedItem: $podcastInfoVM.selectedLanguage, placeholder: C.PlaceHolder.language)
                    }
                }
                
                VStack(alignment: .leading) {
                    Header5(title: "Podcast category")
                    NavigationLink(destination: SingleItemSelectionView(selectedItem: $podcastInfoVM.selectedCategory, itemType: .category, items: podcastInfoVM.categories)) {
                        CustomNavigationView1(selectedItem: $podcastInfoVM.selectedCategory, placeholder: C.PlaceHolder.category)
                    }
                }
                
                
                if let selectdcategory = podcastInfoVM.selectedCategory {
                    SubCategoryView(mainCategory: selectdcategory, categories: $podcastInfoVM.subCategories, selectedCategories: $podcastInfoVM.selectedSubCategories, addTapped: { newSubCategory in
                        podcastInfoVM.newSubCategory = newSubCategory
                        podcastInfoVM.addPodcastSubCategory()
                    })
                }
                
                VStack(spacing: 20) {
                    HStack {
                        Header5(title: "Allow comments")
                        Spacer()
                        Toggle("", isOn: $podcastInfoVM.commentsOn)
                            .tint(.lightBrown)
                    }
                    
                    Text("Would you like to promote your post, click here")
                        .font(.Poppins(type: .regular, size: 14))
                        .underline()
                    
                    LargeButton(disable: !podcastInfoVM.isFormValid, title: "REVIEW", width: 120, height: 40, bColor: Color.lightBrown, fSize: 12, fColor: .white) {
                        podcastInfoVM.showReviewScreen = true
                    }
                    
                    NavigationLink("", isActive: $podcastInfoVM.showReviewScreen) {
                        ReviewPodcastView().environmentObject(podcastInfoVM)
                    }
                }
            }.padding(20)
            Spacer()
        }.modifier(LoadingView(isLoading: $podcastInfoVM.showLoader))
        .navigationBarTitle(Text("PODCAST INFO"), displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
        .navigationBarItems(trailing: LargeButton(disable: !podcastInfoVM.isFormValid, title: "REVIEW", width: 60, height: 22, bColor: Color.lightBrown, fSize: 12, fColor: .white) {
            podcastInfoVM.showReviewScreen = true
        }//.opacity(0.3).disabled(true)
        )
        
    }
}

// TODO :- change this CustomNavigationView1
struct CustomNavigationView: View {
    @Binding var selectedItem: String
    var placeholder: String = ""
    var imageStr: String = ""
    var isEmpty: Bool {
        return selectedItem == "" ? true : false
    }
    
    var body: some View {
        ZStack {
            Text("")
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                //.background(Color.white)
                .background(Color(UIColor.systemBackground))
                .cornerRadius(8)
                .shadow(color: Color.gray.opacity(0.7), radius: 5)
                .foregroundColor(.primary)
            HStack {
                if imageStr != "" {
//                    Image(imageStr)
//                        .resizable()
//                        .renderingMode(.template)
//                        .foregroundColor(.white)
//                        .scaledToFit()
//                        .frame(width: 8, height: 8)
                    Image(imageStr)
                }
                Text(isEmpty ? placeholder : selectedItem)
                    .foregroundColor(isEmpty ? Color(UIColor.placeholderText) : .primary)
                    .font(.Poppins(type: .regular, size: 14))
                    .lineLimit(1)
                Spacer()
                Image(systemName: ImageName.chevronRight)
            }.padding(.horizontal, 10)
                .foregroundColor(.black1)
        }
    }
}

struct CustomNavigationView1: View {
    @Binding var selectedItem: ItemModel?
    var placeholder: String = ""
    var imageStr: String = ""
    
    var body: some View {
        ZStack {
            Text("")
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                //.background(Color.white)
                .background(Color(UIColor.systemBackground))
                .cornerRadius(8)
                .shadow(color: Color.gray.opacity(0.7), radius: 5)
                .foregroundColor(.primary)
            HStack {
                if imageStr != "" {
                    Image(imageStr)
                }
                Text(selectedItem?.name ?? placeholder)
                    .foregroundColor(selectedItem == nil ? Color(UIColor.placeholderText) : .primary)
                    .font(.Poppins(type: .regular, size: 14))
                    .lineLimit(1)
                Spacer()
                Image(systemName: ImageName.chevronRight)
            }.padding(.horizontal, 10)
                .foregroundColor(.black1)
        }
    }
}

struct CustomTextView: View {
    let text: String
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Title4(title: text)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(7)
            .background(colorScheme == .dark ? .black : .lightGray5) //D8D8D8 F4F4F4
    }
}



extension View {
    func border(_ color: Color, width: CGFloat, cornerRadius: CGFloat) -> some View {
        overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(color, lineWidth: width))
    }
}

