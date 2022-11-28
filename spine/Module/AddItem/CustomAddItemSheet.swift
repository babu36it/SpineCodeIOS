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
                link(destination: AddEventView(), label: "Event")
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
    
    private func link(destination: some View, label: String) -> some View {
        NavigationButton(action: {
            dismisser.toggle()
        }, destination: {
            destination
        }, label: {
            Title3(title: label)
                .padding(.vertical, 10)
        })
//        Group {
//            NavigationLink(destination: destination, label: {
//                Title3(title: label)
//                    .padding(.vertical, 10)
//            })
//        }
//        .simultaneousGesture(TapGesture().onEnded {
//            dismisser.toggle()
//        })
    }
}

struct NavigationButton<Destination: View, Label: View>: View {
    var action: () -> Void = { }
    var destination: () -> Destination
    var label: () -> Label

    @State private var isActive: Bool = false

    var body: some View {
        Button(action: {
            self.action()
            self.isActive.toggle()
        }) {
            self.label()
              .background(
                ScrollView { // Fixes a bug where the navigation bar may become hidden on the pushed view
                    NavigationLink(destination: LazyDestination { destination() },
                                                 isActive: $isActive) { EmptyView() }
                }
              )
        }
    }
}

// This view lets us avoid instantiating our Destination before it has been pushed.
struct LazyDestination<Destination: View>: View {
    var destination: () -> Destination
    var body: some View {
        destination()
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
