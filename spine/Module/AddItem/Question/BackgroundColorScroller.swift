//
//  BackgroundColorScroller.swift
//  spine
//
//  Created by Mac on 26/07/22.
//

import SwiftUI

struct BackgroundColorScroller: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var questionVM: AddQuestionThoughtViewModel
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                Color.lightBrown
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $questionVM.postText)
                        //.frame(height: 400)
                    Text(C.PlaceHolder.postQuestion)
                        .padding(8)
                        .foregroundColor(.lightGray1)
                        .hidden(!questionVM.postText.isEmpty)
                        .allowsHitTesting(false)
                }
                .font(.Poppins(type: .regular, size: 25))
                .padding(20)
            }
            .onAppear {
               // questionVM.selectedTab = bgColor
            }

            NavigationLink(isActive: $questionVM.showTag) {
                AddHashTagView().environmentObject(questionVM)
            } label: {
                EmptyView()
            }
        }
        .navigationBarTitle(Text("(\(questionVM.postText.count)/460 characters)"), displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
        .navigationBarItems(trailing: Button("Next") {
            print($questionVM.selectedTab)
            questionVM.showTag = true
        })
    }
}

struct BackgroundColorScroller_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundColorScroller()
    }
}
