//
//  EventDetailsView.swift
//  spine
//
//  Created by Mac on 12/06/22.
//

import SwiftUI

struct EventDetailsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var addEventVM: AddEventViewModel
    @EnvironmentObject var eventModel: EventModel

    let eventType: EventTypeModel

    @State private var startDate: Date = Date()
    @State private var startTime: Date = Date()
    @State private var endDate: Date = Date()
    @State private var endTime: Date = Date().addingTimeInterval(3600)
    @State private var acceptParticipants = false
    @State private var allowComments = false
    @State private var isPaid = false
    @State private var showPreview = false

//    @State var eventTitle: String = ""
//    @State var selectedTimeZone = ""
//    @State var selectedLocation = ""
//    @State var eventWebsiteLink: String = ""
//    @State var onlineEventLink: String = ""
//    @State var aboutText: String = ""
//    @State var bookEventLink: String = ""
//    @State var selectedCurrency: String = ""
//    @State var amount: String = "0"
//    @State var attendees: String = ""
//    @State var selectedLanguage = ""
//    @State var selectedCategory = ""
    @State private var categories = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6","Item 7"]
    @State private var selectedCategories: [String] = []
    @State private var images = [UIImage]()
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 0) {
                LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4).padding(.top, 10)
                AddImageView(images: $images)
            }
            
            VStack(spacing: 30) {
                VStack(alignment: .leading) {
                    EventDetailTitle(text: "Event Title*")
                    CustomTextFieldWithCount(searchText: $eventModel.title, placeholder: "Enter title", count: 40)
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        EventDetailTitle(text: "Start*")
                        let dateBinding: Binding<Date> = .init {
                            startDate
                        } set: { newValue in
                            startDate = newValue
                            eventModel.startDate = startDate.toString("yyyy-MM-dd")
                        }
                        DateSelectionView(type: .date, selectedDate: dateBinding, size: 15).padding(.vertical,2)
                        
                        let timeBinding: Binding<Date> = .init {
                            startTime
                        } set: { newValue in
                            startTime = newValue
                            eventModel.startTime = startTime.toString("HH:mm")
                        }
                        DateSelectionView(type: .time, selectedDate: timeBinding, size: 15).padding(.vertical,2)
                    }.frame(width: 160)
                    Spacer()
                    VStack(alignment: .leading) {
                        EventDetailTitle(text: "End*")
                        let dateBinding: Binding<Date> = .init {
                            endDate
                        } set: { newValue in
                            endDate = newValue
                            eventModel.startDate = endDate.toString("yyyy-MM-dd")
                        }
                        DateSelectionView(type: .date, selectedDate: dateBinding, size: 15).padding(.vertical,2)

                        let timeBinding: Binding<Date> = .init {
                            endTime
                        } set: { newValue in
                            endTime = newValue
                            eventModel.endTime = endTime.toString("HH:mm")
                        }
                        DateSelectionView(type: .time, selectedDate: timeBinding, size: 15).padding(.vertical,2)
                    }.frame(width: 160)
                    
                }
                
                VStack(alignment: .leading) {
                    EventDetailTitle(text: "Timezone*")
                    NavigationLink(destination: ItemSelectionView(selectedItem: $eventModel.timezone, itemType: .timezone)) {
                        CustomNavigationView(selectedItem: $eventModel.timezone, placeholder: C.PlaceHolder.timeZone)
                    }
                }
                
                if eventType.name == "Local Events" {
                    VStack(alignment: .leading) {
                        EventDetailTitle(text: "Location*")
                        NavigationLink(destination: ItemSelectionView(selectedItem: $eventModel.location, itemType: .location)) {
                            CustomNavigationView(selectedItem: $eventModel.location, placeholder: C.PlaceHolder.address)
                        }
                    }
                } else {
                    VStack(alignment: .leading) {
                        EventDetailTitle(text: "Add link to join \(eventType.name)")
                        CustomTextFieldDynamic(searchText: $eventModel.joinEventLink, placeHolder: "e.g. http://zoom...")
                    }
                }
                
                
                VStack(alignment: .leading) {
                    EventDetailTitle(text: "Add link to event website")
                    CustomTextFieldDynamic(searchText: $eventModel.linkOfEvent, placeHolder: "e.g. http://facebook...")
                }
                
                VStack(alignment: .leading) {
                    EventDetailTitle(text: "About the event*")
                    NavigationLink(destination: AboutEventView(aboutTxt: $eventModel.eventDescription)) {
                        CustomNavigationView(selectedItem: $eventModel.eventDescription, placeholder: "Enter description")
                    }
                }
                
                HStack {
                    EventDetailTitle2(text: "Paid event*")
                    Toggle("", isOn: $isPaid)
                        .tint(Color.lightBrown)
                }
                
                if isPaid {
                    VStack(spacing: 30) {
                        
                        HStack {
                            EventDetailTitle(text: "Fee*")
                            Spacer()
                            CustomTextFieldDynamic(searchText: $eventModel.fee, placeHolder: "")
                                .frame(width: 80)
                            NavigationLink(destination: ItemSelectionView(selectedItem: $eventModel.feeCurrency, itemType: .currency)) {
                                CustomNavigationView(selectedItem: $eventModel.feeCurrency, placeholder: C.PlaceHolder.currency)
                                    .frame(width: 120)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            EventDetailTitle(text: "Where to book the event")
                            CustomTextFieldDynamic(searchText: $eventModel.bookingURL, placeHolder: "e.g. http://www...")
                        }
                    }
                }
                
                VStack(spacing: 30)  {
                    VStack(alignment: .leading) {
                        EventDetailTitle(text: "Max. number of attendees")
                        CustomTextFieldDynamic(searchText: $eventModel.maxAttendees, placeHolder: "Add")
                    }
                    
                    VStack(alignment: .leading) {
                        EventDetailTitle(text: "Language the event is hosted in*")
                        NavigationLink(destination: ItemSelectionView(selectedItem: $eventModel.language, itemType: .language)) {
                            CustomNavigationView(selectedItem: $eventModel.language, placeholder: "Select")
                        }
                    }
                    
                    if eventType.name != "Local Events" {
                        HStack {
                            VStack(alignment: .leading) {
                                EventDetailTitle2(text: "Want to accept participants?*")
                                EventDetailDesc(text: "(Your event link will then only be shared with\n people you accepted)")
                            }.frame(width: 250)
                                .offset(x: -6)
                            Spacer()
                            
                            let participantsBinding: Binding<Bool> = .init {
                                acceptParticipants
                            } set: { newValue in
                                acceptParticipants = newValue
                                eventModel.acceptParticipants = acceptParticipants ? "1" : "0"
                            }
                            Toggle("", isOn: participantsBinding)
                                .tint(Color.lightBrown)
                        }
                    }
                    
                    HStack {
                        EventDetailTitle2(text: "Allow comments*")
                        
                        let allowCommentsBinding: Binding<Bool> = .init {
                            allowComments
                        } set: { newValue in
                            allowComments = newValue
                            eventModel.allowComments = allowComments ? "1" : "0"
                        }
                        Toggle("", isOn: allowCommentsBinding)
                            .tint(Color.lightBrown)
                    }
                    
                    VStack(alignment: .leading) {
                        EventDetailTitle(text: "Event category*")
                        NavigationLink(destination: ItemSelectionView(selectedItem: $eventModel.eventCategories, itemType: .category)) {
                            CustomNavigationView(selectedItem: $eventModel.eventCategories, placeholder: "Select")
                        }
                    }
                    
                    if eventModel.eventCategories != "" {
//                        SubCategoryView(mainCategory: $eventModel.eventCategories, categories: $categories, selectedCategories: $selectedCategories, addTapped: { newCategory in
//
//                        })
                    }
                    
                    VStack(spacing: 10) {
                        LargeButton(title: "PREVIEW", width: UIScreen.main.bounds.width - 40, height: 40, bColor: Color.lightBrown, fSize: 15, fColor: .white) {
                            showPreview = true
                        }
                        
                        HStack {
                            Button("Delete") {
                                
                            }.font(.Poppins(type: .regular, size: 14))
                                .foregroundColor(Color.lightBrown)
                                .padding(.leading, 10)
                            Spacer()
                        }
                    }
                }
            }.padding(20)
            Spacer()
        }
        .onAppear(perform: {
            startDate = eventModel.startDate.toDate(format: "yyyy-MM-dd") ?? Date()
            startTime = eventModel.startTime.toDate(format: "HH:mm") ?? Date()
            endDate = eventModel.endDate.toDate(format: "yyyy-MM-dd") ?? Date()
            endTime = eventModel.endTime.toDate(format: "HH:mm") ?? Date()
            
            isPaid = (Int(eventModel.fee) ?? 0) > 0
            acceptParticipants = eventModel.acceptParticipants.toBool() ?? false
            allowComments = eventModel.allowComments.toBool() ?? false
        })
        .fullScreenCover(isPresented: $showPreview, content: {
            EventDetailPreviewView(eventType: eventType, images: images)
                .environmentObject(addEventVM)
                .environmentObject(eventModel)
        })
        
        .navigationBarTitle(Text(eventType.name.capitalized), displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
    }
}

struct AddImageView: View {
    @Binding  var images: [UIImage]
    @State private var showAction = false
    let screenWidth = UIScreen.main.bounds.size.width
    let imageH: CGFloat = 220
    @State var selectedMode: MediaMode?
    
    
    var body: some View {
        ZStack {
            if images.isEmpty {
                GreyBackgroundImage()
            } else {
                HorizontalImageScroller(images: images)

//   HorizontalImageScroller1(images: images)
//                ScrollView(.horizontal, showsIndicators: false) {
//                    LazyHGrid(rows: [GridItem(.fixed(screenWidth))]) {
//                        ForEach(images, id: \.self) { image in
//                            Image(uiImage: image)
//                                .resizable()
//                                //.aspectRatio(contentMode: .fill)
//                                .frame(width: screenWidth, height: imageH)
//                                .edgesIgnoringSafeArea(.all)
//                        }
//                    }
//                }.frame( height: 220)
            }
            
            Button {
                showAction = true
            } label: {
                VStack(spacing: 10) {
                    Image(systemName: ImageName.cameraFill)
                    Title4(title: "Add photo(s)", fColor: .lightBrown)
                }
            }
        }.offset(y: -1)
            .sheet(item: $selectedMode) { mode in
                switch mode {
                case .camera:
                    ImagePicker(sourceType: .camera, selectedImages: self.$images)
                case .gallary:
                    ImagePicker(sourceType: .photoLibrary, selectedImages: self.$images)
                }
            }
            .actionSheet(isPresented: $showAction) { () -> ActionSheet in
                ActionSheet(title: Text("Choose mode"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                    selectedMode = .camera
                }), ActionSheet.Button.default(Text("Photo Library"), action: {
                    selectedMode = .gallary
                }), ActionSheet.Button.cancel()])
            }
    }
}


struct EventDetailTitle: View {
    let text: String
    var body: some View {
        Header5(title: text)
    }
}

struct EventDetailTitle2: View {
    let text: String
    var body: some View {
        Header4(title: text)
    }
}

struct EventDetailDesc: View {
    let text: String 
    var body: some View {
        Title5(title: text)
    }
}
