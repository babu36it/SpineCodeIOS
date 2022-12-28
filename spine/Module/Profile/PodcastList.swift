//
//  PodcastList.swift
//  spine
//
//  Created by Mac on 29/06/22.
//

import SwiftUI

struct PodcastList: View {
    @EnvironmentObject var podcastListVM: PodcastListViewModel

    let podcasts: [EventDetail]
    
    var body: some View {
        ScrollView {
            if let podcastItems = podcastListVM.podcasts, !podcastItems.isEmpty {
                LazyVStack {
                    ForEach(podcastItems) { podcast in
                        PodcastItemView(podcast: podcast)
                    }
                }
            } else {
                EmptyItemView(title: "own podcasts")
            }
        }
        .onAppear {
            podcastListVM.getPodcasts()
        }
    }
}

struct PodcastItemView: View {
    let podcast: PodcastDetail
    
    var arrow = true
    let screenWidth = UIScreen.main.bounds.size.width

    var body: some View {
        ZStack(alignment: .bottom) {
            RemoteImage(imageDownloader: DefaultImageDownloader(imagePath: podcast.rssDetail.image))
                .frame(width: screenWidth, height: screenWidth/1.5)
            
            VStack {
                HStack(spacing: 15) {
                    Spacer()
                    if arrow {
                        ButtonWithCustomImage2(image: "directArrow", size: 18, fColor: .white) { }
                    }
                    
                    ButtonWithSystemImage(image: "headphones", size: 18, fColor: .white) { }
                }
                .padding()
                
                Spacer()
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: ImageName.mic)
                                .foregroundColor(.white)
                            let languageCode = Locale(identifier: podcast.rssDetail.language).languageCode ?? podcast.rssDetail.language
                            Header5(title: languageCode.uppercased(), fColor: .white)
                        }
                        Header3(title: podcast.rssDetail.title, fColor: .white)
                            .frame(width: 250, alignment: .leading)
                    }
                    
                    Spacer()
                    Image(systemName: ImageName.playCircle)
                        .font(.title)
                        .foregroundColor(.white)
                    
                }
                .padding()
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

