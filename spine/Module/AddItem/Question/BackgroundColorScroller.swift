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
            TabView(selection: $questionVM.selectedTab) {
                ForEach(questionVM.bgColors, id: \.self){ bgColor in
                    ZStack(alignment: .topLeading) {
                        bgColor
                        ZStack(alignment: .topLeading) {
                            TextEditor(text: $questionVM.postText)
                                //.frame(height: 400)
                                .foregroundColor(.white)
                                .background(bgColor)
                            Text(C.PlaceHolder.postQuestion)
                                .foregroundColor(.white).padding(8).hidden(!questionVM.postText.isEmpty)
                                .allowsHitTesting(false)
                        }.font(.Poppins(type: .regular, size: 25))
                            .padding(20)
                    }//.tag(questionVM.selectedTab)
                    .onAppear {
                       // questionVM.selectedTab = bgColor
                    }
                }
                
                
            }.tabViewStyle(.page)
                //.tabViewStyle(.page)
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .interactive))
            
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
