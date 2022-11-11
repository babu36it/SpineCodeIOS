//
//  InstaTypeStoryViewer.swift
//  spine
//
//  Created by Mac on 08/07/22.
//

import SwiftUI

struct InstaTypeStoryViewer: View {
    var images = ["InstaStory", "ic_launch", "RetreatBanner"]
    @StateObject var countTimer = CountTimer(items: 3, interval: 4.0)
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                Image(self.images[Int(self.countTimer.progress)])
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                    .animation(.none)
                VStack(alignment: .leading) {
                    Title4(title: "20 April 2022", fColor: .white)
                    HStack(alignment: .center, spacing: 4) {
                        ForEach(self.images.indices) { image in
                            LoadingBar(progress: min(max((CGFloat(self.countTimer.progress) - CGFloat(image)), 0) , 1.0))
                                .frame(width: nil, height: 2, alignment: .leading)
                                .animation(.linear)
                                //.animation(.linear, value: countTimer.progress)
                        }
                    }//.padding()
                }.padding()
                
                
                HStack(alignment: .center, spacing: 0) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.countTimer.advancePage(by: -1)
                        }
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.countTimer.advancePage(by: 1)
                        }
                }
            }
            .onAppear {
                self.countTimer.start()
            }
        }
        .navigationBarBackButtonHidden(true)
        .modifier(BackButtonModifier(fColor: .white, action: {
            self.dismiss()
        }))
        .navigationBarItems(trailing: Button(action : {
            print("More")
            //showMoreAction = true
        }){
            NavBarButtonImage(image: "More")
        })
        .navigationBarItems(trailing: Button(action : {
            print("Share")
        }){
            NavBarButtonImage(image: ImageName.ic_bookmark, size: 22)
        })
        .navigationBarItems(trailing: Button(action : {
            print("Share")
        }){
            NavBarButtonImage(image: "directArrow")
        })
    }
}

struct InstaTypeStoryViewer_Previews: PreviewProvider {
    static var previews: some View {
        InstaTypeStoryViewer()
    }
}
