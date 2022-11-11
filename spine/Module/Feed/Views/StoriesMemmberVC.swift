//
//  StoriesMemmberVC.swift
//  spine
//
//  Created by OM Apple on 25/05/22.
//

import SwiftUI


struct StoriesMemmberVC: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    private var gridItemLayout = Array(repeating: GridItem(.flexible(), spacing: 15), count: 3)
    var btnBack: some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            Image(ImageName.ic_back) // set image here
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
        }
    }
    }
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        
                        Spacer()
                        Text("STORIES OF YOUR FRIENDS")
                            .font(AppUtility.shared.appFont(type: .regular, size: 20))
                            .padding(.leading,20)
                        Spacer()
                        
                        Image(systemName: ImageName.magnifyingglass)
                            .font(.title2)
                        
                    }
                    .frame(width: UIScreen.main.bounds.width-40)
                    .padding()
                    .padding(.top,10)
                    
                    
                    LazyVGrid(columns: gridItemLayout, alignment: .center, spacing: 10) {
                        
                        ForEach(items.indices) { index in
                            HStack{
                                VStack (alignment:.center){
                                    
                                    Image(items[index].image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(minWidth: 0, maxWidth: .infinity,minHeight: 100)
                                        .cornerRadius(50)
                                        .shadow(color: Color.primary.opacity(0.3), radius: 1)
                                        .overlay(
                                                        RoundedRectangle(cornerRadius: 50).stroke(K.appColors.appTheme, lineWidth: 5)
                                                    )
                                    CustomDotView(height: 15).padding(.top, -115)
                                        .padding(.leading, 50)
                                    
                                    Header5(title: "Sophie")
                                    Title5(title: "Living with mental illness")
                                        .frame(minWidth: 0, maxWidth: .infinity,minHeight: 20,alignment: .center)
                                        .multilineTextAlignment(.center)
                                }
                                  
                                // Spacer()
                            }
                            
                        }
                    }
                    .padding(.all, 10)
                    .animation(.interactiveSpring(), value: gridItemLayout.count)
                    
                    
                }
                .padding()
                
                
            } .navigationBarItems(leading: btnBack)
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
            // .navigationTitle("Coffee Feed")
            
        }
        //        VStack {
        //            HStack {
        //
        //               Spacer()
        //                Text("STORIES")
        //                    .font(.title2)
        //                    .padding(.leading,50)
        //                Spacer()
        //
        //                Image(systemName: "magnifyingglass")
        //                    .font(.title2)
        //
        //            }
        //            .frame(width: UIScreen.main.bounds.width-40)
        //            .padding()
        //            .padding(.top,-100)
        //
        //
        //            Text("Discover moments of People's life and get inspired by them.")
        //                .frame(width: UIScreen.main.bounds.width-90)
        //                .foregroundColor(Color.gray)
        //                .font(.title3)
        //                //.padding(.top,20)
        //
        //            ScrollView {
        //                ForEach(0..<5){x in
        //                    page1Stories()
        //                        .padding()
        //                }
        //            }
        //            .padding()
        //
        //        }
        //
        //    }
    }
}

struct StoriesMemmberVC_Previews: PreviewProvider {
    static var previews: some View {
        StoriesMemmberVC()
    }
}

