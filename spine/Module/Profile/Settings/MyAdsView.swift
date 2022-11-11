//
//  MyAdsView.swift
//  spine
//
//  Created by Mac on 13/08/22.
//

import SwiftUI
enum AdStatus {
    case inprogress
    case current
    case past
}

struct AdDetail: Hashable {
    let status: AdStatus
    let adType: AdType
    let image: String
    let title: String
    let subtitle: String
    let description: String
    var duration: String?
    var startDate: String?
    var time: String?
    var cost: String?
}

let myAds = [
    AdDetail(status: .inprogress, adType: .pictureVideo, image:"podcastDetailBanner", title: "Herbal Essence", subtitle: "Made in Germany", description: C.StaticText.loremText),
    AdDetail(status: .current, adType: .event, image: "FeedBanner3", title: "Yoga Weekend Retreat - Reclaiming Your Centre", subtitle: "Made in Germany", description: C.StaticText.loremText, duration: "1 Week", startDate: "12 May 2020", time: "16:00", cost: "100 $"),
    AdDetail(status: .past, adType: .podcast, image: "FeebBanner1", title: "My New Event", subtitle: "", description: C.StaticText.loremText, duration: "1 Week", startDate: "12 May 2020", time: "16:00", cost: "100 $"),
    AdDetail(status: .past, adType: .podcast, image: "FeebBanner1", title: "My New Event", subtitle: "", description: C.StaticText.loremText, duration: "1 Week", startDate: "12 May 2020", time: "16:00", cost: "100 $")
             
]

struct MyAdsView: View {
    @State var myAdsList = myAds
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 3)
            ScrollView {
                Section {
                    ForEach(myAdsList.filter {$0.status == .inprogress}, id: \.self) { item in
                        MyAdCell(item: item)
                    }
                } header: {
                    Header1(title: "Inprogress", fWeight: .semibold)
                        .frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal)
                        .offset(y: 20)
                }
                
                Section {
                    ForEach(myAdsList.filter {$0.status == .current}, id: \.self) { item in
                        MyAdCell(item: item)
                    }
                } header: {
                    Header1(title: "Current", fWeight: .semibold)
                        .frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal)
                        .offset(y: 20)
                }
                
                Section {
                    ForEach(myAdsList.filter {$0.status == .past}, id: \.self) { item in
                        MyAdCell(item: item)
                    }
                } header: {
                    Header1(title: "Past", fWeight: .semibold)
                        .frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal)
                        .offset(y: 20)
                }
                
            }
        }//vstack
        .navigationBarTitle("MY ADS", displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
        
    }
}

struct MyAdCell: View {
    let item: AdDetail
    @State var eventDeatil: EventDetail?
    @State var showAddDetail = false
    
    
    var body: some View {
        
        VStack {
            switch item.adType {
            case .pictureVideo:
                AdImageVideoCell(imageStr: item.image)
            case .event:
                if let event = eventDeatil {
                    EventCell(event: event, showArrow: true)
                }
            case .podcast:
                PromotionCell(imageStr: item.image, heightF: 1.8)
            }
            
            //Title4(title: C.StaticText.loremText, fWeight: .semibold)
            SubHeader5(title: C.StaticText.loremText)
                .padding(.horizontal, 15)
            Divider().padding(.horizontal)
            
            HStack {
                if item.status != .inprogress {
                    VStack(alignment: .leading) {
                        Title4(title: "Duration: \(item.duration ?? "NA")")
                        Title4(title: "Start date: \(item.startDate ?? "NA")")
                        Title4(title: "Time: \(item.time ?? "NA")")
                        Title4(title: "Cost: \(item.cost ?? "NA")")
                    }
                } else {
                    Button("Finish & publish ad"){
                        
                    }.tint(.red)
                }
                
                Spacer()
                BackgroundFlipBtn(title: "EDIT", fSize: 12, enabled: false, hPadding: 40, vPadding: 8) {
                    showAddDetail = true
                }.buttonStyle(PlainButtonStyle())
            }.padding()
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 2)
            NavigationLink(isActive: $showAddDetail) {
                CreateAdView(editForm: true)
            } label: {
                EmptyView()
            }
            
            
        }.padding(.top, 30)
            .onAppear {
                eventDeatil = EventDetail(isBanner: true, bannerImg: item.image, eventType: .retreat, title: item.title, location: "Madrid, Spain", time: "", days: "", cost: "", hostName: "", link: "", invitation: .accepted, date: "")
            }
    }
}

struct MyAdsView_Previews: PreviewProvider {
    static var previews: some View {
        MyAdsView()
    }
}
