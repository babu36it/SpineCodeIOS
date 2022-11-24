//
//  SettingsListView.swift
//  spine
//
//  Created by Mac on 03/07/22.
//

import SwiftUI

struct NavTitleWithArrow: View {
    let title: String
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        HStack {
            NavTitle(title: title)
            Spacer()
            Image(systemName: ImageName.chevronRight)
                .renderingMode(.template)
                .foregroundColor(.lightGray4).opacity(colorScheme == .dark ? 0.6 : 1)
                .font(.callout)
        }
    }
}


struct SettingsListView: View {
    @Environment(\.dismiss) var dismiss
    @State var showEditProfile = false
    
    var body: some View {
        //   NavigationView{
        VStack(spacing: 0) {
            
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)//.padding(.top, 10)
            List {
                //LazyVStack {
                NavigationLink(destination: MyAdsView()) {
                    NavTitle(title: "My Ads")
                }
                //            NavigationLink(destination: Text("Edit profile")) {
                //                NavTitle(title: "Edit profile")
                //            }
                NavTitleWithArrow(title: "Edit profile")
                    .onTapGesture {
                        showEditProfile = true
                    }
                NavigationLink(destination: AccountView()) {
                    NavTitle(title: "Account")
                }
                NavigationLink(destination: NotificationTypeView()) {
                    NavTitle(title: "Notifications")
                }
                NavigationLink(destination: HelpInfoView()) {
                    NavTitle(title: "Help & Info")
                }
                // }
            }
            .listStyle(.plain)
            .frame(height: 300)
            .padding(.vertical, 30)
            
            LargeRectangeButton(title: "INVITE FEEDBACK", bColor: .lightBrown, onTapped: {
                
            }).padding(.bottom, 12)
            
            LargeRectangeButton(title: "INVITE FRIENDS", bColor: .gray, onTapped: {
                
            })
            
            Button("LOGOUT"){
                AppUtility.shared.redirectToLoginScreen()
            }
            .padding()
            .font(.Poppins(type: .regular, size: 14))
            .foregroundColor(.lightBrown)
            
            Spacer()
        }
        .fullScreenCover(isPresented: $showEditProfile){
            EditProfileView()
            //InstaTypeStoryViewer()
        }
        .navigationBarTitle("SETTINGS", displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
        //   }//nav
    }
}

struct SettingsListView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsListView()
    }
}

struct NavTitle: View {
    let title: String
    var body: some View {
        Title3(title: title)
            .padding(.vertical, 10)
    }
}

struct FooterView: View {
    let text: String
    var fsize: CGFloat = 14
    var body: some View {
        Title4(title: text, fColor: .lightBlackText)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

//struct NavTitleWithArrow: View {
//    let title: String
//    var body: some View {
//        HStack {
//            NavTitle(title: title)
//            Spacer()
//            Image(systemName: ImageName.chevronRight).foregroundColor(.lightGray2)
//                .font(.callout)
//        }
//    }
//}

