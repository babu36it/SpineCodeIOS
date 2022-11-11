//
//  FollowerListView.swift
//  spine
//
//  Created by Mac on 27/06/22.
//

import SwiftUI

struct FollowerListView: View {
    let selectedTab: FollowTab
    @Environment(\.dismiss) var dismiss
    @State var attendeeList: [Attendee] = []
    @State var filterdAttendeeList: [Attendee] = []
    @State var searchTxt = ""
    @State var selctTab: FollowTab = .followers
    
    var body: some View {
        VStack(spacing: 0) {
            
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4).padding(.top, 10)
            VStack(spacing: 0) {
                
                HStack(spacing: 0) {
                    SegmentedBtnForFollow(title: FollowTab.followers.rawValue,  selectedTab: $selctTab, count: "3k") {
                        selctTab = .followers
                        searchTxt = ""
                        self.filterdAttendeeList = self.attendeeList
                    }.frame(width:150)
                    
                    SegmentedBtnForFollow(title: FollowTab.following.rawValue,  selectedTab: $selctTab, count: "163") {
                        selctTab = .following
                        searchTxt = ""
                        self.filterdAttendeeList = self.attendeeList.filter{$0.msgEn == true}
                    }.frame(width:150)
                }
                Divider().frame(width: 300)
            }
            
            VStack(spacing: 10) {
                HStack{
                    Image(systemName: ImageName.magnifyingglass)
                        .foregroundColor(.gray).opacity(0.6)
                    TextField("Search", text: $searchTxt)
                }.padding(.horizontal, 30)
                Divider()
            }.padding(.vertical, 20)
            
            List {
                ForEach(self.filterdAttendeeList, id: \.self) { attendee in
                    VStack {
                        FollowerRow(attendee: attendee)
                        Divider().opacity(0.3)
                    }
                    .listRowSeparator(.hidden)
                }
            }.listStyle(.plain)
        }.onAppear(perform: {
            self.attendeeList = attendeeLst.sorted{$0.name.uppercased() < $1.name.uppercased()}
            self.filterdAttendeeList = attendeeList
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                selctTab = selectedTab
                self.filterdAttendeeList = selctTab == .followers ? self.attendeeList : self.attendeeList.filter{$0.msgEn == true}
            }
            
        })
        .onChange(of: searchTxt, perform: { newTxt in
            performSearchFor(text: newTxt)
        })
        .navigationBarTitle("OLIVER REESE", displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
    }
    
    func performSearchFor(text: String) {
        if text.isEmpty {
            self.filterdAttendeeList = selctTab == .followers ? self.attendeeList : self.attendeeList.filter{$0.msgEn == true}
        } else {
            self.filterdAttendeeList = self.filterdAttendeeList.filter {$0.name.uppercased().contains(text.uppercased())}
        }
    }
}

struct FollowerListView_Previews: PreviewProvider {
    static var previews: some View {
        FollowerListView(selectedTab: .followers)
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
