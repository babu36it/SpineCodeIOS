//
//  MDPContentView.swift
//  spine
//
//  Created by Mac on 21/06/22.
//

import SwiftUI

/**
 * Displays the calendar of MDPDayOfMonth items using MDPDayView views.
 */

let gridSpacing = 5.0
let gridSize = 40.0

struct MDPContentView: View {
    @EnvironmentObject var monthDataModel: MDPModel
    
    let cellSize: CGFloat = 40
    
    let columns = [
        GridItem(.fixed(gridSize), spacing: gridSpacing),
        GridItem(.fixed(gridSize), spacing: gridSpacing),
        GridItem(.fixed(gridSize), spacing: gridSpacing),
        GridItem(.fixed(gridSize), spacing: gridSpacing),
        GridItem(.fixed(gridSize), spacing: gridSpacing),
        GridItem(.fixed(gridSize), spacing: gridSpacing),
        GridItem(.fixed(gridSize), spacing: gridSpacing)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 0) {
            
            // Sun, Mon, etc.
            ForEach(0..<monthDataModel.dayNames.count, id: \.self) { index in
                Text(monthDataModel.dayNames[index].uppercased())
                    .font(.caption).fontWeight(.medium)
                    .foregroundColor(.lightBrown)
            }
            .padding(.bottom, 10)
    
            // The actual days of the month.
            ForEach(0..<monthDataModel.days.count, id: \.self) { index in
                if monthDataModel.days[index].day == 0 {
                    Text("")
                        .frame(minHeight: cellSize, maxHeight: cellSize)
                } else {
                    MDPDayView(dayOfMonth: monthDataModel.days[index])
                }
            }
        }.padding(.bottom, 10)
    }
}

