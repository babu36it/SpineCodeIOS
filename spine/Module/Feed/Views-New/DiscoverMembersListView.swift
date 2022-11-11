//
//  DiscoverMembersListView.swift
//  spine
//
//  Created by Mac on 15/07/22.
//

import SwiftUI

struct DiscoverMembersListView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            Title4(title: "Discover people on Spine you might want to follow", fColor: .gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40).padding(.top, 10)
            MemberGalleryVC()
        }
            .navigationBarTitle("STORIES", displayMode: .inline)
            .navigationBarItems(trailing: CustomButton(image: "ic_search") {
            })
            .modifier(BackButtonModifier(action: {
                self.dismiss()
            }))
    }
}

struct DiscoverMembersListView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverMembersListView()
    }
}
