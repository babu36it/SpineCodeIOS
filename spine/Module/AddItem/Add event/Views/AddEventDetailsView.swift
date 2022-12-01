//
//  AddEventDetailsView.swift
//  spine
//
//  Created by Mac on 12/06/22.
//

import SwiftUI

struct AddEventDetailsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var addEventVM: AddEventViewModel
    @EnvironmentObject var eventModel: EventModel

    let eventType: EventTypeModel
    var dismissWithEventID: ((String?) -> Void)?

    @State private var startDate: Date = Date()
    @State private var startTime: Date = Date()
    @State private var endDate: Date = Date()
    @State private var endTime: Date = Date().addingTimeInterval(3600)
    @State private var acceptParticipants = false
    @State private var allowComments = false
    @State private var isPaid = false
    @State private var showPreview = false

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
                            eventModel.startDate = startDate
                        }
                        DateSelectionView(type: .date, selectedDate: dateBinding, size: 15).padding(.vertical,2)
                        
                        let timeBinding: Binding<Date> = .init {
                            startTime
                        } set: { newValue in
                            startTime = newValue
                            eventModel.startTime = startTime
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
                            eventModel.endDate = endDate
                        }
                        DateSelectionView(type: .date, selectedDate: dateBinding, size: 15).padding(.vertical,2)

                        let timeBinding: Binding<Date> = .init {
                            endTime
                        } set: { newValue in
                            endTime = newValue
                            eventModel.endTime = endTime
                        }
                        DateSelectionView(type: .time, selectedDate: timeBinding, size: 15).padding(.vertical,2)
                    }.frame(width: 160)
                    
                }
                
                VStack(alignment: .leading) {
                    EventDetailTitle(text: "Timezone*")
                    NavigationLink(destination: SelectionListView(listViewModel: timzonesListModel)) {
                        CustomNavigationView(selectedItem: $addEventVM.timezone, placeholder: C.PlaceHolder.timeZone)
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
                            NavigationLink(destination: SelectionListView(listViewModel: currenciesListModel)) {
                                CustomNavigationView(selectedItem: $addEventVM.currency, placeholder: C.PlaceHolder.currency)
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
                        NavigationLink(destination: SelectionListView(listViewModel: languageListModel)) {
                            CustomNavigationView(selectedItem: $addEventVM.language, placeholder: "Select")
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
                        NavigationLink(destination: SelectionListView(listViewModel: eventCategoryListModel)) {
                            CustomNavigationView(selectedItem: $addEventVM.eventCategory, placeholder: "Select")
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
            startDate = eventModel.startDate ?? Date()
            startTime = eventModel.startTime ?? Date()
            endDate = eventModel.endDate ?? Date()
            endTime = eventModel.endTime ?? Date()
            
            isPaid = (Int(eventModel.fee) ?? 0) > 0
            acceptParticipants = eventModel.acceptParticipants.toBool() ?? false
            allowComments = eventModel.allowComments.toBool() ?? false
        })
        .fullScreenCover(isPresented: $showPreview, content: {
            eventDetailPreviewView
                .environmentObject(addEventVM)
                .environmentObject(eventModel)
        })
        .navigationBarTitle(Text(eventType.name.capitalized), displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
        
//        NavigationLink(isActive: $showAddEvent) {
//            if let selectedEvent: EventModel = addEventVM.selectedEvent, let selectedEventTypeID: String = selectedEvent.type, let eventType: EventTypeModel = addEventVM.eventTypes.first(where: { $0.id == selectedEventTypeID }) {
//                EventDetailsView(eventType: eventType)
//                    .environmentObject(addEventVM)
//                    .environmentObject(selectedEvent)
//            }
//        } label: {
//            EmptyView()
//        }
    }
    
    private var eventDetailPreviewView: EventDetailPreviewView {
        var eventPV: EventDetailPreviewView = .init(eventType: eventType, images: addEventVM.eventImages + images)
        eventPV.dismissWithEventID = { eventID in
            if let eventID = eventID {
                print(eventID)
            }
            dismiss()
            
            dismissWithEventID?(eventID)
        }
        return eventPV
    }
    
    private var languageListModel: LanguagesListViewModel {
        let languageLM: LanguagesListViewModel = .init()
        languageLM.selectedLanguage = addEventVM.selectedLanguage
        languageLM.didSelectLanguage = { lang in
            addEventVM.selectedLanguage = lang
            return true
        }
        return languageLM
    }
    
    private var currenciesListModel: CurrenciesListViewModel {
        let currencyLM: CurrenciesListViewModel = .init()
        currencyLM.selectedCurrency = addEventVM.selectedCurrency
        currencyLM.didSelectCurrency = { curr in
            addEventVM.selectedCurrency = curr
            return true
        }
        return currencyLM
    }

    private var timzonesListModel: TimezoneListViewModel {
        let timezoneLM: TimezoneListViewModel = .init()
        timezoneLM.selectedTimezone = addEventVM.selectedTimezone
        timezoneLM.didSelectTimezone = { tzone in
            addEventVM.selectedTimezone = tzone
            return true
        }
        return timezoneLM
    }
    
    private var eventCategoryListModel: EventCategoryListViewModel {
        let eventCategoryLM: EventCategoryListViewModel = .init()
        eventCategoryLM.selectedCategory = addEventVM.selectedEventCategory
        eventCategoryLM.didSelectCategory = { eCat in
            addEventVM.selectedEventCategory = eCat
            return true
        }
        return eventCategoryLM
    }
}

struct AddImageView: View {
    @EnvironmentObject var addEventVM: AddEventViewModel
    
    @Binding  var images: [UIImage]

    @State var selectedMode: UIImagePickerController.SourceType?
    @State private var showAction = false
    
    private let screenWidth = UIScreen.main.bounds.size.width
    private let imageH: CGFloat = 220

    var body: some View {
        ZStack {
            imageScroller
            
            Button {
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    showAction = true
                } else {
                    selectedMode = .photoLibrary
                }
            } label: {
                VStack(spacing: 10) {
                    Image(systemName: ImageName.cameraFill)
                    Title4(title: "Add photo(s)", fColor: .lightBrown)
                }
            }
        }
        .offset(y: -1)
        .sheet(item: $selectedMode) { mode in
            ImagePicker(sourceType: mode, selectedImages: self.$images)
        }
        .actionSheet(isPresented: $showAction) {
            var actionButtons: [ActionSheet.Button] = .init()
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let cameraButton: ActionSheet.Button = .default(Text("Camera"), action: {
                    selectedMode = .camera
                })
                actionButtons.append(cameraButton)
            }
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let gallaryButton: ActionSheet.Button = .default(Text("Photo Library"), action: {
                    selectedMode = .photoLibrary
                })
                actionButtons.append(gallaryButton)
            }
            actionButtons.append(.cancel())

            return ActionSheet(title: Text("Choose mode"), buttons: actionButtons)
        }
    }
    
    @ViewBuilder
    private var imageScroller: some View {
        let scrollImages: [UIImage] = addEventVM.eventImages + images
        if scrollImages.isEmpty {
            GreyBackgroundImage()
        } else {
            HorizontalImageScroller(images: scrollImages)
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
