//
//  EventsHomeDetailView.swift
//  spine
//
//  Created by Mac on 22/06/22.
//

import SwiftUI

struct EventsHomeDetailView: View {
    let event: EventDetail
    let images: [UIImage]
    @State var images2: [UIImage] = [] //remove this, pass image from previous view
    @State var showMoreAction = false
    let screenWidth = UIScreen.main.bounds.size.width
    @Environment(\.dismiss) var dismiss
    @State var showConfirmation = false
    var todayDate = Date()
    let externalBooking = false
    @State var reserveSpot = false
    @State var isInviteSent = false
    @State var showMsg = false
    @State var disableBtn = false
    
    var body: some View {
        ZStack {
            ScrollView { //put it down
            VStack(spacing: 0) {
                ZStack(alignment: .bottomLeading) {
                    HorizontalImageScroller(images: images2)
                    DateBadge(date: todayDate).padding(20)
                }
               // ScrollView {
                    VStack(alignment: .leading, spacing: 14) {
                        PodcastTitle(title: event.eventType.getTitle().uppercased(), fSize: 12, linelimit: 1, fontWeight: .black, fColor: .white)
                        PodcastTitle(title: event.title, fSize: 20, linelimit: 2, fontWeight: .heavy, fColor: .white).padding(.trailing, 30)
                        HStack {
                            EventDetailPreviewRow(image: "Calender", title: "Sat, 09 May", subtitle: "18:00")
                            Text("-").foregroundColor(.white)
                            EventDetailPreviewRow(image: "", title: "Sat, 09 May", subtitle: "20:00", arrow: true)
                        }
                        EventDetailPreviewRow(image: "E_location", title: "Fortune House", subtitle: "134 Carstorphine Rd \u{2022} Madrid, Spain", arrow: true)
                        EventDetailPreviewRow(image: "E_Arrow_NE", title: "Website")
                        EventDetailPreviewRow(image: "E_mic", title: "Hosted in", subtitle: "German")
                    }.padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(Color.lightBrown)
                    //
                    AttendingListScrollView()
                    LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)
                    AboutEventTextView(msgTapped: {
                        self.showMsg = true
                    })
                    CommentSectionView()
                    LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)
                    
                    HStack {
                        Spacer()
                        if isInviteSent {
                            Header5(title: "You sent a request to join")
                                .padding(.trailing, 20)
                        } else {
                            if event.eventType == .online || event.eventType == .metaverse {
                                LargeButton(title: "REQUEST TO ATTEND ONLINE", width:200, height: 30, bColor: .lightBrown, fSize: 12, fColor: .white) {
                                    reserveSpot = true
                                }.padding(.trailing, 20)
                            } else if event.eventType == .retreat {
                                if externalBooking {
                                    LargeButton(title: "BOOK EVENT", width:140, height: 30, bColor: .lightBrown, fSize: 12, fColor: .white, img: "arrow.right") {
                                    }.padding(.trailing, 20)
                                } else {
                                    LargeButton(title: "RESERVE A SPOT", width:140, height: 30, bColor: .lightBrown, fSize: 12, fColor: .white) {
                                        reserveSpot = true
                                    }.padding(.trailing, 20)
                                }
                                
                            }
                        }
                    }.padding(.vertical, 5)
                    LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)
                }
                
               // Spacer()
            }.edgesIgnoringSafeArea(.top)
            customAlertView()
            if showMsg {
                SendMessageAlert(showAdd: $showMsg)
                //GoingYesNoView(showAdd: $showMsg)
                //GoingAlert(showAdd: $showMsg)
            }
            
        } //zstack
        .onChange(of: reserveSpot, perform: { newValue in
            disableBtn = newValue
        })
        .onChange(of: showMsg, perform: { newValue in
            disableBtn = newValue
        })
            .confirmationDialog("", isPresented: $showMoreAction, actions: {
                Button("Follow"){ }
                Button("Report Post"){ }
            })
            .onAppear(perform: {
                if let image1 = UIImage(named: "magic-bowls"), let image2 = UIImage(named: "ic_launch") {
                    images2 = [image2, image1]
                }
            })
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                self.dismiss()
            }){
                Image(systemName: ImageName.chevronLeft)
                    .foregroundColor(.white)
            }.disabled(disableBtn).opacity(disableBtn ? 0.3 : 1))
        
            .navigationBarItems(trailing: Button(action : {
                print("More")
                showMoreAction = true
            }){
                NavBarButtonImage(image: "More")
            }.disabled(disableBtn).opacity(disableBtn ? 0.3 : 1))
        
            .navigationBarItems(trailing: Button(action : {
                print("Share")
            }){
                NavBarButtonImage(image: "ic_bookmark", size: 22)
            }.disabled(disableBtn).opacity(disableBtn ? 0.3 : 1))
        
            .navigationBarItems(trailing: Button(action : {
                print("Share")
            }){
                NavBarButtonImage(image: "directArrow")
            }.disabled(disableBtn).opacity(disableBtn ? 0.3 : 1))
    }
    
    @ViewBuilder
    func customAlertView() -> some View {
        switch event.eventType {
        case .retreat:
             SendInvitationAlertView(showAdd: $reserveSpot, inviteSent: $isInviteSent)
        case .online, .metaverse:
            SendInvitationOnlineMeta(showAdd: $reserveSpot, inviteSent: $isInviteSent)
        case .local:
             EmptyView()
        }
    }
}

//struct EventsHomeDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventsHomeDetailView(event: event1, images: [])
//    }
//}

struct CustomAlert: View {
    @State var showAdd = false
    let screenWidth = UIScreen.main.bounds.width - 60
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Button("show"){
               showAdd = true
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            self.dismiss()
        }) {
            Image(systemName: ImageName.chevronLeft)
                .foregroundColor(.primary)
        }.disabled(showAdd))
    }
}

struct CustomAlert_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlert()
    }
}

struct AttendingListScrollView: View {
    @State var showAttendees = false
    var body: some View {
        VStack(alignment: .leading) {
            Title5(title: "12 people are going")
            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(0...10, id: \.self) { index in
                            CircularBorderedProfileView(image: "Oval 5", size: 40, borderWidth: 0, showShadow: false)
                        }
                    }
                }
                Button {
                    showAttendees = true
                } label: {
                    Image(systemName: ImageName.chevronLeft)
                        .foregroundColor(.gray)
                }

                NavigationLink("", isActive: $showAttendees) {
                    AttendeesListView()
                }
                
            }
            
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}

struct AboutEventTextView: View {
    @EnvironmentObject var addEventVM: AddEventViewModel
    @EnvironmentObject var eventModel: EventModel
    
    let msgTapped: ()-> Void
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 15) {
                if let imageServerPath: String = AppUtility.shared.userInfo?.imagePath, let userImage: String = eventModel.hostedProfilePic {
                    let imageURL = "\(imageServerPath)\(userImage)"
                    RemoteImage(imageDownloader: DefaultImageDownloader(imagePath: imageURL))
                        .circularBorder(radius: 100, borderWidth: 3, shadowRadius: 5)
                        .aspectRatio(contentMode: .fill)
                } else {
                    CircularBorderedProfileView(image: "Oval 57", size: 65, borderWidth: 3, showShadow: true)
                }
                
                VStack(alignment: .leading) {
                    Header5(title: eventModel.userName)
                    Title4(title: "HOST")
                }
                Spacer()
                LargeButton(title: "MESSAGE", width: 100, height: 30, bColor: .lightGray1, fSize: 14, fColor: .lightBrown) {
                    msgTapped()
                }
            }
            VStack(alignment: .leading, spacing: 10) {
                Title4(title: "ABOUT THE EVENT")
                Title4(title: eventModel.eventDescription)
                    .lineLimit(10)
                    .foregroundColor(.lightBlackText)
            }
        }
        .padding(20)
        .padding(.top, -10)
    }
}
