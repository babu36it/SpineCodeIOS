//
//  MemberGalleryVC.swift
//  spine
//
//  Created by OM Apple on 27/05/22.
//

import SwiftUI
import WaterfallGrid
struct GallerItem {
    var image: String
    var label: String
}

let gallerItem = [
    GallerItem(image: "ic_launch", label: "Up"),
    GallerItem(image: "FeedBanner3", label: "Tortoise"),
    GallerItem(image: "FeedBanner5", label: "Forward"),
    GallerItem(image: "FeedBanner6", label: "Down"),
    GallerItem(image: "FeedBanner3", label: "Hare"),
    GallerItem(image: "FeedBanner5", label: "Backward"),
    GallerItem(image: "FeedBanner6", label: "Up"),
    GallerItem(image: "FeedBanner3", label: "Tortoise"),
    GallerItem(image: "ic_launch", label: "Forward"),
    GallerItem(image: "FeedBanner6", label: "Down"),
    GallerItem(image: "ic_launch", label: "Hare"),
    GallerItem(image: "FeedBanner3", label: "Backward"),
    GallerItem(image: "FeedBanner6", label: "Up"),
    GallerItem(image: "ic_launch", label: "Tortoise"),
    GallerItem(image: "FeedBanner5", label: "Forward")
   
    
]
struct MemberGalleryVC: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    private var gridItemLayout = Array(repeating: GridItem(.flexible(), spacing: 15), count: 3)

    var body: some View {
        VStack {
            
            
            HStack {
                Button(action: {
                          self.presentationMode.wrappedValue.dismiss()
                       }) {
                           Image(ImageName.ic_back)
                               .renderingMode(.template)
                                             .foregroundColor(.primary)
                                              .aspectRatio(contentMode: .fit)
                                              .padding(.leading, -5)
                       }
                       .navigationBarHidden(true)
                Spacer()
              
                Text("MEMBERS")
                    .font(AppUtility.shared.appFont(type: .regular, size: 20))
                    .padding(.leading,10)
                Spacer()
                
                Image(systemName: ImageName.magnifyingglass)
                    .font(.title2)
            
            }
            .frame(width: UIScreen.main.bounds.width-40)
            .padding()
            .padding(.top,0)
           
            Title4(title: "Discover people on Spine you might want to follow.", fColor: .gray)
                .multilineTextAlignment(.center)
                .padding(.all, 10)
            ScrollView {
                WaterfallGrid((0..<15), id: \.self) { index in
                    Image(gallerItem[index].image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                }
        }
    }
    }
}

struct MemberGalleryVC_Previews: PreviewProvider {
    static var previews: some View {
        MemberGalleryVC()
    }
}

