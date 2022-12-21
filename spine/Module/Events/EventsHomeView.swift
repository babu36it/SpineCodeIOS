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
    @State var sheetType: EventSheetType?

    @Binding var selectedTab: EventsHomeTabType

    private let eventTypesVM: EventTypesViewModel = .init()
    private let eventsListVM: EventsListViewModel = .init()
    
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
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: 0) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(EventsHomeTabType.allTabs(), id: \.self) { tab in
                                    SegmentedButtonDymanic(title: tab.rawValue, selectedTab: $selectedTab) {
                                        selectedTab = tab
                                    }
                                }
                            }
                        }
                        LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)
                    }
//                    if selectedTab == .all { //&& filter selected
//                        FilterViewForEventList()
//                    }
                    
                    switch selectedTab {
                    case .none:
                        EventTypesTabView(sheetType: $sheetType)
                            .environmentObject(eventTypesVM)
                    default:
                        EventSegmentTabView(sheetType: $sheetType, tabType: selectedTab)
                            .environmentObject(eventsListVM)
                    }
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    CustomAddItemSheet(dismisser: $showAdd).offset(y: self.showAdd ? 0: UIScreen.main.bounds.height)
                }
                .background((self.showAdd ? Color.black.opacity(0.3) : Color.clear).onTapGesture {
                    self.showAdd.toggle()
                })
                .edgesIgnoringSafeArea(.all)
            }.onAppear {
               selectedTab = .none
            }
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
    
    func updateSelectedTab(_ tab: EventsHomeTabType) {
        selectedTab = tab
    }
}

struct EventsHomeView_Previews: PreviewProvider {
    static var previews: some View {
        EventsHomeView(selectedTab: Binding(get: { .none }, set: { _ in }))
    }
}

struct SegmentedButtonDymanic: View {
    let title: String
    @Binding var selectedTab: EventsHomeTabType
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

struct EventTypesTabView: View {
    @Binding var sheetType: EventSheetType?
    @EnvironmentObject var eventTypeTabVM: EventTypesViewModel
    
    @State private var showEventTypes: Bool = false
    @State private var selectedEventType: EventTypeModel?
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    var body: some View {
        ScrollView {
            if let eventTypes = eventTypeTabVM.eventTypes {
                LazyVStack {
                    ForEach(eventTypes) { eventType in
                        ZStack {
                            if let imagePath = eventTypeTabVM.imageURL(for: eventType.image) {
                                RemoteImage(imageDownloader: DefaultImageDownloader(imagePath: imagePath))
                            }
                        }
                        .frame(width: screenWidth, height: screenWidth/1.5)
                        .onTapGesture {
                            selectedEventType = eventType
                            showEventTypes = true
                        }
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
            eventTypeTabVM.getEventTypes()
        }
        
        NavigationLink(isActive: $showEventTypes) {
            if let eventType: EventTypeModel = selectedEventType {
                EventsListView(eventType: eventType)
                    .environmentObject(EventsListViewModel())
            }
        } label: {
            EmptyView()
        }
    }
}

struct EventSegmentTabView: View {
    @EnvironmentObject var eventsListVM: EventsListViewModel

    @Binding var sheetType: EventSheetType?
    let tabType: EventsHomeTabType
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                if let eventRecords = eventsListVM.eventRecords[tabType.requestType], !eventRecords.isEmpty {
                    ForEach(eventRecords, id: \.startDate) { eventRecord in
                        let date: Date = eventRecord.startDate?.toDate(format: "yyyy-MM-dd") ?? Date()
                        if let events: [EventModel] = eventRecord.records, !events.isEmpty {
                            ForEach(events) { event in
                                let eventDetail: EventDetailViewModel = .init(event: event, eventImagePath: eventsListVM.eventImagePath(forRequestType: tabType.requestType), userImagePath: eventsListVM.userImagePath(forRequestType: tabType.requestType))
                                NavigationLink(destination: EventDetailView(eventDetails: eventDetail)) {
                                    EventListItem(tabType: tabType)
                                        .environmentObject(event)
                                }
                                EventHomeDateRow(date: date)
                            }
                        }
                    }
                } else if let message = eventsListVM.message(forRequestType: tabType.requestType) {
                    Text(message)
                        .padding(.top, 100)
                }
            }
            .onAppear {
                eventsListVM.getEvents(forType: tabType.requestType)
            }
            .onChange(of: tabType, perform: { newTab in
                eventsListVM.getEvents(forType: newTab.requestType)
            })

            LargeButton(title: "Map view", width:120, height: 30, bColor: .lightBrown, fSize: 12, fColor: .white) {
                sheetType = .mapView
            }
            .padding(.bottom, 20)
        }
    }
}

struct EventSubTabView2: View {
    @Binding var sheetType: EventSheetType?
    let events = [event5, event6, event7]

    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false, content: {
                EventHomeDateRow(date: Date())
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
    let date: Date
    
    var body: some View {
        VStack(alignment: .leading) {
            Title3(title: date.toString("EEE, d MMM yyyy"))
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

struct EventsListView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var eventsListVM: EventsListViewModel
    
    let eventType: EventTypeModel
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false, content: {
                if let eventRecords = eventsListVM.eventRecords[EventsHomeTabType.all.requestType], !eventRecords.isEmpty {
                    ForEach(eventRecords, id: \.startDate) { eventRecord in
                        let date: Date = eventRecord.startDate?.toDate(format: "yyyy-MM-dd") ?? Date()
                        EventHomeDateRow(date: date)
                        if let events: [EventModel] = eventRecord.records, !events.isEmpty {
                            ForEach(events) { event in
                                let eventDetail: EventDetailViewModel = .init(event: event, eventImagePath: eventsListVM.eventImagePath(forRequestType: EventsHomeTabType.none.requestType), userImagePath: eventsListVM.userImagePath(forRequestType: EventsHomeTabType.none.requestType))
                                NavigationLink(destination: EventDetailView(eventDetails: eventDetail)) {
                                    EventListItem(tabType: EventsHomeTabType.none)
                                        .environmentObject(event)
                                }
                            }
                        }
                    }
                } else if let message = eventsListVM.message(forRequestType: EventsHomeTabType.all.requestType) {
                    Text(message)
                        .padding(.top, 100)
                }
            })
        }
        .onAppear {
            eventsListVM.getEvents(forType: .all, eventTypeId: eventType.id)
        }
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
        .navigationBarTitle(Text(eventType.name.uppercased()), displayMode: .inline)
    }
}

struct EventListItem: View {
    @EnvironmentObject var eventsListVM: EventsListViewModel
    @EnvironmentObject var event: EventModel
    
    @State private var eventCost: String = ""

    let tabType: EventsHomeTabType

    var body: some View {
        VStack {
            HStack {
                VStack(spacing: 10) {
                    if let userImage = event.hostedProfilePic, let imagePath: String = eventsListVM.imagePath(forUserImage: userImage, onRequestType: tabType.requestType) {
                        RemoteImage(imageDownloader: DefaultImageDownloader(imagePath: imagePath))
                            .circularClip(radius: 65)
                    } else {
                        CircularBorderedProfileView(image: "Oval 57", size: 65, borderWidth: 0, showShadow: false)
                    }
                    Title4(title: event.userName)
                }
                VStack(alignment: .leading, spacing: 5) {
                    SubHeader6(title: event.typeName.uppercased(), fColor: .lightBrown)
                    
                    VStack(alignment: .leading) {
                        Title4(title: event.title)
                            .multilineTextAlignment(.leading)
                        if event.typeName.contains("Online Events"), let startTimeStr: String = event.startTime?.toString("HH:mm") {
                            Title4(title: startTimeStr)
                        } else {
                            Title4(title: event.location, fColor: .lightGray2)
                        }
                    }
                    
                    Title4(title: event.eventDays)

//                    if event.status != .none {
//                        HStack {
//                            Image(systemName: event.invitation.imageName().0)
//                                .foregroundColor(event.invitation.imageName().1)
//                            Title5(title: event.invitation.getTitle(), fColor: .lightBlackText)
//
//                        }.padding(.top, 2)
//                    }
                }
                .padding(.horizontal, 10)
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

                    Header5(title: eventCost)
                }
            }
            Divider()
        }
        .padding(.horizontal, 20)
        .onAppear {
            event.cost { costStr in
                eventCost = costStr
            }
        }
    }
}
