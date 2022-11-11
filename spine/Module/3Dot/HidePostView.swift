//
//  HidePostView.swift
//  spine
//
//  Created by Mac on 27/08/22.
//

import SwiftUI

struct HidePostView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 20) {
            Capsule()
                .frame(width: 60, height: 4).foregroundColor(.gray)
                .padding(.top)
            SubHeader4(title: "Hide this post?")
            Divider()
            
            Title3(title: "You will no longer see this post in your feed.").padding(.vertical)
            
            LargeButton(disable: false, title: "HIDE", width: UIScreen.main.bounds.width - 40, height: 40, bColor: Color.lightBrown, fSize: 15, fColor: .white) {
                
            }
            
            Button("DISMISS") {
                self.dismiss()
            }.foregroundColor(.primary)
            Spacer()
        }.padding()
            //.background(Color(UIColor.systemBackground))
            .background(colorScheme == .dark ? Color.black : Color.white)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct HidePostView_Previews: PreviewProvider {
    static var previews: some View {
        HidePostView()
    }
}
