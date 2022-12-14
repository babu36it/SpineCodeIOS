//
//  ReviewPostView.swift
//  spine
//
//  Created by Mac on 26/07/22.
//

import SwiftUI

struct ReviewPostView: View {
    @EnvironmentObject var questionVM: AddQuestionThoughtViewModel
    @Environment(\.dismiss) var dismiss
    @Binding var rootLinkActive: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)
            
            ZStack(alignment: .topLeading) {
                questionVM.selectedTab
                VStack(alignment: .leading, spacing: 20) {
                    Text(questionVM.postText)
                        .onTapGesture {
                            print("tapped")
                            questionVM.showTag = false
                        }
                    Text(questionVM.hashTag)
                        .onTapGesture {
                            print("tapped")
                            questionVM.showPreview = false
                        }
                }
                .foregroundColor(.white)
                .font(.Poppins(type: .regular, size: 20))
                .padding(20)
                
                Spacer()
            }
            
        }
        .navigationBarTitle(Text("REVIEW POST"), displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
        .navigationBarItems(trailing: LargeButton(disable: false, title: "POST", width: 40, height: 22, bColor: .lightBrown, fSize: 12, fColor: .white) {
            print(questionVM.selectedTab)
            questionVM.publishPost(questionVM.postText, hashtags: questionVM.hashTag) { status, error in
                if status {
                    rootLinkActive = false
                } else if let error = error {
                    ShowToast.show(toatMessage: error.localizedDescription)
                    print(error)
                }
            }
        })
    }
}

struct ReviewPostView_Previews: PreviewProvider {
    static var previews: some View {
        let rootLink: Binding<Bool> = Binding(get: { true }, set: { _ in })
        ReviewPostView(rootLinkActive: rootLink)
    }
}
