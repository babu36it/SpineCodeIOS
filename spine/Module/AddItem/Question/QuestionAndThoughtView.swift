//
//  QuestionAndThoughtView.swift
//  spine
//
//  Created by Mac on 24/07/22.
//

import SwiftUI

struct QuestionAndThoughtView: View {
    @StateObject var questionVM = AddQuestionThoughtViewModel()
    var body: some View {
        BackgroundColorScroller().environmentObject(questionVM)
           // .navigationBarHidden(true)
    }
}

struct QuestionAndThoughtView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionAndThoughtView()
    }
}
    

          



