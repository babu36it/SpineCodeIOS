//
//  AboutProfileView.swift
//  spine
//
//  Created by Mac on 01/07/22.
//

import SwiftUI

struct AboutProfileView: View {
    @State var showContactInfo = false
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ScrollableTextView(title: "About me")
                ScrollableTextView(title: "Offer description", content: txt2)
                ScrollableTextView(title: "Key performance areas and methods", content: txt3)
                ScrollableTextView(title: "Disease pattern I treat")
                ScrollableTextView(title: "Languages of practicet", content: "German, English")
                ScrollableTextView(title: "Qualifications")
                ScrollableTextView(title: "Feedbacks")
            }
            if showContactInfo {
                ContactInfoView()
            } else {
                Button {
                    showContactInfo = true
                } label: {
                    Text("See Business Contact infos")
                        .font(.Poppins(type: .regular, size: 16))
                        .underline()
                }.tint(.primary)

            }
            
        }.padding(10)
            .padding(.bottom, 20)
    }
}

struct AboutProfileView_Previews: PreviewProvider {
    static var previews: some View {
        AboutProfileView()
    }
}



struct ContactInfoView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("CONTACT").underline()
                
            VStack(alignment: .leading, spacing: 2) {
                Text("Praxis Dietrich")
                Text("Gurowonder street")
                Text("35787 Oberrhausen bei Kassel")
                Text("Germany")
            }
            
            Link(destination: URL(string: "https://www.apple.com")!, label: {
                Text("Link to Google maps")
                    .underline()
                    .foregroundColor(.red)
            })
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Tel: +49 3087933465").underline()
                Text("Mobile: 9237658934").underline()
                Text("Email: info@gartslaunch.com").underline()
            }
            
            Text("www.marieddietch.com").underline()
                
            Text("MetaVerseaddress: Loreimpusygfghf823456").underline()
            AddressMapView().frame(height: 200)
            
        }.font(.Poppins(type: .regular, size: 14))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(10)
    }
}


struct ScrollableTextView: View {
    let title: String
    var content = txt1
    var body: some View {
        ZStack {
            Text("")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: Color.gray.opacity(0.7), radius: 5)
            
            VStack(alignment: .leading, spacing: 5) {
                Header5(title: title, fColor: .lightBlue)
                ScrollView {
                    Title4(title: content)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }.frame(maxWidth: .infinity, maxHeight: 100)
            }.padding(10)
        }.padding(5)
    }
}


import SwiftUI
import CoreLocation

struct AddressMapView: View {
    @StateObject var mapData = MapViewModel()
    @State var locationManager = CLLocationManager()
    
    var body: some View {
        ZStack {
            MapView()
                .environmentObject(mapData)
                .ignoresSafeArea(.all, edges: .all)
        }
    }
}
