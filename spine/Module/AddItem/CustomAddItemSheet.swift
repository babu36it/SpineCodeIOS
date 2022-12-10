//
//  CustomAddItemSheet.swift
//  spine
//
//  Created by Mac on 25/05/22.
//

import SwiftUI

struct CustomAddItemSheet: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var dismisser: Bool
    
    private let bottomInset: CGFloat = (UIApplication.keyWindow?.safeAreaInsets.bottom ?? 0) + 70

    var body: some View {
        VStack {
            Text("").frame(width: 80, height: 4, alignment: .center).background(.gray)
            SubHeader4(title: "Add").padding()
            List {
                link(destination: AddVoiceOverView(), label: "Voiceover")
                link(destination: QuestionAndThoughtView(), label: "Question or Thought")
                link(destination: AddImageOrVideoView(addItemType: .videoImage), label: "Picture or Video")
                link(destination: AddImageOrVideoView(addItemType: .story), label: "Story")
                link(destination: AddEventTypeSelectionView(), label: "Event")
                link(destination: LinkRSSView(), label: "Podcast")
                link(destination: CreateAdView(), label: "Ad")
            }
            .font(Fonts.poppinsRegular(size: 16))
            .listStyle(.plain)
            .frame(height: 370)
        }
        .padding(.bottom, bottomInset)
        .padding(.horizontal)
        .padding(.top, 20)
        .background(colorScheme == .dark ? Color.black : Color.white)
        .cornerRadius(25)
    }
    
    private func link<T>(destination: T, label: String) -> some View where T: View {
        NavigationLink(destination: destination.onAppear(perform: { dismisser.toggle() }), label: {
            Title3(title: label)
                .padding(.vertical, 10)
        })
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
    
    private let bottomInset: CGFloat = (UIApplication.keyWindow?.safeAreaInsets.bottom ?? 0) + 70
    
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
        .padding(.bottom, bottomInset)
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
