//
//  AddHashTagView.swift
//  spine
//
//  Created by Mac on 26/07/22.
//

import SwiftUI

struct AddHashTagView: View {
    @EnvironmentObject var questionVM: AddQuestionThoughtViewModel
    @Environment(\.dismiss) var dismiss
    //@State var showPreview = false
    
    var body: some View {
        VStack {
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)
            
            ZStack(alignment: .topLeading) {
                TextEditor(text: $questionVM.hashTag)
                    //.frame(height: 200)
                Text(C.PlaceHolder.hashTags)
                    .foregroundColor(.black.opacity(0.25)).padding(8).hidden(!questionVM.hashTag.isEmpty)
                    .allowsHitTesting(false)
            }.font(.Poppins(type: .regular, size: 20))
                .padding(20)
            Spacer()
            
            NavigationLink(isActive: $questionVM.showPreview) {
                ReviewPostView().environmentObject(questionVM)
            } label: {
                EmptyView()
            }
        }
        .navigationBarTitle(Text("ADD HASTAGS"), displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
        .navigationBarItems(trailing: Button("Next") {
            questionVM.showPreview = true
        })
    }
}


struct AddHashTagView_Previews: PreviewProvider {
    static var previews: some View {
        AddHashTagView()
    }
}
