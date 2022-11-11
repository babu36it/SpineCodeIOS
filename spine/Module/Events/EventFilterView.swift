//
//  EventFilterView.swift
//  spine
//
//  Created by Mac on 21/06/22.
//

import SwiftUI

struct EventFilterView: View {
    @Environment(\.dismiss) var dismiss
    let screenWidth = UIScreen.main.bounds.size.width
    @State var showPopOver = false
    @State var selectedLocation: String = ""
    
    @State var categories: [String] = []
    @State var categoryList: String = ""
    
    @State var dateRange: ClosedRange<Date>? = nil
    @State var selectedDateStr: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        Title2(title: "FILTER")
                        Spacer()
                        ButtonWithSystemImage(image: ImageName.multiply, size: 18) {
                            dismiss()
                        }
                    }.padding()
                    LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)
                }
                
                VStack(alignment: .leading, spacing: 30) {
                    Title2(title: "What can we help you find?")
                        .padding(.top)
                    
                    VStack(alignment: .leading) {
                        Title4(title: "Location")
                        NavigationLink(destination: ItemSelectionView(selectedItem: $selectedLocation, itemType: .location)) {
                            CustomNavigationView(selectedItem: $selectedLocation, placeholder: C.PlaceHolder.address, imageStr: "Location_Pin_small")
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Title4(title: "Dates")
                        NavigationLink(destination: MultiSelectionCalenderView(selectedDays: $dateRange)) {
                            CustomNavigationView(selectedItem: $selectedDateStr, placeholder: C.PlaceHolder.dates, imageStr: "Calender_small")
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Title4(title: "Categories")
                        NavigationLink(destination: MultipleSelectionList(type: .category, selections: $categories)) {
                            CustomNavigationView(selectedItem: $categoryList, placeholder: C.PlaceHolder.category)
                        }
                    }
                    .onChange(of: categories) { newValue in
                        categoryList = newValue.joined(separator:", ")
                    }
                    
                    
                    LargeButton(title: "FIND EVENTS", width: screenWidth - Kconstant.filterPadding, height: 40, bColor: Color.lightBrown, fSize: 15, fColor: .white) {
                        dismiss()
                    }
                    .onChange(of: dateRange) { newValue in
                        getFirstAndLastDate(dateRange: newValue)
                    }
                    
                }.padding(.horizontal, Kconstant.filterPadding/2)
                
                Spacer()
            }.padding(.vertical, 10)
                .navigationBarHidden(true)
        }
    }
    
    func getFirstAndLastDate(dateRange: ClosedRange<Date>?) {
        if let fDate = dateRange.map({$0.lowerBound}), let lDate = dateRange.map({$0.upperBound}) {
            selectedDateStr = fDate.toString("dd/MM/yyyy") + " - " + lDate.toString("dd/MM/yyyy")
        } else {
            selectedDateStr = ""
        }
    }
}

struct EventFilterView_Previews: PreviewProvider {
    static var previews: some View {
        EventFilterView()
    }
}
