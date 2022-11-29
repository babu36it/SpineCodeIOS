//
//  EventsHomeView.swift
//  spine
//
//  Created by Mac on 11/06/22.
//

import SwiftUI

struct EventsHomeView: View {
    @State var searchText = ""
    @State var showAdd = false
    @State var selectedTab: EventsHomeTab = .none
    @State var sheetType: EventSheetType?
    
    @StateObject var noneTabVM: NoneTabViewModel = .init()
    
    var body: some View {
        NavigationView {
            ZStack {
                
                VStack {
                    HStack(spacing: 0) {
                        
                        SystemButton(image: "plus", font: .title2) {
                            self.showAdd.toggle()
                        }
                        CustomSearchBar(placeHolder: "Search events", searchText: $searchText)
                        CustomButton(image: "FilterBTN") {
                            sheetType = .filter
                        }
                    }.padding(.horizontal)
                    
                    VStack(spacing: 0) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(EventsHomeTab.allTabs(), id: \.self) { tab in
                                    SegmentedButtonDymanic(title: tab.rawValue, selectedTab: $selectedTab) {
                                        selectedTab = tab
                                    }
                                }
                            }
                        }
                        LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)
                    }
                    if selectedTab == .all { //&& filter selected
                        FilterViewForEventList()
                    }
                    
                    switch selectedTab {
                    case .none:
                        NoneTabView(sheetType: $sheetType)
                            .environmentObject(noneTabVM)
                    case .all, .saved, .online, .nearby:
                        EventSubTabView1(sheetType: $sheetType)
                    case .going, .following, .meta, .past:
                        EventSubTabView2(sheetType: $sheetType)
                    }
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    CustomAddItemSheet(dismisser: $showAdd).offset(y: self.showAdd ? 0: UIScreen.main.bounds.height)
                }.background((self.showAdd ? Color.black.opacity(0.3) : Color.clear).onTapGesture {
                    self.showAdd.toggle()
                }).edgesIgnoringSafeArea(.all)
            }.onAppear(perform: {
               selectedTab = .none
            })
            .animation(.default, value: showAdd)
            .navigationBarHidden(true)

            .fullScreenCover(item: $sheetType) { item in
                if item == .filter {
                    EventFilterView()
                } else {
                    NearByMapview()
                }
            }
        }
    }
}

struct EventsHomeView_Previews: PreviewProvider {
    static var previews: some View {
        EventsHomeView()
    }
}

struct SegmentedButtonDymanic: View {
    let title: String
    @Binding var selectedTab: EventsHomeTab
    var onTapped: ()-> Void
    var body: some View {
        HStack {
            VStack(spacing: 5) {
                Button {
                    print("Tapped \(title) Tab")
                    onTapped()
                } label: {
                    Text(title)
                        .font(.Poppins(type: .regular, size: 14))
                        .foregroundColor(selectedTab.rawValue == title ? Color.primary : Color.lightGray2)
                        .padding(.horizontal, 15)
                }
                Rectangle().frame(height: 4.0, alignment: .top)
                    .foregroundColor(K.appColors.appTheme).opacity(selectedTab.rawValue == title ? 1.0 : 0.0)
            }
        }
    }
}

struct NoneTabView: View {
    @Binding var sheetType: EventSheetType?
    @EnvironmentObject var noneTabVM: NoneTabViewModel
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    var body: some View {
        ScrollView {
            if let eventTypes = noneTabVM.eventTypes {
                LazyVStack {
                    ForEach(eventTypes) { eventType in
                        ZStack {
                            if let imagePath = noneTabVM.imageURL(for: eventType.image) {
                                RemoteImage(imageDownloader: DefaultImageDownloader(imagePath: imagePath))
                            }
                        }
                        .frame(width: screenWidth, height: screenWidth/1.5)
                    }
                }
            }
            Divider()
                .padding()
            LargeButton(title: "Map view", width:120, height: 30, bColor: .lightBrown, fSize: 12, fColor: .white) {
                sheetType = .mapView
            }
            .padding(.bottom, 20)
        }
        .onAppear {
            noneTabVM.getEventTypes()
        }
    }
}

struct EventSubTabView1: View {
    @Binding var sheetType: EventSheetType?
    let events = [event1, event2, event3, event4]
    
    
    var body: some View {
        VStack {
            //
            //FilterViewForEventList()
            ScrollView(.vertical, showsIndicators: false, content: {
                EventHomeDateRow()
                ForEach(events, id: \.self) { event in
                    if event.isBanner {
                        EventBannerRow(image: event.bannerImg)
                    } else {
                        NavigationLink(destination: EventsHomeDetailView(event: event, images: [])) {
                            EventHomeRow(event: event)
                        }
                    }
                }
            })
            
            LargeButton(title: "Map view", width:120, height: 30, bColor: .lightBrown, fSize: 12, fColor: .white) {
                sheetType = .mapView
            }.padding(.bottom, 20)
        }
        
    }
}
struct EventSubTabView2: View {
    @Binding var sheetType: EventSheetType?
    let events = [event5, event6, event7]

    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false, content: {
                EventHomeDateRow()
                ForEach(events, id: \.self) { event in
                    NavigationLink(destination: EventsHomeDetailView(event: event, images: [])) {
                        EventHomeRow(event: event)
                    }
                }
            })

            LargeButton(title: "Map view", width:120, height: 30, bColor: .lightBrown, fSize: 12, fColor: .white) {
                sheetType = .mapView
            }.padding(.bottom, 20)
        }

    }
}

struct EventHomeRow: View {
    let event: EventDetail
    //let eventType: EventType
   // var invitation: Invitation = .none
    var body: some View {
        VStack {
            HStack {
                VStack(spacing: 10) {
                    CircularBorderedProfileView(image: "Oval 57", size: 65, borderWidth: 0, showShadow: false)
                    Title4(title: event.hostName)
                }
                VStack(alignment: .leading, spacing: 5) {
                    SubHeader6(title: event.eventType.getTitle().uppercased(), fColor: .lightBrown)
                    VStack(alignment: .leading) {
                        Title4(title: event.title)
                            .multilineTextAlignment(.leading)
                        if event.eventType == .online {
                            Title4(title: event.time)
                        } else {
                            Title4(title: "Madrid, spain", fColor: .lightGray2)
                        }
                    }//.frame(height: 70)
                    Title4(title: event.days)
                        //.padding(.top, 1)
                    if event.invitation != .none {
                        HStack {
                            Image(systemName: event.invitation.imageName().0)
                                .foregroundColor(event.invitation.imageName().1)
                            Title5(title: event.invitation.getTitle(), fColor: .lightBlackText)
                            
                        }.padding(.top, 2)
                    }
                }.padding(.horizontal, 10)
                Spacer()
                VStack(alignment: .trailing, spacing: 50) {
                    HStack {
                        ButtonWithCustomImage(image: "directArrow", size: 18) {
                            print("share tapped")
                        }
                        ButtonWithCustomImage(image: "Bookmark", size: 18) {
                            print("BookMark tapped")
                        }
                    }
                    //Spacer()
                    Header5(title: event.cost)
                }
            }
            Divider()
        }.padding(.horizontal, 20)
        
    }
}

struct EventBannerRow: View {
    let image: String
    var body: some View {
        ZStack {
            BannerImageView(image: image, heightF: 1.7)
            VStack {
                Header3(title: "LOREM IPSUM DOLOR SIT AMET", fColor: .white)
                
                ZStack {
                    Rectangle()
                        .frame(width: 180, height: 30)
                        .foregroundColor(.white).opacity(0.7)
                    Header3(title: "22.-25.8.2022", fColor: .white)
                }
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image(systemName: ImageName.arrowUpRight)
                        .foregroundColor(.white)
                        .padding()
                }
            }
           
        }
        
    }
}

struct EventHomeDateRow: View {

    var body: some View {
        VStack(alignment: .leading) {
            Title3(title: "SAT, 9 MAY 2022")
            Divider()
        }.padding(.horizontal, 20)
            .padding(.top, 10)
    }
}

struct FilterViewForEventList: View {

    var body: some View {
        HStack {
            Header5(title: "London, 8-16 May, 3 categories")
            Button("Edit") {
                
            }.font(.Poppins(type: .regular, size: 14))
            Button {
                
            } label: {
                Image(systemName: ImageName.multiplyCircleFill)
                    .foregroundColor(.lightBrown)
            }
            Spacer()

        }.padding([.horizontal, .top], 20)
    }
}

