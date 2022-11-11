//
//  MDPDayView.swift
//  spine
//
//  Created by Mac on 21/06/22.
//

import SwiftUI

/**
 * MDPDayView displays the day of month on a MDPContentView. This a button whose color and
 * selectability is determined from the MDPDayOfMonth in the MDPModel.
 */
extension Notification.Name {
    static var acAuthAPI: Notification.Name { return .init("acAuthAPI") }
}

struct MDPDayView: View {
    var acAuthAPI = NotificationCenter.default.publisher(for: .acAuthAPI)
    @EnvironmentObject var monthDataModel: MDPModel
    let cellSize: CGFloat = 40
    var dayOfMonth: MDPDayOfMonth
    
    // outline "today"
    private var strokeColor: Color {
        dayOfMonth.isToday ? Color.lightBrown : Color.clear
    }
    
    // filled if selected
    private var fillColor: Color {
        monthDataModel.isSelected(dayOfMonth) ? Color.lightBrown : Color.clear
    }
    
    // reverse color for selections or gray if not selectable
    private var textColor: Color {
        if dayOfMonth.isSelectable {
            return monthDataModel.isSelected(dayOfMonth) ? Color.white : Color.black
        } else {
            return Color.gray
        }
    }
    
    private func handleSelection() {
        if dayOfMonth.isSelectable {
            monthDataModel.selectDay(dayOfMonth)
        }
    }
    
    func unselectDateOnDelete(dateModel: MDPDayOfMonth) {
        guard let dateToDelete = dateModel.date else {return}
        if monthDataModel.selections.contains(dateToDelete), let pos = monthDataModel.selections.firstIndex(of: dateToDelete) {
            monthDataModel.selections.remove(at: pos)
        }
    }
    
    var body: some View {
        Button( action: {handleSelection()} ) {
            Text("\(dayOfMonth.day)")
                .font(.title3)
                .fontWeight(.medium)
                .foregroundColor(textColor)
                .frame(minHeight: cellSize, maxHeight: cellSize)
                .background(
                    Circle()
                        .stroke(strokeColor, lineWidth: 1)
                        .background(Circle().foregroundColor(fillColor))
                        .frame(width: cellSize, height: cellSize)
                )
        }.foregroundColor(.black)
            .onReceive(acAuthAPI) { obj in
                if let date = obj.object as? MDPDayOfMonth {
                    unselectDateOnDelete(dateModel: date)
                }
            }
    }
}

