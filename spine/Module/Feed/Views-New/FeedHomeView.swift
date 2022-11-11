//
//  FeedHomeView.swift
//  spine
//
//  Created by Mac on 11/07/22.
//

import SwiftUI

enum FeedHomeTabs: String {
    case discover = "DISCOVER"
    case following = "FOLLOWING"
}



struct FeedHomeView: View {
    @State var categoryList: [FeedItemDetail] = feedList
    @State var searchText = ""
    @State var showAdd = false
    @State var selectedTab: FeedHomeTabs = .discover
    @State var showSearch = false
    
    var body: some View {
        NavigationView {
        ZStack {
            VStack {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        SystemButton(image: ImageName.plus, font: .title2) {
                            self.showAdd.toggle()
                        }
                        Spacer()
                        HStack {
                            SegmentedButtonFeeds(title: FeedHomeTabs.discover.rawValue, selectedTab: $selectedTab) {
                                selectedTab = .discover
                                
                            }
                            
                            SegmentedButtonFeeds(title: FeedHomeTabs.following.rawValue, selectedTab: $selectedTab) {
                                selectedTab = .following
                            }
                        }
                        Spacer()
//                        CustomButton(image: "ic_search") {
//                            print("Filter tapped")
//                            showSearch = true
//                        }
                        SystemButton(image: ImageName.magnifyingglass, font: .title2) {
                            showSearch = true
                        }
                        
                    }.padding(.horizontal)
                    LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)
                }
                
                if selectedTab == .discover {
                    ScrollView {
                        VStack {
                            FeedHeaderView().padding(.top, 10)
                            Divider().padding(.horizontal)
                        }
                        LazyVStack {
                            ForEach(self.categoryList) { item in
                                VStack {
                                    HomeFeedCell(item:item)
                                    Divider().padding(.horizontal)
                                }
                            }
                        }.padding(.top)
                    }
                } else {
                    ScrollView {
                        VStack {
                            Title3(title: "STORIES")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            FeedFollowingTabView()
                            Divider()//.padding(.horizontal)
                        }.padding()
                        LazyVStack {
                            ForEach(self.categoryList) { item in
                                VStack {
                                    HomeFeedCell(item:item)
                                    Divider().padding(.horizontal)
                                }
                            }
                        }.padding(.top)
                    }
                }
            }
            
            VStack {
                Spacer()
                CustomAddItemSheet().offset(y: self.showAdd ? 0: UIScreen.main.bounds.height)
            }.background((self.showAdd ? Color.black.opacity(0.3) : Color.clear).onTapGesture {
                self.showAdd.toggle()
            }).edgesIgnoringSafeArea(.all)
            
        }//zstack
        .animation(.default, value: showAdd)
        .navigationBarHidden(true)
            
        .fullScreenCover(isPresented: $showSearch) {
            FeedSearchVC()
        }
    }//nav
    }
}

struct FeedHomeView_Previews: PreviewProvider {
    static var previews: some View {
        FeedHomeView()
    }
}

struct SegmentedButtonFeeds: View {
    let title: String
    @Binding var selectedTab: FeedHomeTabs
    var onTapped: ()-> Void
    var body: some View {
        HStack {
            VStack(spacing: 5) {
                Button {
                    print("Tapped \(title) Tab")
                    onTapped()
                } label: {
                    Title4(title: title)
                        .padding(.top, 20)
                }
                Rectangle().frame(height: 4.0, alignment: .top)
                    .foregroundColor(K.appColors.appTheme).opacity(selectedTab.rawValue == title ? 1.0 : 0.0)
            }
            .frame(width:120)
        }
    }
}

struct ProfileImgWithTitleAndName: View {
    let imageStr: String
    var title: String = "Promoted by"
    var subtitle: String = "Oliver Reese"
    var showBadge = false
    var body: some View {
        HStack(spacing: 15) {
            CircularBorderedProfileView(image: imageStr, size: 40, borderWidth: 0, showBadge: showBadge)
            VStack(alignment: .leading) {
                if title != "" {
                    SubHeader5(title: title)
                }
                Title4(title: subtitle)
            }
        }

    }
}
