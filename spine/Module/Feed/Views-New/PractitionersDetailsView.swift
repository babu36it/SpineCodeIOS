//
//  PractitionersDetailsView.swift
//  spine
//
//  Created by Mac on 19/07/22.
//

import SwiftUI

struct PractitionersDetailsView: View {
    @Environment(\.dismiss) var dismiss
    let screenWidth = UIScreen.main.bounds.size.width
    @State var showPopOver = false
    @State var selectedLocation: String = ""
    
    @State var categories: [String] = []
    @State var categoryList: String = ""
    
    @State var performance: [String] = []
    @State var performanceList: String = ""
    
    @State var desease: [String] = []
    @State var deseaseList: String = ""
    
    
    
//    @State var dateRange: ClosedRange<Date>? = nil
//    @State var selectedDateStr: String = ""
    @State private var isSelectedWorld = false
    @State private var isSelectedCountry = false
    @State var showPractList = false
    var body: some View {
        VStack {
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)
            VStack(alignment: .leading, spacing: 30) {
                Title2(title: "What can we help you find?")
                VStack(alignment: .leading) {
                    Button(action: {
                        isSelectedWorld = true
                        isSelectedCountry = false
                    }) {
                        HStack(spacing: 10) {
                            Image(systemName: isSelectedWorld ? ImageName.checkmarkSquareFill : ImageName.square)
                                .resizable()
                                .frame(width: 25, height: 25)
                            //.foregroundColor(.lightGray2)
                            Title3(title: "browse worldwide")
                            Spacer()
                            
                        }
                    }.foregroundColor(.primary)
                }
                VStack(alignment: .leading) {
                    Button(action: {
                        isSelectedWorld = false
                        isSelectedCountry = true
                    }) {
                        HStack(spacing: 10) {
                            Image(systemName: isSelectedCountry ? ImageName.checkmarkSquareFill : ImageName.square)
                                .resizable()
                                .frame(width: 25, height: 25)
                            //.foregroundColor(.lightGray2)
                            Title3(title: "browse by country")
                            Spacer()
                            
                        }
                    }.foregroundColor(.primary)
                }
                
                VStack(alignment: .leading) {
                    Title4(title: "or browse by city ")
                    NavigationLink(destination: ItemSelectionView(selectedItem: $selectedLocation, itemType: .location)) {
                        CustomNavigationView(selectedItem: $selectedLocation, placeholder: C.PlaceHolder.address, imageStr: "Location_Pin_small")
                    }
                }
                
                VStack(alignment: .leading) {
                    Title4(title: "Key performance and methods  ( multiple choice)")
                    NavigationLink(destination: MultipleSelectionList(type: .performance, selections: $performance)) {
                        CustomNavigationView(selectedItem: $performanceList, placeholder: C.PlaceHolder.select)
                    }
                }
                .onChange(of: performance) { newValue in
                    performanceList = newValue.joined(separator:", ")
                }
                VStack(alignment: .leading) {
                    Title4(title: "Desease pattererns ( multiple choice) ")
                    NavigationLink(destination: MultipleSelectionList(type: .desease, selections: $desease)) {
                        CustomNavigationView(selectedItem: $deseaseList, placeholder: C.PlaceHolder.select)
                    }
                }
                .onChange(of: desease) { newValue in
                    deseaseList = newValue.joined(separator:", ")
                }
                
                VStack(alignment: .leading) {
                    Title4(title: "Categories ( multiple selection) ")
                    NavigationLink(destination: MultipleSelectionList(type: .category, selections: $categories)) {
                        CustomNavigationView(selectedItem: $categoryList, placeholder: C.PlaceHolder.select)
                    }
                }
                .onChange(of: categories) { newValue in
                    categoryList = newValue.joined(separator:", ")
                }
                
                LargeButton(title: "FIND PRACTICIONERS", width: screenWidth - Kconstant.filterPadding, height: 40, bColor: Color.lightBrown, fSize: 15, fColor: .white) {
                    //dismiss()
                    showPractList = true
                }
                
                
            }.padding(.horizontal, Kconstant.filterPadding/2)
            
            NavigationLink(isActive: $showPractList) {
                PracticionerListView()
            } label: {
                EmptyView()
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("SEARCH PRACTICIONERS", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            self.dismiss()
        }, label: {
            Image(systemName: ImageName.multiply)
                .foregroundColor(.primary)
        }))
    }
}

struct PractitionersDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PractitionersDetailsView()
    }
}
