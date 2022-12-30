//
//  FollowerListView.swift
//  spine
//
//  Created by Mac on 27/06/22.
//

import SwiftUI

struct FollowerListView: View {
    @Environment(\.dismiss) var dismiss

    @StateObject var followerListVM: UserProfileFollowerListViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4).padding(.top, 10)
            VStack(spacing: 0) {
                
                HStack(spacing: 0) {
                    SegmentedBtnForFollow(title: FollowTab.followers.rawValue, selectedTab: $followerListVM.selectedTab, count: "3k") {
                        followerListVM.selectedTab = .followers
                        followerListVM.searchTxt = ""
                    }
                    .frame(width:150)
                    
                    SegmentedBtnForFollow(title: FollowTab.following.rawValue, selectedTab: $followerListVM.selectedTab, count: "163") {
                        followerListVM.selectedTab = .followers
                        followerListVM.searchTxt = ""
                    }
                    .frame(width:150)
                }
                Divider().frame(width: 300)
            }
            
            VStack(spacing: 10) {
                HStack{
                    Image(systemName: ImageName.magnifyingglass)
                        .foregroundColor(.gray).opacity(0.6)
                    TextField("Search", text: $followerListVM.searchTxt)
                }
                .padding(.horizontal, 30)
                Divider()
            }
            .padding(.vertical, 20)
            
            if let followers = followerListVM.followers {
                List {
                    ForEach(followers) { follower in
                        VStack {
                            FollowerItemRow(follower: follower)
                                .environmentObject(followerListVM)
                            Divider()
                                .opacity(0.3)
                        }
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
            }
        }
        .onAppear {
            if let userId: String = AppUtility.shared.userInfo?.data?.usersId {
                followerListVM.getFollowers(forUser: userId)
            }
        }
        .navigationBarTitle("OLIVER REESE", displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
    }
}

struct FollowerListView_Previews: PreviewProvider {
    static var previews: some View {
        FollowerListView(followerListVM: UserProfileFollowerListViewModel(tab: .followers))
    }
}

struct FollowerItemRow: View {
    @EnvironmentObject var followerListVM: UserProfileFollowerListViewModel
    let follower: FollowerItem
    
    @State var showProfile = false
    
    var body: some View {
        HStack {
            HStack {
                if let imagePath = follower.userImage(forPath: followerListVM.userImagePath) {
                    RemoteImage(imageDownloader: DefaultImageDownloader(imagePath: imagePath))
                        .profileImage(radius: 44)
                } else {
                    CircularBorderedProfileView(image: "Oval 57", size: 44, borderWidth: 0, showShadow: false)
                }
                
                VStack(alignment: .leading) {
                    if let userDisplayName: String = follower.userDisplayName {
                        Title4(title: userDisplayName)
                    }
                    if let bio = follower.bio {
                        Title5(title: bio, fColor: .gray)
                    }
                }
                .padding(.leading, 20)
                
                Spacer()
            }
            .onTapGesture {
                showProfile = true
            }
            BackgroundFlipBtn(title: follower.isFollowing ? "UNFOLLOW" : "+ FOLLOW", fSize: 12, enabled: !follower.isFollowing, vPadding: 8) {
                print("Tapped")
            }
            .buttonStyle(PlainButtonStyle())
        }
        .fullScreenCover(isPresented: $showProfile) {
//            EmployeeProfileView(attendee: attendee)
        }
    }
}

struct FollowerRow: View {
    let attendee: Attendee
    @State var showProfile = false
    var body: some View {
        HStack {
            HStack {
                CircularBorderedProfileView(image: attendee.img, size: 44, borderWidth: 0, showShadow: false)
                
                VStack(alignment: .leading) {
                    Title4(title: attendee.name)
                    Title5(title: "Lorem Ipsum", fColor: .gray)
                }.padding(.leading, 20)
                
                Spacer()
            }.onTapGesture {
                showProfile = true
            }
            
            /*LargeButton(title: attendee.msgEn ? "UNFOLLOW" : "+ FOLLOW", width: 100, height: 35, bColor: attendee.msgEn ? .white : .lightBrown, fSize: 12, fColor: attendee.msgEn ? .lightBrown: .white, font: "Roman") {

            }.buttonStyle(PlainButtonStyle()) */
            BackgroundFlipBtn(title: attendee.msgEn ? "UNFOLLOW" : "+ FOLLOW", fSize: 12, enabled: !attendee.msgEn, vPadding: 8) {
                print("Tapped")
            }.buttonStyle(PlainButtonStyle())
            
        }
        .fullScreenCover(isPresented: $showProfile) {
            EmployeeProfileView(attendee: attendee)
        }
    }
}

struct SegmentedBtnForFollow: View {
    let title: String
    @Binding var selectedTab: FollowTab
    let count: String
    var onTapped: ()-> Void
    var body: some View {
        VStack(spacing: 10) {
            Button {
                onTapped()
            } label: {
                Text("\(count) \(title)")
                    .font(.Poppins(type: .regular, size: 12))
                    .padding(.top, 20)
                    .foregroundColor(selectedTab.rawValue == title ? .primary : .gray)
            }
            Rectangle().frame(height: 2.0, alignment: .top)
                .foregroundColor(K.appColors.appTheme).opacity(selectedTab.rawValue == title ? 1.0 : 0.0)
        }
    }
}
