//
//  VerifyAccountView.swift
//  spine
//
//  Created by Mac on 03/08/22.
//

import SwiftUI

struct VerifyAccountView: View {
    @Environment(\.dismiss) var dismiss
    let screenWidth = UIScreen.main.bounds.size.width - 40
    @State var website = ""
    @State var gListing = ""
    @State var wiki = ""
    @State var other = ""
    @State var openFile = false
    @State var fileUrls: [CustomUrl] = []
    
    var body: some View {
        ScrollView {
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)
            VStack(spacing: 40) {
                VStack(spacing: 20) {
                    Header4(title: C.StaticText.verifyAccntTitle)
                    Title3(title: C.StaticText.verifyAccntText)
                    LargeButton(title: "UPLOAD FILES", width: screenWidth, height: 50, bColor: .lightBrown, fSize: 15, fColor: .white) {
                        print("upload")
                        openFile.toggle()
                    }
                    
                    LazyVStack {
                        ForEach(fileUrls, id: \.self) { custUrl in
                            HStack {
                                Text(custUrl.url.lastPathComponent).fontWeight(.bold)
                                ButtonWithSystemImage(image: "multiply", size: 12, fColor: .lightBrown) {
                                    fileUrls.removeAll { custUrl.id == $0.id }
                                }
                            }
                        }
                    }
                }
                
                
                VStack(spacing: 20) {
                    EventDetailTitle2(text: "Add Links:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    VStack(alignment: .leading) {
                        EventDetailTitle(text: "Website")
                        CustomTextFieldWithCount(searchText: $website, placeholder: "Enter")
                    }
                    VStack(alignment: .leading) {
                        EventDetailTitle(text: "Google Listing")
                        CustomTextFieldWithCount(searchText: $gListing, placeholder: "Enter")
                    }
                    VStack(alignment: .leading) {
                        EventDetailTitle(text: "Wikipedia")
                        CustomTextFieldWithCount(searchText: $wiki, placeholder: "Enter")
                    }
                    VStack(alignment: .leading) {
                        EventDetailTitle(text: "Other")
                        CustomTextFieldWithCount(searchText: $other, placeholder: "Enter")
                    }
                    
                    Button {
                        print("add")
                    } label: {
                        Text("add more")
                    }.tint(.primary)
                    
                    
                    LargeButton(title: "SEND", width: screenWidth, height: 50, bColor: .lightBrown, fSize: 15, fColor: .white) {
                        print("send")
                    }
                }
            }.padding()
        }
        .fileImporter(isPresented: $openFile, allowedContentTypes: [.pdf, .jpeg], onCompletion: { res in
            do {
                let fileUrl = try res.get()
                self.fileUrls.append(CustomUrl(url: fileUrl))
                print(fileUrl)
            } catch {
                
            }
        })
        .navigationBarTitle("VERIFY MY ACCOUNT", displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
    }
}

struct VerifyAccountView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyAccountView()
    }
}

struct CustomUrl: Identifiable, Hashable {
    let id = UUID()
    let url: URL
    
}
