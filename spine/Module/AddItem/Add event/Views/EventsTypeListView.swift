//
//  AddEventType.swift
//  spine
//
//  Created by Mac on 12/06/22.
//

import SwiftUI

struct EventsTypeListView: View {
    @EnvironmentObject var addEventVM: AddEventViewModel
    var onSelect: (EventTypeModel) -> Void
    
    private let safeAreaBottomInset: CGFloat = AppUtility.shared.applicationKeyWindow?.safeAreaInsets.bottom ?? 0
    
    var body: some View {
        VStack {
            Text("").frame(width: 80, height: 4, alignment: .center).background(Color.lightBrown)
            Text("What kind of event is it?").bold().padding()
            List {
                ForEach(addEventVM.eventTypes) { eventType in
                    EventTypeRow(eventType: eventType)
                        .padding(.vertical, 2)
                        .onTapGesture {
                            onSelect(eventType)
                        }
                }
            }
            .listStyle(.plain)
            .frame(height: 380)
        }
        .padding(.bottom, safeAreaBottomInset + 70)
        .padding(.horizontal)
        .padding(.top, 20)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(25)
    }
}

struct EventTypeRow: View {
    let eventType: EventTypeModel
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Header4(title: eventType.name)
            Title3(title: eventType.description)
        }
        .padding(5)
    }
}
