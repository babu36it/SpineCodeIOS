//
//  ReviewPodcastView.swift
//  spine
//
//  Created by Mac on 01/06/22.
//

import SwiftUI

struct ReviewPodcastView: View {
    @EnvironmentObject var podcastInfoVM: PodcastInfoViewModel
    let screenWidth = UIScreen.main.bounds.size.width
    let imageSize: CGFloat = 120
    @Environment(\.dismiss) var dismiss
    //@State var showConfirm = false
    let heightRatio: CGFloat = 1.7
    
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                VStack(spacing: 0) {
                    CustomAsyncImage(urlStr: podcastInfoVM.rssData?.feed.image ?? "", width: screenWidth, height: screenWidth/heightRatio)
                    ZStack {
                        Text("")
                            .frame(width: screenWidth, height: screenWidth/2.5)
                            .background(Color.lightBrown)
                        VStack(alignment: .leading, spacing: 10) {
                            Header5(title: podcastInfoVM.rssData?.feed.author ?? "NA", fColor: .white, lineLimit: 1)
                            Header2(title: podcastInfoVM.rssData?.feed.title ?? "NA", fColor: .white, lineLimit: 2)
                            HStack {
                                Header5(title: "\(podcastInfoVM.rssData?.items.count ?? 0) Episodes", fColor: .white, lineLimit: 1)
                                Spacer()
                            }
                        }.padding(20)
                        //  .background(Color.lightBrown)
                    }
                }
                
               // CircularBorderedProfileView(image: "Oval 57", size: imageSize, borderWidth: 5)
                CircularBorderedProfileView1(imageUrl: podcastInfoVM.rssData?.user?.user_image ?? "", size: imageSize, borderWidth: 5)
                    .offset(y: screenWidth/heightRatio - (imageSize - 20))
            }
            
            PodcastReviewDetailList().environmentObject(podcastInfoVM)
        }.modifier(LoadingView(isLoading: $podcastInfoVM.showLoader))
        //.edgesIgnoringSafeArea(.all)
        .fullScreenCover(isPresented: $podcastInfoVM.showConfirm, content: {
            PodcastConfirmationView()
        })
        .navigationTitle("REVIEW PODCAST")
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
        .navigationBarItems(trailing: LargeButton(title: "SUBMIT", width: 60, height: 22, bColor: Color.lightBrown, fSize: 12, fColor: .white) {
            //showConfirm = true
            self.podcastInfoVM.submitPodcast()
        }//.opacity(0.3).disabled(true)
        )
    }
}

struct PodcastReviewDetailList: View {
    @EnvironmentObject var podcastInfoVM: PodcastInfoViewModel
    var body: some View {
        List {
            Divider().padding(.leading, 10)
                .listRowSeparator(.hidden)
            
            ForEach(podcastInfoVM.rssData?.items ?? []) { item in
                VStack {
                    ZStack {
                        PodcastDetailListRow1(item: item)
                        NavigationLink(destination: MusicPlayerView1(audioVM: AudioViewModel(urlStr: item.enclosure.link), mpModel: MusicPlayerModel(feed: podcastInfoVM.rssData?.feed, item: item, user: podcastInfoVM.rssData?.user))) {
                            EmptyView()
                        }.buttonStyle(PlainButtonStyle())
                            .opacity(0.0)
                    }
                    Divider().padding(.leading, 10)
                }.listRowSeparator(.hidden)
            }
        }//.edgesIgnoringSafeArea(.all)
        .padding(.leading, -20)
        //.padding(.bottom, 70) // fix- list hides below tab bar
        .listStyle(.plain)
    }
}

struct ReviewPodcastView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewPodcastView()
    }
}
