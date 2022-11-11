//
//  ChatListView.swift
//  spine
//
//  Created by Mac on 30/06/22.
//

import SwiftUI

struct CustomChatTextField: View {
    @State var textInput = ""
    var  onComletion: (Message) -> Void
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            TextField("Write a message", text: $textInput, prompt: nil).padding()
            
            Button {
                print("\(textInput)")
                passMessage()
            } label: {
                Image(systemName: ImageName.paperplaneFill)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.gray)
                    .cornerRadius(50)
                    .padding(.trailing, 10)
            }
        }
        .background(colorScheme == .dark ? Color.black : Color.lightGray1)
        .border(.lightGray1, width: 1, cornerRadius: 20)//for dark mode
        .cornerRadius(20)
        .padding(.horizontal, 10)
    }
    
    func passMessage(){
        let inputTxt = textInput.trimmingCharacters(in: .whitespaces)
        if inputTxt != "" {
            let msg = Message(text: inputTxt, timeStamp: Date(), isReceived: false)
            onComletion(msg)
            textInput = ""
        }
    }
}

//struct CustomTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomTextField()
//    }
//}
