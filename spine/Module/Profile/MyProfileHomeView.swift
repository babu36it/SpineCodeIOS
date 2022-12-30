//
//  MyProfileHomeView.swift
//  spine
//
//  Created by Mac on 26/06/22.
//

import SwiftUI

enum MyProfileTab: String {
    case posts = "POSTS"
    case events = "EVENTS"
    case podcasts = "PODS"
    case bookmark = "ABOUT"
}

enum FollowTab: String {
    case followers = "FOLLOWERS"
    case following = "FOLLOWING"
}

enum screenType {
    case messageList
    //case followerList
    case myProfile
    case settings
}

struct MyProfileHomeView: View {
    @Environment(\.dismiss) var dismiss
    let screenWidth = UIScreen.main.bounds.size.width
    let imgH: CGFloat = 230
    let padding: CGFloat = 5
    @State var selectedTab: MyProfileTab = .posts
   // @State var selectedList: FollowTab = .followers
   // @State var showMsgs = false
    @State var showAdd = false
    @State var screenType: screenType? = nil
    @State var postsSection: [SectionDetail] = []
    @State var eventList = [EventDetail]()
    @State var podcastList = [EventDetail]()
    
    @StateObject var postsListVM: PostListViewModel = .init()
    @StateObject var eventsListVM: ProfileEventListViewModel = .init()
    @StateObject var podcastsListVM: PodcastListViewModel = .init()

    let userInfoModel: SignInResponseModel? = AppUtility.shared.userInfo
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    ZStack {
                        LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)
//                            .padding(.vertical, 5)
                        if let userImage: String = userInfoModel?.data?.userImage, let userImagePath: String = userInfoModel?.imagePath, !userImage.isEmpty, !userImagePath.isEmpty {
                            RemoteImage(imageDownloader: DefaultImageDownloader(imagePath: "\(userImagePath)\(userImage)"))
                                .profileImage(radius: 100, borderWidth: 3)
                        } else {
                            CircularBorderedProfileView(image: "Oval 57", size: 100, borderWidth: 3, showShadow: true)
                        }
                    }
                    .offset(y: -30)
                    
                    HStack(spacing: 60) {
                        NavigationLink(destination: FollowerListView(followerListVM: UserProfileFollowerListViewModel(tab: .followers))) {
                            FollowBtn(title: "Followers", desc: userInfoModel?.followersCount ?? "")
                        }
                        Button("VIEW FROFILE"){
                            screenType = .myProfile
                        }
                        .foregroundColor(.gray)
                        .font(.Poppins(type: .regular, size: 14))
                        
                        NavigationLink(destination: FollowerListView(followerListVM: UserProfileFollowerListViewModel(tab: .following))) {
                            FollowBtn(title: "Following", desc: userInfoModel?.followingCount ?? "")
                        }
                    }
                    Divider()
                        .padding(.vertical, 20)
                        .padding(.horizontal, 30)
                    
                    VStack(spacing: 0) {
                        HStack {
                            SegmentedBtn(title: MyProfileTab.posts.rawValue, selectedTab: $selectedTab) {
                                selectedTab = .posts
                            }
                            SegmentedBtn(title: MyProfileTab.events.rawValue, selectedTab: $selectedTab) {
                                selectedTab = .events
                            }
                            SegmentedBtn(title: MyProfileTab.podcasts.rawValue, selectedTab: $selectedTab) {
                                selectedTab = .podcasts
                            }
                            Spacer()
                            SegmentedBtn(title: MyProfileTab.bookmark.rawValue, img:"ic_bookmark", selectedTab: $selectedTab) {
                                selectedTab = .bookmark
                                
                            }.offset(y: 8)
                        }
                        .padding(.horizontal, 5)
                        .animation(.default, value: selectedTab)
                        
                        LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)
                    }
                    
                    NavigationLink(destination: MessageRequestListView(), tag: .messageList, selection: $screenType) { EmptyView() }
                    NavigationLink(destination: MyPublicProfileView(), tag: .myProfile, selection: $screenType) { EmptyView() }
                    NavigationLink(destination: SettingsListView(), tag: .settings, selection: $screenType) { EmptyView() }
                    
                    switch selectedTab {
                    case .posts:
                        PostList(postsSection: postsSection)
                            .environmentObject(postsListVM)
                    case .events:
                        ProfileEventListView()
                            .environmentObject(eventsListVM)
                    case .podcasts:
                        PodcastList(podcasts: podcastList)
                            .environmentObject(podcastsListVM)
                    case .bookmark:
                        BookmarkList(events: [event1])
                    }
                } //vstack
                VStack {
                    Spacer()
                    CustomAddItemSheet(dismisser: $showAdd).offset(y: self.showAdd ? 0: UIScreen.main.bounds.height)
                }
                .background((self.showAdd ? Color.black.opacity(0.3) : Color.clear).onTapGesture {
                    self.showAdd.toggle()
                })
                .edgesIgnoringSafeArea(.all)
            } //zstack
            .animation(.default, value: showAdd)
            .onAppear(perform: {
                postsSection = getPosts()
                eventList = [event4, event8, event9]
                podcastList = [event8, event4]
            })
            //.ignoresSafeArea(.all)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                self.showAdd.toggle()
            }){
                Image(systemName: ImageName.plus)
            }).tint(.primary)
            .navigationBarItems(trailing: Button(action : {
                screenType = .settings
            }){
                Image(systemName: ImageName.gearshape)
            }).tint(.primary)
            .navigationBarItems(trailing: Button(action : {
              //  showMsgs = true
                screenType = .messageList
            }){
                Image(systemName: ImageName.envelopeBadge)
            }).tint(.primary)
            .navigationBarItems(trailing: Button(action : {
                //self.dismiss()
            }){
                Image(systemName: ImageName.shift)
            }).tint(.primary)
        }
        .navigationViewStyle(StackNavigationViewStyle())
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

struct MyProfileHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileHomeView()
    }
}

struct FollowBtn: View {
    let title: String
    let desc: String
    
    var body: some View {
        ZStack(alignment: .top) {
            Title5(title: title, fColor: .gray)
            Title4(title: desc)
                .offset(y: -20)
        }
//        .padding(.top, 20)
    }
}

struct FollowBtnV: View {
    let title: String
    var body: some View {
        VStack(spacing: 2) {
            Title4(title: "4k")
            Title5(title: title, fColor: .gray)
        }//.padding(.top, 20)
    }
}

struct SegmentedBtn: View {
    let title: String
    var img: String = ""
    @Binding var selectedTab: MyProfileTab
    var count: Int?
    var onTapped: ()-> Void
    var body: some View {
            VStack(spacing: 10) {
                Button {
                    onTapped()
                } label: {
                    VStack {
                        if img != "" {
                            Image(img)
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 16, height: 20)
                        } else if title != "" {
                            let countstr = count != nil ? " (\(count!))" : ""
                            Title4(title: title + countstr)
                                .padding(.top, 20)
                        }
                    }
                    .foregroundColor(selectedTab.rawValue == title ? .primary : .gray)
                }
                Rectangle()
                    .frame(height: 4.0, alignment: .top)
                    .foregroundColor(K.appColors.appTheme)
                    .opacity(selectedTab.rawValue == title ? 1.0 : 0.0)
            }
            .frame(width:80)
    }
}
