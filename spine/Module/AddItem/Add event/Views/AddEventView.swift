//
//  AddEventView.swift
//  spine
//
//  Created by Mac on 11/06/22.
//

import SwiftUI

struct AddEventView: View {
    @Environment(\.dismiss) var dismiss

    var dismissWithEventID: ((String?) -> Void)?

    @State private var showAddEventTypes = false
    @State private var showAddEvent = false
    
    @StateObject private var addEventVM = AddEventViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4).padding(.top, 10)
                    .padding(.bottom, 40)
                
                VStack(alignment: .leading, spacing: 30) {
                    SubHeader3(title: "How would you like to start?")
                    AddEventButton(onTapped: {
                        showAddEventTypes = true
                    })
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
                
                VStack(alignment: .leading, spacing: 30) {
                    if let draftEvent = addEventVM.draftEvent {
                        SubHeader3(title: "Drafts")
                            .padding(.horizontal, 20)

                        ExistingEventView(event: draftEvent, imagePath: addEventVM.imagePath, isDraft: true, onTapped: { event in
                            addEventVM.selectedEvent = event
                            showAddEvent = true
                        })
                    }
        
                    if let userEvents = addEventVM.userEvents {
                        SubHeader3(title: "Duplicate an existing event")
                            .padding(.horizontal, 20)

                        List {
                            ForEach(userEvents) { event in
                                ExistingEventView(event: event, imagePath: addEventVM.imagePath, onTapped: { event in
                                    addEventVM.selectedEvent = event
                                    showAddEvent = true
                                })
                            }
                        }
                        .listStyle(.plain)
                    }
                }
                Spacer()
            }
            
            VStack {
                Spacer()
                AddEventTypeView(onSelect: { eventType in
                    let eventModel: EventModel = EventModel()
                    eventModel.type = eventType.id
                    addEventVM.selectedEvent = eventModel
                    showAddEventTypes.toggle()

                    showAddEvent = true
                })
                .environmentObject(addEventVM)
                .offset(y: showAddEventTypes ? 0: UIScreen.main.bounds.height)
            }
            .background((showAddEventTypes ? Color.black.opacity(0.3) : Color.clear).onTapGesture {
                showAddEventTypes.toggle()
            })
            .edgesIgnoringSafeArea(.all)
        }
        .onAppear(perform: {
            addEventVM.didAppear()
        })
        .animation(.default, value: showAddEventTypes)
        .navigationBarTitle(Text("ADD EVENT"), displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))

        NavigationLink(isActive: $showAddEvent) {
            if let selectedEvent: EventModel = addEventVM.selectedEvent, let selectedEventTypeID: String = selectedEvent.type, let eventType: EventTypeModel = addEventVM.eventTypes.first(where: { $0.id == selectedEventTypeID }) {
                eventDetailsView(eventType: eventType)
                    .environmentObject(addEventVM)
                    .environmentObject(selectedEvent)
            }
        } label: {
            EmptyView()
        }
    }
    
    private func eventDetailsView(eventType: EventTypeModel) -> EventDetailsView {
        var eventDV: EventDetailsView = .init(eventType: eventType)
        eventDV.dismissWithEventID = { eventID in
            if let eventID = eventID {
                print(eventID)
            }
            dismiss()
            
            dismissWithEventID?(eventID)
        }
        return eventDV
    }
}

struct AddEventButton: View {
    var onTapped: () -> Void
    
    var body: some View {
        Button {
            onTapped()
        } label: {
            HStack {
                Image(systemName: ImageName.plus).foregroundColor(Color.lightBrown)
                Header5(title: "Add a new event")
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 40)
        .padding(.leading, 10)
        .padding(5)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(8)
        .shadow(color: Color.gray.opacity(0.7), radius: 5)
        .foregroundColor(.primary)
    }
}

struct ExistingEventView: View {
    let event: EventModel
    let imagePath: String?
    var isDraft: Bool = false
    let onTapped: (EventModel)-> Void

    var body: some View {
        Button {
            onTapped(event)
        } label: {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Header5(title: event.title)
                    Title4(title: event.eventDescription)
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                    Title4(title: event.dateString)
                    Title4(title: event.languageName)
                    if isDraft {
                        SubHeader5(title: "Finish & publish event", fColor: .red)
                    }
                }
                Spacer()
                Group {
                    if let imagePath: String = event.imageURLs(for: imagePath)?.first {
                        RemoteImage(imageDownloader: DefaultImageDownloader(imagePath: imagePath))
                    } else {
                        Image(ImageName.ic_launch)
                            .resizable()
                    }
                }
                .frame(width: 80, height: 70)
                .aspectRatio(contentMode: .fill)
            }
            .padding(.horizontal, 5)
        }
        .frame(maxWidth: .infinity)
        .padding( 10)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(8)
        .shadow(color: Color.gray.opacity(0.7), radius: 5)
        .foregroundColor(.primary)
    }
}
