//
//  MessageRequestListView.swift
//  spine
//
//  Created by Mac on 27/06/22.
//

import SwiftUI

enum MsgEventTab: String {
    case message = "MESSAGES"
    case eventReq = "EVENT REQUESTS"
    case feedback = "FEEDBACK"
}

struct MessageRequestListView: View {
    @Environment(\.dismiss) var dismiss
    @State var attendeeList: [Attendee] = []
    @State var selctTab: MsgEventTab = .message
    let width = UIScreen.main.bounds.width
    
    var body: some View {
        VStack(spacing: 0) {
            
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4).padding(.top, 10)
            VStack(spacing: 0) {
                
                HStack(spacing: 0) {
                    SegmentedBtnForMsg(title: MsgEventTab.message.rawValue,  selectedTab: $selctTab, new: true) {
                        selctTab = .message
                    }.frame(width: width/3.2 - 20)
                    
                    SegmentedBtnForMsg(title: MsgEventTab.eventReq.rawValue,  selectedTab: $selctTab) {
                        selctTab = .eventReq
                    }.frame(width: width/2.6 - 20)
                    
                    SegmentedBtnForMsg(title: MsgEventTab.feedback.rawValue,  selectedTab: $selctTab) {
                        selctTab = .feedback
                    }.frame(width: width/3.2 - 20)
                    
                }
                Divider().frame(width: width - 60)
            }
            Title4(title: "You have 1 new message")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
            
            List {
                ForEach(self.attendeeList, id: \.self) { attendee in
                    VStack {
                        switch selctTab {
                        case .message, .feedback:
                            ZStack(alignment: .leading) { //removed arrow from navlink
                                NavigationLink(
                                    destination: ChatListView(attendee: attendee)) {
                                        EmptyView()
                                    }.opacity(0)
                                MsgRow(attendee: attendee)
                            }
                        case .eventReq:
                            EventReqRow(attendee: attendee)
                        }

                        Divider().opacity(0.3)
                    }
                    .listRowSeparator(.hidden)
                }
            }.listStyle(.plain)
        }.onAppear(perform: {
            self.attendeeList = attendeeLst
        })
        
        .navigationBarTitle("MESSAGES", displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
    }
}

struct MessageRequestListView_Previews: PreviewProvider {
    static var previews: some View {
        MessageRequestListView()
    }
}


struct MsgRow: View {
    let attendee: Attendee
    @State var showProfile = false
    var body: some View {
        HStack {
            HStack {
                CircularBorderedProfileView(image: attendee.img, size: 44, borderWidth: 0, showShadow: false)
                    .onTapGesture {
                        showProfile = true
                    }
                
                VStack(alignment: .leading) {
                    Title4(title: attendee.name)
                    Title5(title: "Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum", fColor: .gray, lineLimit: 1)
                }.padding(.horizontal, 20)
                
                Spacer()
            }
            VStack {
                Title5(title: "2 May 2022", fColor: .gray)
                Text("\u{2022}").font(.title).foregroundColor(.red)
            }
            
        }
        .fullScreenCover(isPresented: $showProfile) {
            EmployeeProfileView(attendee: attendee)
        }
    }
}

struct EventReqRow: View {
    let attendee: Attendee
    @State var showProfile = false
    var body: some View {
        HStack {
            HStack {
                CircularBorderedProfileView(image: attendee.img, size: 44, borderWidth: 0, showShadow: false)
                    .onTapGesture {
                        showProfile = true
                    }
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading ,spacing: 0) {
                        Title4(title: "\(attendee.name) requests to ")
                        Title4(title: "join your event")
                    }
                    //.multilineTextAlignment(.leading)
                    // .lineLimit(2)
                    
                    VStack(alignment: .leading) {
                        Header6(title: "Online Meditation", fColor: .gray)
                        Header6(title: "9 May 2022. 20:00", fColor: .gray)
                    }
                    
                }.padding(.horizontal, 20)
                
                Spacer()
            }
            
            HStack(spacing: 20) {
                
                Button { } label: {
                    Image(systemName: ImageName.multiply)
                }.buttonStyle(.plain)
                
                Button { } label: {
                    Image(systemName: ImageName.checkmark)
                }.buttonStyle(.plain)
                
            }.foregroundColor(.lightBrown)
            
        }
        .fullScreenCover(isPresented: $showProfile) {
            EmployeeProfileView(attendee: attendee)
        }
    }
}


struct SegmentedBtnForMsg: View {
    let title: String
    @Binding var selectedTab: MsgEventTab
    var new: Bool = false
    var onTapped: ()-> Void
    var body: some View {
        VStack(spacing: 10) {
            Button {
                onTapped()
            } label: {
                
                HStack(spacing: 0) {
                    Text(title)
                        .font(.Poppins(type: .regular, size: 12))
                        .padding(.top, 20)
                        .foregroundColor(selectedTab.rawValue == title ? .primary : .gray)
                    if new {
                        Text("\u{2022}").font(.title).foregroundColor(.red)
                    }
                    
                }
            }
            Rectangle().frame(height: 2.0, alignment: .top)
                .foregroundColor(K.appColors.appTheme).opacity(selectedTab.rawValue == title ? 1.0 : 0.0)
        }
        
    }
}
