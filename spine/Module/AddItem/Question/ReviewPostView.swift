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
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            questionVM.selectedTab
            ScrollView(.vertical, showsIndicators: true) {
                ZStack(alignment: .topLeading) {
                    Color.clear // consume entire width
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
                }
            }
        }
        .navigationBarTitle(Text("REVIEW POST"), displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
        .navigationBarItems(trailing: LargeButton(disable: false, title: "POST", width: 40, height: 22, bColor: .lightBrown, fSize: 12, fColor: .white) {
//            print(questionVM.selectedTab)
            questionVM.publishPost(questionVM.postText, hashtags: questionVM.hashTag) { status, error in
                if status {
                    dismiss()
                } else if let error = error {
                    print(error)
                }
            }
        })
    }
}

struct ReviewPostView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewPostView()
    }
}
