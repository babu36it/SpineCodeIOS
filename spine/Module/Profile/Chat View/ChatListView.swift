//
//  ChatListView.swift
//  spine
//
//  Created by Mac on 30/06/22.
//

import SwiftUI

struct ChatListView: View {
    let attendee: Attendee
    @State var arr: [Message] = msgArr
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 0) {
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4).padding(.top, 10)
            VStack {
                ScrollViewReader { value in
                    ScrollView {
                        LazyVStack {
                            ForEach(arr) { msg in
                                MessageRow(message: msg)
                                    .id(msg.id)
                            }
                        }
                    }
                    .onAppear {
                        value.scrollTo(arr.last?.id)
                        print("On appear")
                    }
                    .onChange(of: arr.count) { _ in
                        value.scrollTo(arr.last?.id)
                    }
                }
                CustomChatTextField { newMsg in
                    arr.append(newMsg)
                }
            }
        }
        .navigationBarTitle(attendee.name, displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView(attendee: Attendee(name: "Craig Warner", img: "Oval 57", msgEn: true))
    }
}
