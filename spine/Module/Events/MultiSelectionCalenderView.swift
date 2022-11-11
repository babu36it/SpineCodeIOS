//
//  MultiSelectionCalenderView.swift
//  spine
//
//  Created by Mac on 21/06/22.
//

import SwiftUI

struct MultiSelectionCalenderView: View {
    @Binding var selectedDays: ClosedRange<Date>?
    @Environment(\.dismiss) var dismiss
    let screenWidth = UIScreen.main.bounds.size.width
    //@State private var anyDays = [Date]()
    @State private var dateRange: ClosedRange<Date>? = nil
    
    
    var body: some View {
        VStack {
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4).padding(.vertical, 5)
            
            CalenderView(dateRange: $dateRange)
            
            LargeButton(title: "ADD DATES", width: screenWidth - 100, height: 40, bColor: Color.lightBrown, fSize: 15, fColor: .white) {
                selectedDays = dateRange
                dismiss()
            }.padding(.bottom, 10)
            
            ButtonSmall(txt: "Skip") {
                self.dismiss()
            }

            Spacer()
        }.onAppear(perform: {
            //anyDays = selectedDays
        })
        .navigationBarTitle("ADD DATES", displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
        .navigationBarItems(trailing: ButtonSmall(txt: "Clear", tapped: {
            selectedDays = nil
            NotificationCenter.default.post(name: .clearDates, object: nil)
        }))
        
    }
}

struct ButtonSmall: View {
    var txt: String
    var tapped: () -> Void
    var body: some View {
        Button(action : {
            tapped()
        }){
            Text(txt)
                .font(.Poppins(type: .regular, size: 15))
                .foregroundColor(.primary)
        }
    }
}

//struct MultiSelectionCalenderView_Previews: PreviewProvider {
//    static var previews: some View {
//        MultiSelectionCalenderView()
//    }
//}


extension IndexSet {
    func indexPaths(_ section: Int) -> [IndexPath] {
        return self.map{IndexPath(item: $0, section: section)}
    }
}

extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    } }

/**
 * This ContentView shows how to use MultiDatePicker as an in-line View. You could also use it as an overlay
 * or in a sheet.
 */
struct CalenderView: View {
    
    // The MultiDatePicker can be used to select a single day, multiple days, or a date range. These
    // vars are used as bindings passed to the MultiDatePicker.
    @State private var selectedDate = Date()
    //@Binding var anyDays: [Date]
    @Binding var dateRange: ClosedRange<Date>?
    
    // Another thing you can do with the MultiDatePicker is limit the range of dates that can
    // be selected.
    let testMinDate = Calendar.current.date(from: DateComponents(year: 2021, month: 4, day: 1))
    let testMaxDate = Calendar.current.date(from: DateComponents(year: 2021, month: 5, day: 30))
    
    var selectedDateAsString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: selectedDate)
    }
        
    var body: some View {
        VStack {
           // MultiDatePicker(anyDays: self.$anyDays, includeDays: .allDays, minDate: Date())
            MultiDatePicker(dateRange: self.$dateRange, includeDays: .allDays, minDate: Date())
//            Text("Selected \(anyDays.count) Days").padding()
//            List {
//                ForEach(anyDays, id: \.self) { day in
//                    Text("\(day)")
//                }
//            }
        }
    }
}

extension Date {
    func toString(_ formatter: String? = "yyyy-MM-dd'T'HH:mm:ss") -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = formatter
        dateformatter.calendar = Calendar.current
        let date = dateformatter.string(from: self)
        return date
    }
}
