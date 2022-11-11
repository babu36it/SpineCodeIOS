//
//  ChatListView.swift
//  spine
//
//  Created by Mac on 30/06/22.
//

import SwiftUI

struct MessageRow: View {
    let message: Message
    @State var showDate = false
    
    var body: some View {
        VStack {
            HStack {
                if !message.isReceived {
                    Spacer()
                }
                
                VStack(alignment: message.isReceived ? .leading : .trailing) {
                    Title4(title: message.text)
                        .padding()
                        .foregroundColor(message.isReceived ? .black : .white)
                        .background(message.isReceived ? Color.lightGray1.opacity(0.2) : Color.lightBrown)
                        .cornerRadius(20)
                        .onTapGesture {
                            showDate.toggle()
                        }
                    if showDate {
                    Text("\(message.timeStamp.toString("dd MMM yyyy"))")
                   // Text("\(message.timeStamp.formatted(.dateTime.hour().minute()))")
                        .foregroundColor(.gray)
                            .font(.caption2)
                            .padding(.horizontal, 10)
                    }
                    
                }.padding(message.isReceived ? .trailing: .leading, 30)
                
                if message.isReceived {
                    Spacer()
                }
                
            }
        }.padding(.horizontal)
    }
}

struct MessageRow_Previews: PreviewProvider {
    static var previews: some View {
        MessageRow(message: Message(text: "asdsad ddjhas fdfjhdjf dfjfgfhg ggfg ggg hgjhgj hgj jjhgjh jhgjhhg hgjhggjhg hg hjgj hgjh", timeStamp: Date(), isReceived: false))
    }
}
