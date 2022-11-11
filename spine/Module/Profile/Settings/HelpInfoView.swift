//
//  HelpInfoView.swift
//  spine
//
//  Created by Mac on 05/07/22.
//

import SwiftUI
import MessageUI

struct HelpInfoView: View {
    @Environment(\.dismiss) var dismiss
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    @State var showAlert = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)
           
            List {
                
                Section {
                    Link(destination: URL(string: "http://162.214.165.52/~pirituc5/spine-help")!, label: {
                        NavTitleWithArrow(title: "Help")
                    })
                    
//                    NavigationLink(destination: WebView(url: URL(string: "http://162.214.165.52/~pirituc5/about-us")!)) {
//                        NavTitle(title: "Help")
//                    }
//                    NavigationLink(destination: Text("feedback")) {
//                        NavTitle(title: "Give us feedback")
//                    }
                    NavTitleWithArrow(title: "Give us feedback")
                        .onTapGesture {
                            if MFMailComposeViewController.canSendMail() {
                                isShowingMailView = true
                            } else {
                                showAlert = true
                            }
                            
                        }
                    
                } header: {
                    Title5(title: "SUPPORT")
                }
                
                Section {
                    
                    Link(destination: URL(string: "http://162.214.165.52/~pirituc5/spine-guidelines")!, label: {
                        NavTitleWithArrow(title: "Community Guidelines")
                    })
                    
                    Link(destination: URL(string: "http://162.214.165.52/~pirituc5/about-us")!, label: {
                        NavTitleWithArrow(title: "About Spine")
                    })
                    
                } header: {
                    Title5(title: "INFO")
                }
                
                Section {
                    
                    Link(destination: URL(string: "http://162.214.165.52/~pirituc5/spine-terms")!, label: {
                        NavTitleWithArrow(title: "Terms of Service")
                    })
                    
                    NavigationLink(destination: PrivacySettingsView()) {
                        NavTitle(title: "Privacy Settings")
                    }
                    
                    NavTitle(title: "App Version")
                        .badge("1.2.3")
                } header: {
                    Title5(title: "LEGAL")
                }
                
            }.listStyle(.plain)
                .padding(.top, 10)
        }
        .sheet(isPresented: $isShowingMailView) {
            MailView(result: self.$result)
        }
        .alert("Please install email app", isPresented: $showAlert, actions: {})
        .navigationBarTitle("HELP & INFO", displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
    }
}

struct HelpInfoView_Previews: PreviewProvider {
    static var previews: some View {
        HelpInfoView()
    }
}

