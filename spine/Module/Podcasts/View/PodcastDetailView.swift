//
//  PodcastDetailView.swift
//  spine
//
//  Created by Mac on 23/05/22.
//

import SwiftUI

struct PodcastDetailView: View {
    //let num: Int = 1
    let screenWidth = UIScreen.main.bounds.size.width
    let imageSize: CGFloat = 120
    @Environment(\.dismiss) var dismiss
    @State var showMoreAction = false
    
    init() {
           // UITabBar.appearance().backgroundColor = UIColor.white
        //UITabBar.appearance().isHidden = true
        }
    
    var body: some View {
        // ScrollView {
        VStack {
            ZStack(alignment: .top) {
                VStack(spacing: 0) {
                    Image(ImageName.podcastDetailBanner)
                        .resizable()
                    //.aspectRatio(contentMode: .fit)
                        .frame(width: screenWidth, height: screenWidth/1.5)
                    ZStack {
                        Text("")
                            .frame(width: screenWidth, height: screenWidth/2.5)
                            .background(Color.lightBrown)
                        VStack(alignment: .leading) {
                            Header5(title: "Oliver Reese", fColor: .white, lineLimit: 1)
                            Header2(title: "From American University Texas, Test sample", fColor: .white, lineLimit: 2)
                            HStack {
                                Header5(title: "4 Episodes", fColor: .white, lineLimit: 1)
                                Spacer()
                                LargeButton(title: "SUBSCRIBE", width: 100, height: 30, bColor: .white, fSize: 12, fColor: Color.lightBrown) {
                                    print("Tapped")
                                }
                            }
                        }.padding(.horizontal, 20)
                    }
                    
                }
                
                CircularBorderedProfileView(image: "Oval 57", size: imageSize, borderWidth: 5)
                    .offset(y: screenWidth/1.5 - (imageSize - 20))
            }
            
            PodcastDetailList()
        }.edgesIgnoringSafeArea(.top)
            .confirmationDialog("", isPresented: $showMoreAction, actions: {
                Button("Follow"){
                    
                }
                Button("Report Post"){
                    
                }
            })
            .modifier(BackButtonModifier(fColor: .white, action: {
                self.dismiss()
            }))
            .navigationBarItems(trailing: Button(action : {
                print("More")
                showMoreAction = true
            }){
                NavBarButtonImage(image: "More")
            })
            .navigationBarItems(trailing: Button(action : {
                print("Share")
            }){
                NavBarButtonImage(image: "directArrow")
            })
        
    }
}

//struct PodcastDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PodcastDetailView()
//    }
//}

struct PodcastDetailList: View {
    var body: some View {
        List {
               Divider().padding(.leading, 10)
                .listRowSeparator(.hidden)

                ForEach((1...4), id: \.self) { item in
                    VStack {
                        ZStack {
                            PodcastDetailListRow()
                            //.padding(.vertical, 5)
                            NavigationLink(destination: MusicPlayerView()) {
                                EmptyView()
                            }.buttonStyle(PlainButtonStyle())
                                .opacity(0.0)
                        }
                        Divider().padding(.leading, 10)
                    }.listRowSeparator(.hidden)
                }
        }//.edgesIgnoringSafeArea(.all)
        .padding(.leading, -20)
        //.padding(.bottom, 70) // fix- list hides below tab bar
        .listStyle(.plain)
    }
}


struct PodcastDetailListRow1: View {
    let item: RssItemModel
    var isFav: Bool {
        return item.favourite == "Y" ? true : false
    }
    var body: some View {
        HStack(alignment: .center) {
            
            VStack(alignment: .leading, spacing: 5) {
                
                HStack {
                    ButtonWithSystemImage(image: "mic", size: 8) {
                        print("mic tapped")
                    }.foregroundColor(.primary).offset(y: -3)
                    
                    Text("En  |")
                        .modifier(SubTitleModifier())
                    
                    ButtonWithCustomImage(image: "CircleClock", size: 15) {
                        print("mic tapped")
                    }.foregroundColor(.primary).offset(y: -3)
                    
                   
                    Text(item.time.toHoursAndMinutes())
                            .modifier(SubTitleModifier())
                }
                Header5(title: item.title, lineLimit: 2)
                
                HStack(spacing: 10) {
                    ButtonWithSystemImage(image: "play.fill", size: 8, fColor: K.appColors.lightGray) {
                        print("Play tapped")
                    }
                    Text("\(item.like)").modifier(SubTitleModifier())
                    ButtonWithSystemImage(image: "heart.fill", size: 12, fColor: isFav ? .pink : K.appColors.lightGray) {
                        print("Heart tapped")
                    }
                }//.foregroundColor(K.appColors.lightGray)
                
            }.padding(.leading, 10)
            Spacer()
            
            HStack(spacing: 20) {
                ButtonWithCustomImage(image: "Bookmark", size: 18) {
                    print("share tapped")
                }
                
                ButtonWithSystemImage(image: "play.circle", size: 40, fColor: Color.lightBrown) {
                    
                }.font(.system(size: 20, weight: .ultraLight))
                
            }
        }.padding(.leading, 10)
            .padding(.vertical, 5)
    }
}

struct PodcastDetailListRow: View {
    var body: some View {
        HStack(alignment: .center) {
            
            VStack(alignment: .leading, spacing: 5) {
                
                HStack {
                    ButtonWithSystemImage(image: "mic", size: 8) {
                        print("mic tapped")
                    }.foregroundColor(.primary).offset(y: -3)
                        
                    Text("En  |")
                        .modifier(SubTitleModifier())
                    
                    ButtonWithCustomImage(image: "CircleClock", size: 15) {
                        print("mic tapped")
                    }.foregroundColor(.primary).offset(y: -3)
                    
                    Text("1h 17min")
                        .modifier(SubTitleModifier())
                }
               Header5(title: "Universal law From Friend of Indins american for ", lineLimit: 2)
                    
                HStack(spacing: 10) {
                    ButtonWithSystemImage(image: "play.fill", size: 8, fColor: K.appColors.lightGray) {
                        print("Play tapped")
                    }
                    Text("45").modifier(SubTitleModifier())
                    ButtonWithSystemImage(image: "heart.fill", size: 12, fColor: K.appColors.lightGray) {
                        print("Heart tapped")
                    }
                }//.foregroundColor(K.appColors.lightGray)
                
            }.padding(.leading, 10)
            Spacer()
            
            
            HStack(spacing: 20) {
                ButtonWithCustomImage(image: "Bookmark", size: 18) {
                    print("share tapped")
                }
                
                ButtonWithSystemImage(image: "play.circle", size: 40, fColor: Color.lightBrown) {

                }.font(.system(size: 20, weight: .ultraLight))
                    
            }
            
            
        }.padding(.leading, 10)
            .padding(.vertical, 5)
    }
}


struct PodcastFontStyle: ViewModifier {
    let fSize: CGFloat
    func body(content: Content) -> some View {
        content
            //.fontWeight(.medium)
            .foregroundColor(.primary)
            .font(.Poppins(type: .regular, size: fSize))
    }
}


struct PodcastTitle: View {
    let title: String
    let fSize: CGFloat
    let linelimit: Int
    let fontWeight: Font.Weight
    let fColor: Color
    var body: some View {
        Text(title)
            .foregroundColor(fColor)
            .font(.Poppins(type: .regular, size: fSize))
            .fontWeight(fontWeight)
            .lineLimit(linelimit)
    }
}

struct NavBarButtonImage: View {
    let image: String
    var size: CGFloat = 18
    var body: some View {
        Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
    }
}
