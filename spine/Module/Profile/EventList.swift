//
//  EventList.swift
//  spine
//
//  Created by Mac on 29/06/22.
//

import SwiftUI

struct EventList: View {
    let events: [EventDetail]
    
    var body: some View {
        ScrollView {
            if events.isEmpty {
                EmptyItemView(title: "own events")
            } else {
                LazyVStack {
                    ForEach(events, id: \.self) { event in
                        EventCell(event: event)
                    }
                }
            }
        }
    }
}

struct EventCell: View {
    let event: EventDetail
    var image: UIImage?
    var link: String?
    var showArrow = true
    var heightF = 1.8
    let screenWidth = UIScreen.main.bounds.size.width
    var body: some View {
        ZStack(alignment: .bottom) {
            if let image = image {
                BannerImageDataView(imageData: image, width: screenWidth, height: screenWidth/heightF)
            } else {
                BannerImageStringView(imageStr: event.bannerImg, width: screenWidth, height: screenWidth/heightF)
            }
            
            VStack {
                DateBadge(date: Date()).padding()
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Spacer()
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 2) {
                        if event.eventType == .online {
                            BadgeLabel(title: "ONLINE")
                        }
                        
                        Header3(title: event.title, fColor: .white)
                            .frame(width: 250, alignment: .leading)
                        HStack {
                            if event.eventType == .online {
                                HStack {
                                    Image(systemName: ImageName.mic)
                                    Title4(title: "En | 18:00, 2 hrs", fColor: .white)
                                }
                            } else {
                                HStack {
                                    Image("Location_Pin_small")
                                        //.resizable()
                                        .renderingMode(.template)
                                        //.frame(width: 10, height: 14)
                                        .foregroundColor(.white)
                                    
                                    Title4(title: "\(event.location) | 2 days", fColor: .white)
                                }
                                
                            }
                            
                            Spacer()
                        }//.frame(width: 300)
                    }.padding(.leading, 20)
                    Spacer()
                    if showArrow {
                        VStack {
                            Spacer()
                            if let urlStr = link, let url = URL(string: urlStr) {
                                Link(destination: url, label: {
                                    Image(systemName: ImageName.arrowUpRight).foregroundColor(.white).font(.title2)
                                }).padding(.trailing, 20)
                            } else {
                                ButtonWithSystemImage(image: ImageName.arrowUpRight, size: 15, fColor: .white) {
                                    print("tapped")
                                }.padding(.trailing, 20)
                            }
                        }
                    }
                }.padding(.bottom, 20)
            }
        }.frame(height: UIScreen.main.bounds.size.width/heightF)
        
    }
}

struct EmptyItemView: View {
    let title: String
    var body: some View {
        Title4(title: "This is where you will see your \(title)", fColor: .gray)
            .padding(.vertical, 30)
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
