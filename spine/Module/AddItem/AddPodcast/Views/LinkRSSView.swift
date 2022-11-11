//
//  LinkRSSView.swift
//  spine
//
//  Created by Mac on 30/05/22.
//

import SwiftUI
import Combine

struct LinkRSSView: View {
    @Environment(\.dismiss) var dismiss
    let screenWidth = UIScreen.main.bounds.size.width
    @StateObject var linkRssVM = LinkRssViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            if linkRssVM.status == .failure {
                ZStack {
                    Color.black1
                        .frame(width: screenWidth, height: 130)
                    VStack(spacing: 0) {
                        
                        ButtonWithSystemImage(image: ImageName.multiply, size: 14, fColor: .white) {
                            linkRssVM.status = nil
                        }.padding(.trailing, 10)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        
                        Title4(title: "! Make sure your RSS feed contains atleast\n one episode and the following tags:\n title, author, email", fColor: .white)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    
                }.padding(.top, 10)
            } else {
                LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4).padding(.top, 10)
            }
            
            VStack(spacing: 20) {
                Header5(title: "What's the link to your podcast's RSS feed?")
                Title3(title: "Only add a podcast you own the right to and\n make sure it meats our guidlines. You only\n have to do this once. After your podcast is on\n the Spiritual Network, it will update\n automatically")
                    .multilineTextAlignment(.center)
            }.padding(.horizontal, 20)
            
            VStack(alignment: .center) {
                HStack {
                    Header5(title: "Link to RSS feed")
                        .padding(.leading, 30)
                    Spacer()
                }
                CustomTextField(searchText: $linkRssVM.searchText)
            }
            LargeButton(title: "VALIDATE RSS FEED", width: screenWidth - 60, height: 40, bColor: Color.lightBrown, fSize: 15, fColor: .white) {
                print("Tapped")
                linkRssVM.validateRss()
                //linkRssVM.status = .success
            }.padding(.top, 30)
            Spacer()
            NavigationLink("", tag: RssStaus.success, selection: $linkRssVM.status) {
                RSSLinkOtpView()
            }
        }.modifier(LoadingView(isLoading: $linkRssVM.showLoader))
            .navigationBarTitle(Text("ADD PODCAST"), displayMode: .inline)
            //.navigationTitle("Navigation Title")
            //.navigationBarTitleDisplayMode(.inline)
            .modifier(BackButtonModifier(action: {
                self.dismiss()
            }))
    }
}

struct LinkRSSView_Previews: PreviewProvider {
    static var previews: some View {
        LinkRSSView()
    }
}
