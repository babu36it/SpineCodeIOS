//
//  MyPublicProfileView.swift
//  spine
//
//  Created by Mac on 28/06/22.
//

import SwiftUI


struct MyPublicProfileView: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let imageSize: CGFloat = 120
    @Environment(\.dismiss) var dismiss
    @State var showMoreAction = false
    @State var editProfileTapped = false
    @State var selectedTab: MyProfileTab = .posts
    @State var postsSection: [SectionDetail] = []
    @State var eventList = [EventDetail]()
    @State var podcastList = [EventDetail]()
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .bottom) {
                Image(ImageName.podcastDetailBanner)
                    .resizable()
                    .frame(width: screenWidth, height: screenWidth/1.7)
                CircularBorderedProfileView(image: "Oval 57", size: imageSize, borderWidth: 5)
                    .offset(y: 60)
            }
            
            HStack {
                NavigationLink(destination: FollowerListView(selectedTab: .followers)) {
                    FollowBtnV(title: "Followers")
                }
                Spacer()
                NavigationLink(destination: FollowerListView(selectedTab: .following)) {
                    FollowBtnV(title: "Following")
                }
            }.padding(.vertical, 15).padding(.horizontal, 30)
            
            VStack {
                Text("Karin Kraushar")
                    .font(.Poppins(type: .Bold, size: 17))
                
                Text("Life is a game, play it wisely")
                    .font(.Poppins(type: .regular, size: 13))
                    .foregroundColor(.gray)
                    .frame(width: 400)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            
            
            BackgroundFlipBtn(title: "EDIT PROFILE", enabled: false, hPadding: 30, vPadding: 8) {
                editProfileTapped.toggle()
            }.padding(10)
            
            Divider().padding(.vertical, 5).padding(.horizontal, 30)
            
            VStack(spacing: 0) {
                HStack {
                    SegmentedBtn(title: MyProfileTab.posts.rawValue, selectedTab: $selectedTab, count: 5) {
                        selectedTab = .posts
                    }
                    SegmentedBtn(title: MyProfileTab.events.rawValue, selectedTab: $selectedTab, count: 4) {
                        selectedTab = .events
                    }
                    SegmentedBtn(title: MyProfileTab.podcasts.rawValue, selectedTab: $selectedTab, count: 3) {
                        selectedTab = .podcasts
                    }
                    Spacer()
                    SegmentedBtn(title: MyProfileTab.bookmark.rawValue, img:"ic_bookmark", selectedTab: $selectedTab) {
                        selectedTab = .bookmark
                        
                    }.offset(y: 8)
                }.padding(.horizontal, 5)
                .animation(.default, value: selectedTab)
                
                LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)
            }
            switch selectedTab {
            case .posts:
                PostList(postsSection: postsSection)
            case .events:
                EventList(events: eventList)
            case .podcasts:
                PodcastList(podcasts: podcastList)
            case .bookmark:
                BookmarkList(events: [event1])
            }
            
           // Spacer()
        }.edgesIgnoringSafeArea(.top)
            .onAppear(perform: {
                postsSection = getPosts()
                eventList = [event4, event8, event9]
                podcastList = [event8, event4]
            })
            .fullScreenCover(isPresented: $editProfileTapped){
                EditProfileView()
            }
            .confirmationDialog("", isPresented: $showMoreAction, actions: {
                Button("Follow"){ }
                Button("Report Post"){ }
            })
            .modifier(BackButtonModifier(fColor: .white, action: {
                self.dismiss()
            }))
            .navigationBarItems(trailing: Button(action : {
                print("More")
                showMoreAction = true
            }){
                NavBarButtonImage(image: "More")
            })
            .navigationBarItems(trailing: Button(action : {
                print("Share")
            }){
                NavBarButtonImage(image: "directArrow")
            })
    }
    
    func getPosts()-> [SectionDetail] {
        var item = [SectionDetail]()
        let textPosts = posts.filter{$0.postType == .text}
        let videoImgPosts = posts.filter{$0.postType != .text}
        let videoImg3Posts = videoImgPosts.chunked(into: 3)
        for post3 in videoImg3Posts {
            item.append(SectionDetail(title: .video, items: post3))
        }
        for textPost in textPosts {
            item.append(SectionDetail(title: .text, items: [textPost]))
        }
        return item
    }
}

struct MyPublicProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MyPublicProfileView()
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    let width: CGFloat
    let fsize: CGFloat
    var fcolor: Color = .lightBrown
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: width)
            .padding(5)
            .font(.Poppins(type: .regular, size: fsize))
            .foregroundColor(configuration.isPressed ? fcolor.opacity(0.5) : fcolor)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(configuration.isPressed ? fcolor.opacity(0.5) : fcolor, lineWidth: 1.0)
            )
     }
}


