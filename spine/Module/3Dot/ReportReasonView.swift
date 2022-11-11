//
//  ReportReasonView.swift
//  spine
//
//  Created by Mac on 24/08/22.
//

import SwiftUI

struct ReportReasonView: View {
    let helpText: String
    @EnvironmentObject var dot3VM: Dot3ViewModel
    @Environment(\.dismiss) var dismiss
    @State var tellMore = ""
    @State var reportTapped = false
    
    var body: some View {
        VStack(spacing: 15) {
            Capsule()
                .frame(width: 60, height: 4).foregroundColor(.gray).padding(.top, 20)
            VStack {
                SubHeader4(title: "Report reason:")
                SubHeader4(title: "\(dot3VM.selectedReason)")
                Divider().padding(.horizontal)
            }
            Title3(title: helpText).multilineTextAlignment(.center)
            SubHeader4(title: "Would you like to tell us more?")
            CustomTextEditorWithCount(txt: $tellMore).frame(height: 75)
            
//            Button("REPORT") {
//                dot3VM.tellUsMore = tellMore
//                reportTapped = true
//            }
            LargeButton(title: "REPORT", width: UIScreen.main.bounds.width - 40, height: 40, bColor: Color.lightBrown, fSize: 15, fColor: .white) {
                dot3VM.tellUsMore = tellMore
                reportTapped = true
            }
            
            Button("BACK") {
                self.dismiss()
            }.foregroundColor(.primary)
            
            NavigationLink(isActive: $reportTapped) {
                ReportConfirmationView()
            } label: {
                EmptyView()
            }

            //Spacer()
            
        }.padding(.horizontal, 20)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct ReportReasonView_Previews: PreviewProvider {
    static var previews: some View {
        ReportReasonView(helpText: "test")
    }
}
