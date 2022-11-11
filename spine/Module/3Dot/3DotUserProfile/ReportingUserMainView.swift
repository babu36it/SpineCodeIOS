//
//  ReportingUserMainView.swift
//  spine
//
//  Created by Mac on 24/08/22.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        Text("Test")
    }
}

struct ReportingUserMainView: View {
    @Binding var showSheet: Bool
    @StateObject var dot3VM = Dot3ViewModel()
    @Environment(\.dismiss) var dismiss
    @State var showReportReason = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Capsule()
                    .frame(width: 60, height: 4).foregroundColor(.gray)
                    .padding(.top, 10)
                VStack {
                    SubHeader4(title: "Why do you want to report this user?")
                    Title3(title: "Your report will be confidential.", fColor: .gray)
                }
                
                List {
                    
                    NavigationLink(destination: ReportingSubView(selectedItem: $dot3VM.selectedReason, items: postedMsgArr, title: "What makes it inappropriate?", type: .user)) {
                        Title3(title: "A message they posted")
                    }
                    
                    NavigationLink(destination: ReportingSubView(selectedItem: $dot3VM.selectedReason, items: inAproprPhoto, title: "What makes it inappropriate?", type: .user)) {
                        Title3(title: "Inapropriate profile photo or content")
                    }
                    
                    NavigationLink(destination: ReportReasonView(helpText: userReportGuide)) {
                        Title3(title: "Intellectual property infringement")
                    }
                    
                    NavigationLink(destination: ReportReasonView(helpText: userReportGuide)) {
                        Title3(title: "Impersonation")
                    }
                    
                    NavigationLink(destination: ReportReasonView(helpText: userReportGuide)) {
                        Title3(title: "Something they did in person")
                    }
                    
                    NavigationLink(destination: ReportReasonView(helpText: userReportGuide)) {
                        Title3(title: "Fake profile")
                    }
                    
                }.listStyle(.plain)
                    //.frame(height: 200)

                LargeButton(title: "DISMISS", width: UIScreen.main.bounds.width - 40, height: 40, bColor: Color.lightBrown, fSize: 15, fColor: .white) {
                    showSheet = false
                }
                //Spacer()
            }.padding(.vertical)
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }.environmentObject(dot3VM)
            .edgesIgnoringSafeArea(.bottom)
            
    }
}

//struct ReportingUserMainView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReportingUserMainView()
//    }
//}
