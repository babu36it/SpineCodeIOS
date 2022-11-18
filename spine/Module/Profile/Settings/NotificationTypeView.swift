//
//  NotificationTypeView.swift
//  spine
//
//  Created by Mac on 05/07/22.
//

import SwiftUI

enum NotificationMode: String {
    case mobile = "MOBILE"
    case email = "EMAIL"
}

struct NotificationTypeView: View {
    @Environment(\.dismiss) var dismiss
    @State var selectedTab: NotificationMode = .mobile
    let width = UIScreen.main.bounds.width
    @StateObject var notifModel = NotificationTypeViewModel()
    
    @State var pushNotification = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4).padding(.top, 10)
            VStack(spacing: 0) {
                
                HStack(spacing: 0) {
                    SegmentedBtnNotification(title: NotificationMode.mobile.rawValue,  selectedTab: $selectedTab) {
                        selectedTab = .mobile
                    }.frame(width: width/2 - 20)
                    
                    SegmentedBtnNotification(title: NotificationMode.email.rawValue,  selectedTab: $selectedTab) {
                        selectedTab = .email
                    }.frame(width: width/2 - 20)
                }
                Divider().frame(width: width - 40)
            }.animation(.linear, value: selectedTab)
            
            if selectedTab == .mobile {
                ScrollView(showsIndicators: false) {
                    CustomToggleBG(value: $notifModel.pushNotifications.notifications, title: "Get Push Notifications", subtitle: C.StaticText.notf_push)
                        .onChange(of: notifModel.pushNotifications.notifications) { newValue in
                            notifModel.updateMobileNotificationStatus()
                    }
                    LazyVStack {
                        NotificationHeader()
                        CustomToggle(value: $notifModel.pushNotifications.likes, title: "Someone likes my stuff", subtitle: C.StaticText.notf_likes)
                            .onChange(of: notifModel.pushNotifications.likes) { newValue in
                                notifModel.updateMobileNotificationStatus()
                        }
                        CustomToggle(value: $notifModel.pushNotifications.comments, title: "Someone comments on my stuff", subtitle: C.StaticText.notf_comments)
                            .onChange(of: notifModel.pushNotifications.comments) { newValue in
                                notifModel.updateMobileNotificationStatus()
                        }
                        CustomToggle(value: $notifModel.pushNotifications.updatesAndReminders, title: "Event updates and reminders", subtitle: C.StaticText.notf_eventUpdate)
                            .onChange(of: notifModel.pushNotifications.updatesAndReminders) { newValue in
                                notifModel.updateMobileNotificationStatus()
                        }
                        CustomToggle(value: $notifModel.pushNotifications.eventReminders, title: "Saved event reminders", subtitle: C.StaticText.notf_eventRemindr)
                            .onChange(of: notifModel.pushNotifications.eventReminders) { newValue in
                                notifModel.updateMobileNotificationStatus()
                        }
                        CustomToggle(value: $notifModel.pushNotifications.messages, title: "Messages", subtitle: C.StaticText.notf_msgMob)
                            .onChange(of: notifModel.pushNotifications.messages) { newValue in
                                notifModel.updateMobileNotificationStatus()
                        }
                        CustomToggle(value: $notifModel.pushNotifications.follows, title: "Activity from members I follow", subtitle: C.StaticText.notf_activity)
                            .onChange(of: notifModel.pushNotifications.follows) { newValue in
                                notifModel.updateMobileNotificationStatus()
                        }
                        CustomToggle(value: $notifModel.pushNotifications.impulses, title: "New Spine Impulses", subtitle: C.StaticText.notf_impulse)
                            .onChange(of: notifModel.pushNotifications.impulses) { newValue in
                                notifModel.updateMobileNotificationStatus()
                        }
                        CustomToggle(value: $notifModel.pushNotifications.anyPosts, title: "Posts from every member", subtitle: C.StaticText.notf_post)
                            .onChange(of: notifModel.pushNotifications.anyPosts) { newValue in
                                notifModel.updateMobileNotificationStatus()
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.top, 20)
            } else {
                ScrollView(showsIndicators: false) {
                    CustomToggleBG(value: $notifModel.emailNotifications.notifications, title: "Get Email Updates", subtitle: C.StaticText.notf_email)
                        .onChange(of: notifModel.emailNotifications.notifications) { newValue in
                            notifModel.updateEmailNotificationsStatus()
                    }
                    LazyVStack {
                        NotificationHeader()
                        CustomToggle(value: $notifModel.emailNotifications.eventAttach, title: "Event iCal attachments", subtitle: C.StaticText.notf_iCal)
                            .onChange(of: notifModel.emailNotifications.eventAttach) { newValue in
                                notifModel.updateEmailNotificationsStatus()
                        }
                        CustomToggle(value: $notifModel.emailNotifications.messages, title: "Messages", subtitle: C.StaticText.notf_msgEmail)
                            .onChange(of: notifModel.emailNotifications.messages) { newValue in
                                notifModel.updateEmailNotificationsStatus()
                        }
                        CustomToggle(value: $notifModel.emailNotifications.comments, title: "Replies to my comments", subtitle: "")
                            .onChange(of: notifModel.emailNotifications.comments) { newValue in
                                notifModel.updateEmailNotificationsStatus()
                        }
                        CustomToggle(value: $notifModel.emailNotifications.podcasts, title: "Suggested events and podcasts", subtitle: C.StaticText.notf_suggested)
                            .onChange(of: notifModel.emailNotifications.podcasts) { newValue in
                                notifModel.updateEmailNotificationsStatus()
                        }
                        CustomToggle(value: $notifModel.emailNotifications.updates, title: "Updates from Spine HQ", subtitle: C.StaticText.notf_hqUpdate)
                            .onChange(of: notifModel.emailNotifications.updates) { newValue in
                                notifModel.updateEmailNotificationsStatus()
                        }
                        CustomToggle(value: $notifModel.emailNotifications.surveys, title: "Spine HQ Surveys", subtitle: C.StaticText.notf_hqSurvey)
                            .onChange(of: notifModel.emailNotifications.surveys) { newValue in
                                notifModel.updateEmailNotificationsStatus()
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.top, 20)
            }
            Spacer()
        }
        .onAppear(perform: {
            notifModel.getAccountSettings()
        })
        .modifier(LoadingView(isLoading: $notifModel.showLoader))
        .navigationBarTitle("NOTIFICATIONS", displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
    }
}

struct NotificationTypeView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationTypeView()
    }
}

struct NotificationHeader: View {
    var body: some View {
        VStack(spacing: 5) {
            FooterView(text: "NOTIFICATION TYPES", fsize: 10)
            Divider()
        }.padding(.top, 20)
    }
}

struct CustomToggle: View {
    @Binding var value: Bool
    let title: String
    var subtitle: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Toggle(isOn: $value, label: {
                SubHeader4(title: title)
            }).tint(.lightBrown).padding(.horizontal, 2)
            if subtitle != "" {
                Title4(title: subtitle, fColor: .lightBlackText)
                    .padding(.trailing, 100)
            }
            
            Divider().padding(.top, 8)
        }
    }
}

struct CustomToggleView: View {
    let title: String
    var subtitle: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                SubHeader4(title: title)
                Spacer()
                Title4(title: "Always\non", fColor: .lightBlackText)
            }
            if subtitle != "" {
                Title4(title: subtitle, fColor: .lightBlackText)
                    .padding(.trailing, 100)
            }
        }
    }
}

struct CustomToggleBG: View {
    @Binding var value: Bool
    let title: String
    var subtitle: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Toggle(isOn: $value, label: {
                SubHeader4(title: title)
            }).tint(.lightBrown).padding(.horizontal, 2)
            if subtitle != "" {
                Title4(title: subtitle, fColor: .lightBlackText)
                    .padding(.trailing, 100)
            }
        }.padding()
//            .background(
//                LinearGradient(gradient: Gradient(colors: [.lightBrown2, .lightBrown2]), startPoint: .leading, endPoint: .trailing))
            .background(Color.lightBrown2)//.opacity(0.3)
    }
}

struct CustomBasicToggle: View {
    @Binding var value: Bool
    let title: String
    
    var body: some View {
       // VStack(alignment: .leading, spacing: 0) {
            Toggle(isOn: $value, label: {
                Title4(title: title, fColor: .lightBlackText)
            }).tint(.lightBrown).padding(.horizontal, 2)
      //      Divider().padding(.top, 8)
      //  }
    }
}


struct SegmentedBtnNotification: View {
    let title: String
    @Binding var selectedTab: NotificationMode
    var onTapped: ()-> Void
    var body: some View {
        VStack(spacing: 10) {
            Button {
                onTapped()
            } label: {
                Text(title)
                    .font(.Poppins(type: .regular, size: 12))
                    .padding(.top, 20)
                    .foregroundColor(selectedTab.rawValue == title ? .primary : .gray)
            }
            Rectangle().frame(height: 2.0, alignment: .top)
                .foregroundColor(K.appColors.appTheme).opacity(selectedTab.rawValue == title ? 1.0 : 0.0)
        }
        
    }
}
