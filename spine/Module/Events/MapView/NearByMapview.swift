//
//  NearByMapview.swift
//  spine
//
//  Created by Mac on 21/06/22.
//

import SwiftUI
import CoreLocation

struct NearByMapview: View {
    @StateObject var mapData = MapViewModel()
    @State var locationManager = CLLocationManager()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            MapView()
                .environmentObject(mapData)
                .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                
                HStack {
                    
                    ButtonWithCustomImage2(image: "ic_close", size: 20, fColor: .black, btnTapped: {
                        dismiss()
                    })
                    CustomSearchBar(placeHolder: "Search events", searchText: $mapData.searchTxt)
                        .padding(.horizontal, -5)
                    CustomButton(image: "FilterBTN") {
                        
                    }
                    
                }.padding(.horizontal, 20)
                
                Spacer()
                //MapRow(eventType: .retreat)
                
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack {
//                        MapRow(eventType: .retreat)
//                        MapRow(eventType: .online)
//                        MapRow(eventType: .retreat)
//
//                    }
//                }
                MapLocationScrollingView()
                
                
            }
        }
        .onAppear {
            locationManager.delegate = mapData
            locationManager.requestWhenInUseAuthorization()
        }
        .onChange(of: mapData.searchTxt) { newValue in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if newValue == mapData.searchTxt {
                    self.mapData.searchQuerry()
                }
            }
        }
    }
}


struct NearByMapview_Previews: PreviewProvider {
    static var previews: some View {
        NearByMapview()
    }
}


struct MapRow: View {
    let eventType: EventType
    var body: some View {
        
            HStack {
                VStack(spacing: 10) {
                    CircularBorderedProfileView(image: "Oval 57", size: 65, borderWidth: 0, showShadow: false)
                    Title4(title: "Oliver")
                }
                VStack(alignment: .leading, spacing: 5) {
                    Title5(title: eventType.getTitle().uppercased(), fColor: .lightBrown)
                    VStack(alignment: .leading) {
                        Title4(title: "Yoga weekend Reclaiming your Centre India", lineLimit: 2)
                    }//.frame(height: 70)
                    
                    Title4(title: "Sat, 9 May 2021, 1 hr")
                }.padding(.horizontal, 10)
                Spacer()
                VStack(alignment: .trailing, spacing: 50) {
                    ButtonWithCustomImage(image: "Bookmark", size: 18) {
                        print("BookMark tapped")
                    }
                    //Spacer()
                    Header5(title: "$75")
                }
            }.padding(10)
            //.frame(width: UIScreen.main.bounds.width - 60)
            //.background(Color.white)
            .background(Color(UIColor.systemBackground))
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        
    }
}

struct MapLocationScrollingView: View {
    var body: some View {
        TabView {
           // ForEach(images, id: \.self){ image in
                MapRow(eventType: .retreat)
                MapRow(eventType: .online)
                MapRow(eventType: .retreat)
           // }
        }
        .frame(height: 140)
        .tabViewStyle(.page)
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .automatic))
    }
}



