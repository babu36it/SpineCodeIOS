//
//  CustomAddItemSheet.swift
//  spine
//
//  Created by Mac on 25/05/22.
//

import SwiftUI

struct CustomAddItemSheet: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack {
            Text("").frame(width: 80, height: 4, alignment: .center).background(.gray)
            //Text("Add").bold().padding()
            SubHeader4(title: "Add").padding()
            List {
                NavigationLink(destination: AddVoiceOverView()) {
                    Title3(title: "Voiceover")
                }.padding(.vertical, 10)
                NavigationLink(destination: QuestionAndThoughtView()) {
                    Title3(title: "Question or Thought")
                }.padding(.vertical, 10)
                NavigationLink(destination: AddImageOrVideoView(addItemType: .videoImage)) {
                    Title3(title: "Picture or Video")
                }.padding(.vertical, 10)
                NavigationLink(destination: AddImageOrVideoView(addItemType: .story)) {
                    Title3(title: "Story")
                }.padding(.vertical, 10)
                NavigationLink(destination: AddEventView()) {
                    Title3(title: "Event")
                }.padding(.vertical, 10)
                NavigationLink(destination: LinkRSSView()) {
                    Title3(title: "Podcast")
                }.padding(.vertical, 10)
                NavigationLink(destination: CreateAdView()) {
                    Title3(title: "Ad")
                }.padding(.vertical, 10)
            }.font(Fonts.poppinsRegular(size: 16))
            //.scrollEnabled(false)
            .listStyle(.plain)
            .frame(height: 370)
        }
        .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 70)
        .padding(.horizontal)
        .padding(.top, 20)
        //.background(Color.white)
        .background(colorScheme == .dark ? Color.black : Color.white)
        .cornerRadius(25)
    }
}

struct customRow: View {
    let title: String
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text(title)
                Spacer()
                Image(systemName: ImageName.chevronRight)
            }
            Divider()
        }.padding(.horizontal, 20)
    }
}

extension View {
  @ViewBuilder func scrollEnabled(_ enabled: Bool) -> some View {
    if enabled {
      self
    } else {
      simultaneousGesture(DragGesture(minimumDistance: 0),
                          including: .all)
    }
  }
}

struct CustomHalfSheet: View {
    @Binding var showSheet: Bool
    let items: [String]
    @Binding var selectedItem: String
    var pageTitle: String = "Add"
    var height: CGFloat = 200
    var body: some View {
        VStack {
            Text("").frame(width: 80, height: 4, alignment: .center).background(.gray)
            Text(pageTitle).bold().padding()
            List {
                ForEach(items, id:\.self) { item in
                    listRow(item: item)
                }
            }.font(Fonts.poppinsRegular(size: 16))
            //.scrollEnabled(false)
            .listStyle(.plain)
            .frame(height: height)
        }
        .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 70)
        .padding(.horizontal)
        .padding(.top, 20)
        //.background(Color.white)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(25)
    }
    
    @ViewBuilder
    func listRow(item: String)->some View {
        Text(item)
            .onTapGesture {
                selectedItem = item
                showSheet = false
            }
    }
}
