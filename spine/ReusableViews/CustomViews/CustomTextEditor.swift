//
//  CustomTextEditor.swift
//  spine
//
//  Created by Mac on 31/07/22.
//

import Foundation
import SwiftUI

struct CustomTextEditorWithCount: View {
    @Binding var txt: String
    var placeholder: String = "Enter"
    var count: Int = 0
    var height: CGFloat = 75
    var body: some View {
        ZStack {
            Text("")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                //.background(Color.white)
                .background(Color(UIColor.systemBackground))
                .cornerRadius(8)
                .shadow(color: Color.gray.opacity(0.7), radius: 5)
            
            HStack(alignment: .top) {
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $txt)
                    
                    Text(placeholder)
                        .foregroundColor(.gray).padding(8).hidden(!txt.isEmpty)
                        .allowsHitTesting(false)
                }.font(.Poppins(type: .regular, size: 14))

                if count != 0 {
                    Title4(title: "\(count - txt.count)", fColor: Color.placeHoldertxtClr)
                        .padding(5)
                }
            }
            .frame(height: height)
            .padding(2)
             
            
        }
        .onChange(of: txt) { newValue in
            if count != 0 && newValue.count > count {
                txt = String(txt.prefix(count))
            }
        }
    }
}

struct CustomTextEditorWithPH: View {
    @Binding var txt: String
    var placeHolder: String = "Enter"
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $txt)
                .foregroundColor(.lightGray2)
                //.frame(height: 200)
            Text(placeHolder)
                .foregroundColor(.gray).padding(8).hidden(!txt.isEmpty)
                .allowsHitTesting(false)
        }.font(.Poppins(type: .regular, size: 14))
            //.padding(.horizontal, 20)
    }
}

struct CustomTextEditorEditable: View {
    @Binding var text: String
    var height: CGFloat = 100
    var body: some View {
        TextEditor(text: $text)
            .foregroundColor(.gray)
            .font(.Poppins(type: .regular, size: 14))
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .padding(4)
            .background(Color.lightGray5)
    }
}
