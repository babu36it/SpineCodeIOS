//
//  MDPMonthView.swift
//  spine
//
//  Created by Mac on 21/06/22.
//

import SwiftUI

/**
 * MDPMonthView is really the crux of the control. This displays everything and handles the interactions
 * and selections. MulitDatePicker is the public interface that sets up the model and this view.
 */
struct MDPMonthView: View {
    @EnvironmentObject var monthDataModel: MDPModel
        
    @State private var showMonthYearPicker = false
    @State private var testDate = Date()
    var clearDates = NotificationCenter.default.publisher(for: .clearDates)
    
    private func showPrevMonth() {
        withAnimation {
            monthDataModel.decrMonth()
            showMonthYearPicker = false
        }
    }
    
    private func showNextMonth() {
        withAnimation {
            monthDataModel.incrMonth()
            showMonthYearPicker = false
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(monthDataModel.title).font(.Poppins(type: .regular, size: 17))
                Spacer()
                Button( action: {showPrevMonth()} ) {
                    Image(systemName: ImageName.chevronLeft).font(.title2)
                        .foregroundColor(.lightBrown)
                }.padding()
                Button( action: {showNextMonth()} ) {
                    Image(systemName: ImageName.chevronRight).font(.title2)
                        .foregroundColor(.lightBrown)
                }.padding()
            }
            .padding(.horizontal, 90)
            MDPContentView()
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
        )
        .padding()
        .frame(width: 500, height: 500)
        .onReceive(clearDates) { _ in
            monthDataModel.selections = []
        }
    }
}
