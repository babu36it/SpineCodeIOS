//
//  EventDetailPreviewView.swift
//  spine
//
//  Created by Mac on 16/06/22.
//

import SwiftUI

struct EventDetailPreviewView: View {
    let eventType: EventTypeModel
    let images: [UIImage]
    @State var showMoreAction = false
    let screenWidth = UIScreen.main.bounds.size.width
    @Environment(\.dismiss) var dismiss
    @State var showConfirmation = false
    var todayDate = Date()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ZStack(alignment: .bottomLeading) {
                    HorizontalImageScroller(images: images)
                    DateBadge(date: todayDate).padding(20)
                }
                ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    PodcastTitle(title: "ONLINE EVENT", fSize: 12, linelimit: 1, fontWeight: .black, fColor: .white)
                    PodcastTitle(title: "Sahaja Yoga online Meditation", fSize: 20, linelimit: 2, fontWeight: .heavy, fColor: .white).padding(.trailing, 30)
                    EventDetailPreviewRow(image: "Calender", title: "Sat, 09 May 2020", subtitle: "18:00-19:00 CEST", arrow: true)
                    EventDetailPreviewRow(image: "E_location", title: "Online", subtitle: "Link visible for attendees")
                    EventDetailPreviewRow(image: "E_Arrow_NE", title: "Website")
                    EventDetailPreviewRow(image: "E_mic", title: "Hosted in", subtitle: "German")
                }.padding(20)
                    .frame(maxWidth: .infinity)
                    .background(Color.lightBrown)
                    
                    AboutEventTextView(msgTapped: {
                        
                    })
                
                    ZStack {
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(height: 50)
                            .shadow(color: .lightGray1, radius: 5)
                        HStack {
                            Text("FREE")
                            Spacer()
                            LargeButton(disable: true, title: "REQUEST TO ATTEND ONLINE", width: 200, height: 30, bColor: .lightBrown, fSize: 12, fColor: .white) {
                                print("")
                            }
                        }.padding(.horizontal)
                    }
                    VStack(spacing: 20) {
                    
                    Text("Would you like to promote your post, click here")
                            .font(.Poppins(type: .regular, size: 14))
                        .underline()
                    HStack {
                        Button("EDIT"){
                            
                        }.foregroundColor(.lightBrown)
                        Spacer()
                        LargeButton(disable: false, title: "PUBLISH", width: 220, height: 30, bColor: .lightBrown, fSize: 12, fColor: .white) {
                            showConfirmation = true
                        }
                        
                    }
                }.padding()
            }
                //Spacer()
            }.edgesIgnoringSafeArea(.top)
                .confirmationDialog("", isPresented: $showMoreAction, actions: {
                    Button("Follow"){
                        
                    }
                    Button("Report Post"){
                        
                    }
                })
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button(action : {
                    self.dismiss()
                }){
                    NavBarButtonImage(image: "ic_close", size: 25)
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
                    NavBarButtonImage(image: "ic_bookmark", size: 22)
                })
                .navigationBarItems(trailing: Button(action : {
                    print("Share")
                }){
                    NavBarButtonImage(image: "directArrow")
                })
        }
        .fullScreenCover(isPresented: $showConfirmation, content: {
            EventConfirmationView()
        })
    }
}

//struct EventDetailPreviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventDetailPreviewView(eventType: .local, images: [])
//    }
//}


struct EventDetailPreviewRow: View {
    let image: String
    let title: String
    var subtitle: String = ""
    var arrow = false
    var body: some View {
        HStack {
            HStack(alignment: .top){
                if image != "" {
                Image(image)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                    .offset(y: 5)
                }
                    
                VStack(alignment: .leading) {
                    PodcastTitle(title: title, fSize: 14, linelimit: 1, fontWeight: .heavy, fColor: .white)
                    if subtitle != "" {
                        PodcastTitle(title: subtitle, fSize: 14, linelimit: 1, fontWeight: .thin, fColor: .white)
                    }
                }
            }
            if arrow {
                Spacer()
                Image(systemName: ImageName.chevronRight)
                    .foregroundColor(.white)
            }
            
        }
    }
}

struct DateBadge: View {
    let date: Date
    var body: some View {
        VStack {
            SubHeader6(title: "\(date.day)", fColor: .white)
            SubHeader6(title: "\(date.day)", fColor: .white)
        }.frame(width: 30)
        //.foregroundColor(.white)
        .padding(5)
        .background(Color.lightBrown)
            //.padding(20)
    }
}

struct BadgeLabel: View {
    let title: String
    var body: some View {
        SubHeader6(title: title, fColor: .white)
        .padding(.vertical, 5)
        .padding(.horizontal, 15)
        .background(Color.lightBrown)
    }
}



struct EventPreviewText: View {
    let text: String
    let fSize: CGFloat
    let fontWeight: Font.Weight
    var body: some View {
        Text(text)
            .font(.custom("Poppins", size: fSize)).fontWeight(fontWeight)
    }
}



