//
//  EmployeeProfileView.swift
//  spine
//
//  Created by Mac on 30/06/22.
//

import SwiftUI

enum ProfileType {
    case personal    // someones personal profie
    case practitioner  // someones practitioner profie
}


struct EmployeeProfileView: View {
    let attendee: Attendee
    let screenWidth = UIScreen.main.bounds.size.width
    let imageSize: CGFloat = 120
    @Environment(\.dismiss) var dismiss
    @State var showMoreAction = false
    @State var selectedTab: MyProfileTab = .posts
    @State var postsSection: [SectionDetail] = []
    @State var eventList = [EventDetail]()
    @State var podcastList = [EventDetail]()
    @State var showSheet = false
    
    @State var showMsgView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    ZStack(alignment: .bottom) {
                        Image(ImageName.podcastDetailBanner)
                            .resizable()
                            .frame(width: screenWidth, height: screenWidth/1.7)
                        CircularBorderedProfileView(image: attendee.img, size: imageSize, borderWidth: 5)
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
                        Text(attendee.name)
                            .font(.Poppins(type: .Bold, size: 17))
                        
                        Text("Life is a game, play it wisely")
                            .font(.Poppins(type: .regular, size: 13))
                            .foregroundColor(.gray)
                            .frame(width: 400)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                    }
                    
                    if attendee.type == .personal {
                        HStack {
                            BackgroundFlipBtn(title: "+ FOLLOW", enabled: true, hPadding: 20, vPadding: 5) { }
                            BackgroundFlipBtn(title: "MESSAGE", enabled: true, hPadding: 20, vPadding: 5) {
                                showMsgView.toggle()
                            }
                            BackgroundFlipBtn(title: "DONATE", enabled: true, hPadding: 20, vPadding: 5) { }
                        }.padding(10)
                    }
                    
                    if attendee.type == .practitioner {
                        HStack {
                            BackgroundFlipBtn(title: "+ FOLLOW", fSize: 12, enabled: true, hPadding: 10) { }
                            BackgroundFlipBtn(title: "MESSAGE", fSize: 12, enabled: true, hPadding: 10) {
                                showMsgView.toggle()
                            }
                            BackgroundFlipBtn(title: "BUSINESS", fSize: 12, enabled: true, hPadding: 10) { }
                            BackgroundFlipBtn(title: "DONATE", fSize: 12, enabled: true, hPadding: 10) { }
                        }.padding(10)
                    }
                    
                    
                    Divider().padding(.vertical, 5).padding(.horizontal, 30)
                    
                    VStack(spacing: 0) {
                        HStack {
                            SegmentedBtn(title: MyProfileTab.posts.rawValue, selectedTab: $selectedTab, count: 4) {
                                selectedTab = .posts
                            }
                            SegmentedBtn(title: MyProfileTab.events.rawValue, selectedTab: $selectedTab, count: 3) {
                                selectedTab = .events
                            }
                            SegmentedBtn(title: MyProfileTab.podcasts.rawValue, selectedTab: $selectedTab, count: 1) {
                                selectedTab = .podcasts
                            }
                            Spacer()
                            if attendee.type == .practitioner {
                                SegmentedBtn(title: MyProfileTab.bookmark.rawValue, selectedTab: $selectedTab) {
                                    selectedTab = .bookmark
                                }
                            }
                            
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
                        AboutProfileView()
                    }
                    
                    
                } //vstack
                if showMsgView {
                    SendMessageAlert(showAdd: $showMsgView)
                }
            } //zstack
            .edgesIgnoringSafeArea(.all)
            .onAppear(perform: {
                postsSection = getPosts()
                eventList = [event4, event8, event9]
                podcastList = [event8, event4]
            })
            .confirmationDialog("", isPresented: $showMoreAction, actions: {
                Button("Share profile"){ }
                Button("Block user"){ }
                Button("Report user") {
                    showSheet = true
                }
            })
            .adaptiveSheet(isPresented: $showSheet, detents: [.medium()], smallestUndimmedDetentIdentifier: .large) {
                ReportingUserMainView(showSheet: $showSheet)
               // TestView()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                self.dismiss()
            }){
                Image(systemName: ImageName.chevronLeft)
                    .foregroundColor(.white)
            })
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
        } //nav
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

struct EmployeeProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeProfileView(attendee: Attendee(name: "Prashanth kumar", type: .personal, img: "", msgEn: true))
    }
}
