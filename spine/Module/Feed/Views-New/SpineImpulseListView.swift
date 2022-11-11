//
//  SpineImpulseListView.swift
//  spine
//
//  Created by Mac on 14/07/22.
//

import SwiftUI

struct SpineImpulseListView: View {
    @Environment(\.dismiss) var dismiss
    let spineImulseList = [feedItem7, feedItem7, feedItem7, feedItem7]
    var body: some View {
        VStack(spacing: 0) {
            
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)//.padding(.top, 10)
            ScrollView {
                Title4(title: "Inspirational thoughts and wisdom to encourage..", fColor: .gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40).padding(.top, 10)
                    ForEach(spineImulseList) { item in
                        LazyVStack {
                            if let impulseDetail = item.imagetxt {
                                HStack {
                                    ProfileImgWithTitleAndName(imageStr: item.profileImg, title: item.profTitle, subtitle: item.profSubtitle, showBadge: item.isNew)
                                    Spacer()
                                    Title5(title: item.days, fColor: .gray)
                                }.padding(.horizontal)
                                
                                SpineImpulseCell(content: impulseDetail)
                                ButtonListHView(item: item)
                                Divider().padding(.horizontal, 20)
                            }
                            
                        }
                    }
            
            }
        }
        
        .navigationBarTitle("SPINE IMPULSES", displayMode: .inline)
        .navigationBarItems(trailing:
        Button(action: { }, label: {
            Title4(title: "+ Follow", fColor: .lightBrown)
        }).tint(.blue)
        )
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
    }
}

struct SpineImpulseListView_Previews: PreviewProvider {
    static var previews: some View {
        SpineImpulseListView()
    }
}

