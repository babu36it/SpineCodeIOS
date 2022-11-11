//
//  PodcastHomeView.swift
//  spine
//
//  Created by Mac on 19/05/22.
//

import SwiftUI

enum PodcastHomeTabs: String {
    case episodes = "EPISODES"
    case podcasts = "PODCASTS"
}

struct PodcastHomeView: View {
    @State var searchText = ""
    @State var selectedTab: PodcastHomeTabs = .episodes
    @State var showFilter = false
    @State var showAdd = false
    
    
    var body: some View {
         NavigationView {
            ZStack {
                VStack {
                    HStack(spacing: 0) {
                        SystemButton(image: "plus", font: .title2) {
                            self.showAdd.toggle()
                        }
                        CustomSearchBar(placeHolder: "Search podcasts", searchText: $searchText)
                        CustomButton(image: "FilterBTN") {
                            print("Filter tapped")
                            showFilter = true
                        }
                    }.padding(.horizontal)
                    
                    VStack(spacing: 0) {
                        HStack {
                            SegmentedButton(title: PodcastHomeTabs.episodes.rawValue, selectedTab: $selectedTab) {
                                selectedTab = .episodes
                            }
                            
                            SegmentedButton(title: PodcastHomeTabs.podcasts.rawValue, selectedTab: $selectedTab) {
                                selectedTab = .podcasts
                            }
                        }
                        LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)
                    }.padding(.top, -20)
                    
                    if selectedTab == .episodes {
                        PodcastHomeViewTab1()
                    } else {
                        PodcastHomeViewTab2()
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
        
            .fullScreenCover(isPresented: $showFilter) {
                FilterPodcastView()
            }
            
        } //nav
    }
}

struct PodcastHomeView_Previews: PreviewProvider {
    static var previews: some View {
        PodcastHomeView()
    }
}


struct PodcastHomeViewTab1: View {
    var body: some View {
        List {
               Divider().padding(.leading, 10)
                .listRowSeparator(.hidden)

                ForEach((1...4), id: \.self) { item in
                    VStack {
                        if item == 2 {
                            BannerImageView(image: "ic_launch").padding(.top, -10)
                        } else {
                                ZStack {
                                    PodcastHomeListVideoRow()//.padding(.vertical, 5)
                                    NavigationLink(destination: PodcastDetailView()) {
                                        EmptyView()
                                    }.buttonStyle(PlainButtonStyle())
                                    .opacity(0.0)
                                }
                            Divider().padding(.leading, 10)
                        }

                    }.listRowSeparator(.hidden)
                }
        }.edgesIgnoringSafeArea(.all)
        .padding(.leading, -20)
        .listStyle(.plain)
    }
}

struct PodcastHomeViewTab2: View {
    var body: some View {
        List {
               Divider().padding(.leading, 10)
                .listRowSeparator(.hidden)

                ForEach((1...3), id: \.self) { item in
                    VStack {
                        if item == 3 {
                            BannerImageView(image: "ic_launch").padding(.top, -10)
                        } else {
                                ZStack {
                                    PodcastHomeListVideoRow()//.padding(.vertical, 5)
                                    NavigationLink(destination: PodcastDetailView()) {
                                        EmptyView()
                                    }.buttonStyle(PlainButtonStyle())
                                    .opacity(0.0)
                                }
                            Divider().padding(.leading, 10)
                        }

                    }.listRowSeparator(.hidden)
                }
        }.edgesIgnoringSafeArea(.all)
        .padding(.leading, -20)
        .listStyle(.plain)
    }
}

struct PodcastHomeListVideoRow: View {
    var body: some View {
        HStack(alignment: .center) {
            VideoThumbnailImage(image: "thumbnail1", size: 80)
            
            VStack(alignment: .leading, spacing: 5) {
                
                HStack {
                    ButtonWithSystemImage(image: ImageName.mic, size: 8) {
                        print("mic tapped")
                    }.foregroundColor(.primary).offset(y: -3)
                        
                    Text("En  |")
                        .modifier(SubTitleModifier())
                    
                    ButtonWithCustomImage(image: "CircleClock", size: 15) {
                        print("mic tapped")
                    }.foregroundColor(.primary).offset(y: -3)
                    
                    Text("1h 17min")
                        .modifier(SubTitleModifier())
                }
               
                Header5(title: "Universal law From Friend of Indins ameri", lineLimit: 2)
                    
                HStack(spacing: 10) {
                    ButtonWithSystemImage(image: "play.fill", size: 8, fColor: K.appColors.lightGray) {
                        print("Play tapped")
                    }
                    Text("45").modifier(SubTitleModifier())
                    ButtonWithSystemImage(image: ImageName.heartFill, size: 12, fColor: K.appColors.lightGray) {
                        print("Heart tapped")
                    }
                }//.foregroundColor(K.appColors.lightGray)
                
            }.padding(.leading, 10)
            Spacer()
            
            VStack(alignment: .trailing) {
                HStack {
                    ButtonWithCustomImage(image: "directArrow", size: 18) {
                        print("share tapped")
                    }
                    ButtonWithCustomImage(image: ImageName.ic_bookmark, size: 18) {
                        print("BookMark tapped")
                    }
                }//.padding(.top, 10)
                Spacer()
                HStack {
                    Title5(title: "Tom", fColor: K.appColors.lightGray)
                    Image("Oval 57")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30, height: 30)
                        .cornerRadius(30)
                }
            }
            
        }.padding(.leading, 10)
            .padding(.vertical, 5)
    }
}

struct SegmentedButton: View {
    let title: String
    @Binding var selectedTab: PodcastHomeTabs
    var onTapped: ()-> Void
    var body: some View {
        HStack {
            VStack(spacing: 5) {
                Button {
                    print("Tapped \(title) Tab")
                    onTapped()
                } label: {
                    Title4(title: title, fColor: .primary)
                        .padding(.top, 20)
                }
                Rectangle().frame(height: 4.0, alignment: .top)
                    .foregroundColor(K.appColors.appTheme).opacity(selectedTab.rawValue == title ? 1.0 : 0.0)
            }
            .frame(width:120)
        }
    }
}

