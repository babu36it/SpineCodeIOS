//
//  PracticionerListView.swift
//  spine
//
//  Created by Mac on 19/07/22.
//

import SwiftUI

struct PracticionerListView: View {
    @Environment(\.dismiss) var dismiss
    @State var showFilters = true
    
    var body: some View {
        VStack(spacing: 0) {
            
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4).padding(.bottom, 10)
            
            if showFilters {
                HStack {
                    SubHeader5(title: "London,3categories,5methods,1Desease", lineLimit: 2)
                    Spacer()
                    VStack {
                        Button {
                            showFilters = false
                        } label: {
                            Image(systemName: ImageName.multiplyCircleFill)
                                .foregroundColor(.lightBrown)
                        }
                        Button("Edit") {
                            self.dismiss()
                        }.tint(.lightBrown)

                    }
                }.padding(.horizontal, 20)
            }
            
            List {
                ForEach(attendeeLst, id: \.self) { attendee in
                    PracticionerCell(attendee: attendee)
                }
            }.listStyle(.plain)
            LargeButton(title: "Map view", width:120, height: 30, bColor: .lightBrown, fSize: 12, fColor: .white) {
                //sheetType = .mapView
            }//.padding(.bottom, 20)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("YOUR SELECTION OF PRACTICIONERS", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            self.dismiss()
        }, label: {
            Image(systemName: ImageName.multiply)
                .foregroundColor(.primary)
        }))
        .navigationBarItems(leading: Button(action: {
        }, label: {
            Image(systemName: ImageName.plus)
                .foregroundColor(.primary)
        }))
        
//        .modifier(BackButtonModifier(action: {
//            self.dismiss()
//        }))
        
    }
}

struct PracticionerListView_Previews: PreviewProvider {
    static var previews: some View {
        PracticionerListView()
    }
}


struct PracticionerCell: View {
    //let eventType: EventType
    let attendee: Attendee
    var body: some View {
        
            HStack {
                VStack(spacing: 10) {
                    CircularBorderedProfileView(image: attendee.img, size: 65, borderWidth: 0, showShadow: false)
                    Title4(title: attendee.name.components(separatedBy: " ")[0])
                }
                VStack(alignment: .leading, spacing: 5) {
                    Header6(title: "Salubrius Work", fColor: .lightBrown)
                    VStack(alignment: .leading) {
                        Title4(title: attendee.name)
                        Title4(title: "Lorem Ipsum dolor sit amet det lorem Ipsum dolor", lineLimit: 2)
                    }
                    
                    Title4(title: "Berlyn, Germany", fColor: .gray)
                }.padding(.horizontal, 10)
                Spacer()
                VStack(alignment: .trailing, spacing: 50) {
                    ButtonWithCustomImage(image: "Bookmark", size: 18) {
                        print("BookMark tapped")
                    }
                    Spacer()
                }.padding(.top, 5)
            }.padding(5)
            //.background(Color.white)
            .background(Color(UIColor.systemBackground))
            
        
    }
}


struct FilterView: View {
    var body: some View {
        Text("")
    }
}
