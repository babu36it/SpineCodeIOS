//
//  AddEventType.swift
//  spine
//
//  Created by Mac on 12/06/22.
//

import SwiftUI

struct AddEventType: View {
    
    @EnvironmentObject var addEventVM: AddEventViewModel
    
    var body: some View {
        VStack {
            Text("").frame(width: 80, height: 4, alignment: .center).background(Color.lightBrown)
            Text("What kind of event is it?").bold().padding()
            List {
                ForEach(addEventVM.eventTypes) { event in
                    NavigationLink(destination: EventDetailsView(eventType: event)) {
                        EventTypeRow(eventType: event)
                    }.padding(.vertical, 2)
                }
            }
            //.scrollEnabled(false)
            .listStyle(.plain)
            .frame(height: 380)
        }
        .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 70)
        .padding(.horizontal)
        .padding(.top, 20)
        //.background(Color.white)
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
        }.padding(5)
    }
}
