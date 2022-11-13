//
//  SaveEventsInCalndrView.swift
//  spine
//
//  Created by Mac on 04/07/22.
//

import SwiftUI

struct SaveEventsInCalndrView: View {
    @Environment(\.dismiss) var dismiss

    @StateObject var eventCalendarViewModel: SaveEventsInCalendarViewModel = .init()
    
    var body: some View {
        VStack(spacing: 0) {
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)
            
            VStack(spacing: 0) {
                Divider()
                Toggle("Save events to calender", isOn: $eventCalendarViewModel.saveEvent)
                    .font(.Poppins(type: .regular, size: 16))
                    .tint(.lightBrown)
                    .padding(.vertical, 5)
                    .onChange(of: eventCalendarViewModel.saveEvent) { newValue in
                        eventCalendarViewModel.updateSaveEventsInCalendarStatus(newValue)
                    }
                Divider()
                
                FooterView(text: "Automatically save events you're attending to your device's calender.\n \n Make sure to check on the app for last-minute changes before the event - the app cant update events once they're added to your devices calender.")
                    .padding(.top, 30)
            }.padding(.top, 40)
            .padding(.horizontal, 20)
            Spacer()
        }
        .onAppear(perform: { eventCalendarViewModel.getSaveEventsInCalendarStatus() })
        .modifier(LoadingView(isLoading: $eventCalendarViewModel.showLoader))
        .navigationBarTitle("SAVE EVENTS TO CALENDER", displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
    }
}
