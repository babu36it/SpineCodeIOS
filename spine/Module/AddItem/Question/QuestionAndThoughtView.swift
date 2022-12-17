//
//  QuestionAndThoughtView.swift
//  spine
//
//  Created by Mac on 24/07/22.
//

import SwiftUI

struct QuestionAndThoughtView: View {
    @StateObject var questionVM = AddQuestionThoughtViewModel()
    @Binding var rootLinkActive: Bool
    var body: some View {
        BackgroundColorScroller(rootLinkActive: $rootLinkActive)
            .environmentObject(questionVM)
    }
}

struct QuestionAndThoughtView_Previews: PreviewProvider {
    static var previews: some View {
        let rootLink: Binding<Bool> = .init(get: { true }, set: { _ in })
        QuestionAndThoughtView(rootLinkActive: rootLink)
    }
}
    

          



