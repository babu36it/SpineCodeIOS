//
//  ActivityView.swift
//  spine
//
//  Created by Mac on 18/05/22.
//

import SwiftUI

struct ActivityView: View {
    @State var selectedTab: ActivityTabType = .you
    @State var didSelectTab = true
    
    var body: some View {
        NavigationView {
        VStack {
            SubHeader4(title: "ACTIVITY")
                .padding(.top,10)
            
            VStack(spacing: 0) {
                HStack {
                    SegmentedButtonTab4(title: ActivityTabType.you.rawValue, selectedTab: $selectedTab) {
                        selectedTab = .you
                    }
                    
                    SegmentedButtonTab4(title: ActivityTabType.following.rawValue, selectedTab: $selectedTab) {
                        selectedTab = .following
                    }
                }
                LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)
            }//.padding(.top, -20)
            
            Spacer()
            if selectedTab == .you {
                ActivityTab1View()
            } else {
                ActivityTab2View()
            }
            //Spacer()
            //.navigationBarHidden(true)
        } //vstack
        .navigationBarHidden(true)
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}


struct ActivityTab1View: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ActivityRow()
               // Divider().padding(.leading, 80).padding(.trailing, 20).padding(.vertical, 10)
                PhotoRow()
                PhotoCommentRow()
            }
        }
    }
}

struct ActivityTab2View: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
               // ActivityRow()
               // Divider().padding(.leading, 80).padding(.trailing, 20).padding(.vertical, 10)
                PhotoRow()
                PhotoCommentRow()
            }
        }
    }
}

struct ActivityRow: View {
    var body: some View {
        HStack {
            Image(ImageName.ic_launch)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 44, height: 44)
                .cornerRadius(44)
                .padding(.trailing, 10)
            
            VStack(alignment: .leading) {
                Header4(title: "Cecilla McGee")
                Title4(title: "liked 4 of your photos", fColor: .gray)
            }
            Spacer()
            Title4(title: "10min ago", fColor: .gray)
        }.padding(.horizontal,20)
    }
}

struct PhotoRow: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                Image(ImageName.ic_launch)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 44, height: 44)
                    .cornerRadius(44)
                    .padding(.trailing, 10)
                
                VStack(alignment: .leading) {
                    Header4(title: "Cecilla McGee")
                    Title4(title: "liked 4 of your photos", fColor: .gray)
                }
                
                Spacer()
                Title4(title: "10min ago", fColor: .gray)
            }.padding(.horizontal,20)
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem(.fixed(60), spacing: 0, alignment: .center)], alignment: .center, spacing: 10) {
                    ForEach((1...4), id: \.self) {_ in
                        SquareImage(imgName: "thumbnail1")
                    }
                }
            }.frame(height: 80)
                .padding(.leading, 80) //44+8+8+20 = 80
            
        }
    }
}

struct PhotoCommentRow: View {
    var body: some View {
        VStack(spacing: 0) {
        HStack(alignment: .top) {
            Image(ImageName.ic_launch)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 44, height: 44)
                .cornerRadius(44)
                .padding(.trailing, 10)
            
            VStack(alignment: .leading) {
                Header4(title: "Cecilla McGee")
                Title4(title: "liked 4 of your photos", fColor: .gray)
            }
            
            Spacer()
            Title4(title: "10min ago", fColor: .gray)
        }.padding(.horizontal,20)
            HStack {
                Title4(title: "So you are going abroad. You have chosen your destination and you have to choose a hotel")
                .multilineTextAlignment(.leading)
                    .padding(.trailing)
                Spacer()
                SquareImage(imgName: "thumbnail1")
                   // .frame(width: 60, height: 60)
            }.padding(.leading, 80)
                .padding(.trailing, 20)
            
        }
    }
}



struct SquareImage: View {
    let imgName: String
    var body: some View {
        Image(imgName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 80, height: 80)
    }
}

struct SegmentedButtonTab4: View {
    let title: String
    @Binding var selectedTab: ActivityTabType
    var onTapped: ()-> Void
    var body: some View {
        HStack {
            VStack(spacing: 5) {
                Button {
                    print("Tapped \(title) Tab")
                    onTapped()
                } label: {
                    Title4(title: title, fColor: .primary)
                        .padding(.top, 20)
                }
                Rectangle().frame(height: 4.0, alignment: .top)
                    .foregroundColor(K.appColors.appTheme).opacity(selectedTab.rawValue == title ? 1.0 : 0.0)
            }
            .frame(width:120)
        }
    }
}
