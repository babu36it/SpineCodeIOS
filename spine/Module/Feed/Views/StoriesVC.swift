//
//  StoriesVC.swift
//  spine
//
//  Created by OM Apple on 13/05/22.
//

import SwiftUI
struct Item {
    var image: String
    var label: String
}

let items = [
    Item(image: "ic_launch", label: "Up"),
    Item(image: "ic_launch", label: "Tortoise"),
    Item(image: "ic_launch", label: "Forward"),
    Item(image: "ic_launch", label: "Down"),
    Item(image: "ic_launch", label: "Hare"),
    Item(image: "ic_launch", label: "Backward"),
    Item(image: "ic_launch", label: "Up"),
    Item(image: "ic_launch", label: "Tortoise"),
    Item(image: "ic_launch", label: "Forward"),
    Item(image: "ic_launch", label: "Down"),
    Item(image: "ic_launch", label: "Hare"),
    Item(image: "ic_launch", label: "Backward"),
    Item(image: "ic_launch", label: "Up"),
    Item(image: "ic_launch", label: "Tortoise"),
    Item(image: "ic_launch", label: "Forward"),
    Item(image: "ic_launch", label: "Down"),
    Item(image: "ic_launch", label: "Hare"),
    Item(image: "ic_launch", label: "Backward"),
    Item(image: "ic_launch", label: "Up"),
    Item(image: "ic_launch", label: "Tortoise"),
    Item(image: "ic_launch", label: "Forward"),
    Item(image: "ic_launch", label: "Down"),
    Item(image: "ic_launch", label: "Hare"),
    Item(image: "ic_launch", label: "Backward"),
    Item(image: "ic_launch", label: "Up"),
    Item(image: "ic_launch", label: "Tortoise"),
    Item(image: "ic_launch", label: "Forward"),
    Item(image: "ic_launch", label: "Down"),
    Item(image: "ic_launch", label: "Hare"),
    Item(image: "ic_launch", label: "Backward"),
    Item(image: "ic_launch", label: "Up"),
    Item(image: "ic_launch", label: "Tortoise"),
    Item(image: "ic_launch", label: "Forward"),
    Item(image: "ic_launch", label: "Down"),
    Item(image: "ic_launch", label: "Hare"),
    Item(image: "ic_launch", label: "Backward")
]

struct StoriesVC: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    private var gridItemLayout = Array(repeating: GridItem(.flexible(), spacing: 15), count: 3)
    @State private var isActive = false
   
//    var btnBack: some View { Button(action: {
//        self.presentationMode.wrappedValue.dismiss()
//    }) {
//        HStack {
//            Image("ic_back") // set image here
//                .renderingMode(.template)
//                .foregroundColor(.black)
//                .aspectRatio(contentMode: .fit)
//        }
//    }
//    }
    var body: some View {
            ScrollView {
                VStack {
                    HStack {
                        Button(action: {
                                  self.presentationMode.wrappedValue.dismiss()
                               }) {
                                   Image(ImageName.ic_back)
                                       .renderingMode(.template)
                                                     .foregroundColor(.black)
                                                      .aspectRatio(contentMode: .fit)
                                                      .padding(.leading, -5)
                               }
                               .navigationBarHidden(true)
                        Spacer()
                        Text("STORIES")
                            .font(AppUtility.shared.appFont(type: .regular, size: 20))
                            .padding(.leading,10)
                        Spacer()
                        Image(systemName: ImageName.magnifyingglass)
                            .font(.title2)
                    }
                    .frame(width: UIScreen.main.bounds.width-40)
                    .padding(.top,10)
                    Title4(title: "Discover moments of People's life and get inspired by them.", fColor: .gray)
                        .padding(.top,10)
                        .multilineTextAlignment(.center)
                    LazyVGrid(columns: gridItemLayout, alignment: .center, spacing: 10) {
                        ForEach(items.indices) { index in
                            HStack{
                                VStack (alignment:.center){
                                    NavigationLink(destination: StoriesImpluseVC(), isActive: self.$isActive){
                                    }   .navigationBarBackButtonHidden(true)
                                        .navigationBarHidden(true)
                                    Image(items[index].image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(minWidth: 0, maxWidth: .infinity,minHeight: 100)
                                        .cornerRadius(50)
                                        .shadow(color: Color.primary.opacity(0.3), radius: 1)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 50).stroke(K.appColors.appTheme, lineWidth: 5)
                                        ).onTapGesture {
                                            DispatchQueue.main.async { // maybe even with some delay
                                                self.isActive = true
                                            }
                                        }
                                    CustomDotView(height: 15).padding(.top, -115)
                                        .padding(.leading, 50)
                                    
                                    Title4(title: "Sophie")
                                    
                                    Text("Living with mental illness")
                                        .frame(minWidth: 0, maxWidth: .infinity,minHeight: 20,alignment: .center)
                                        .font(AppUtility.shared.appFont(type: .regular, size: 12))
                                        .multilineTextAlignment(.center)
                                }
                            }
                            
                        }
                    }
                    .padding(.all, 0)
                   // .animation(.interactiveSpring(), value: gridItemLayout.count)
                }
                .padding()
            }
        }
        
}

struct StoriesVC_Previews: PreviewProvider {
    static var previews: some View {
        StoriesVC()
    }
}

