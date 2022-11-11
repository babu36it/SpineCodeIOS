//
//  AboutEventView.swift
//  spine
//
//  Created by Mac on 15/06/22.
//

import SwiftUI

struct AboutEventView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var aboutTxt: String
    @State var tempTxt = ""
    @State var showAlert = false
    @State var disableSave = true
    
    var body: some View {
            VStack {
                LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4).padding(.top, 10)
                    .padding(.bottom, 40)
                
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $tempTxt)
                        .frame(height: 200)
                    Text(C.PlaceHolder.aboutEvent)
                        .foregroundColor(.black.opacity(0.25)).padding(8).hidden(!tempTxt.isEmpty)
                        .allowsHitTesting(false)
                }.font(.Poppins(type: .regular, size: 20))
                    .padding(.horizontal, 20)
                
                    .onChange(of: tempTxt) { newValue in
                        disableSave = newValue.count >= 50 ? false : true
                    }
                
                Spacer()
            }
            .onAppear(perform: {
                tempTxt = aboutTxt
            })
        
            .alert("Want to save your changes?", isPresented: $showAlert, actions: {
                Button("Continue", role: .cancel, action: {
                    self.dismiss()
                })
                Button("Save", role: .none, action: {
                    aboutTxt = tempTxt
                    self.dismiss()
                }).accentColor(.lightBrown)
            }, message: {
                Text("You will lose your data if you continue without saving them.")
            })
        
        .navigationBarTitle(Text("ABOUT"), displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            if aboutTxt != tempTxt {
                showAlert = true
            } else {
                self.dismiss()
            }
        }))
        .navigationBarItems(trailing: LargeButton(disable: disableSave, title: "SAVE & EXIT", width: 90, height: 22, bColor: Color.lightBrown, fSize: 12, fColor: .white) {
            aboutTxt = tempTxt
            self.dismiss()
        }
        )
    }
}

extension View {
    @ViewBuilder public func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: self.hidden()
        case false: self
        }
    }
}
