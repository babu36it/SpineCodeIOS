//
//  PodcastList.swift
//  spine
//
//  Created by Mac on 29/06/22.
//

import SwiftUI

struct PodcastList: View {
    let podcasts: [EventDetail]
    
    var body: some View {
        ScrollView {
            if podcasts.isEmpty {
                EmptyItemView(title: "own podcasts")
            } else {
                LazyVStack {
                    ForEach(podcasts, id: \.self) { podcast in
                        PodcastCell(podcast: podcast)
                    }
                }
            }
        }
    }
}

struct PodcastCell: View {
    let podcast: EventDetail
    var arrow = true
    var body: some View {
        ZStack(alignment: .bottom) {
            BannerImageView(image: podcast.bannerImg, heightF: 1.5)
            VStack {
                HStack(spacing: 15) {
                    Spacer()
                    if arrow {
                        ButtonWithCustomImage2(image: "directArrow", size: 18, fColor: .white) { }
                    }
                    
                    ButtonWithSystemImage(image: "headphones", size: 18, fColor: .white){
                    }
                }.padding()
                
                Spacer()
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: ImageName.mic)
                            Header5(title: "En | 18:00, 2 hrs", fColor: .white)
                        }
                        Header3(title: podcast.title, fColor: .white)
                            .frame(width: 250, alignment: .leading)
                    }
                    
                    Spacer()
                    Image(systemName: ImageName.playCircle)
                        .font(.title)
                        .foregroundColor(.white)
                    
                }.padding()
            }
        }
        
    }
}

