//
//  ReportingMainView.swift
//  spine
//
//  Created by Mac on 24/08/22.
//

import SwiftUI

struct ReportingMainView: View {
    @Binding var showSheet: Bool
    @StateObject var dot3VM = Dot3ViewModel()
    //@EnvironmentObject var dot3VM: Dot3ViewModel
    @Environment(\.dismiss) var dismiss
    @State var showReportReason = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Capsule()
                    .frame(width: 60, height: 4).foregroundColor(.gray)
                    .padding(.bottom)
                Spacer()
                SubHeader4(title: "Why are you reporting this?")
                List {
                    
                    NavigationLink(destination: ReportingSubView(selectedItem: $dot3VM.selectedReason, items: spamArray, title: "What makes it poor quality or spam?")) {
                        Title3(title: "It’s poor quality or spam")
                    }.padding(.vertical, 10)
                    
                    NavigationLink(destination: ReportingSubView(selectedItem: $dot3VM.selectedReason, items: inApprArray, title: "What makes it inappropriate?")) {
                        Title3(title: "It’s inappropriate")
                    }.padding(.vertical, 10)
                    
                    NavigationLink(destination: ReportingSubView(selectedItem: $dot3VM.selectedReason, items: hatefulArray, title: "What makes it violent or hateful?")) {
                        Title3(title: "It’s violent or hateful")
                    }.padding(.vertical, 10)
                    
                }.listStyle(.plain)
                    .frame(height: 200)

                LargeButton(title: "DISMISS", width: UIScreen.main.bounds.width - 40, height: 40, bColor: Color.lightBrown, fSize: 15, fColor: .white) {
                    showSheet = false
                }
                Spacer()
            }.padding(.vertical)
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                //.foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                //.background(colorScheme == .dark ? Color.black : Color.white)
        }.environmentObject(dot3VM)
            
    }
}

//struct ReportingMainView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReportingMainView()
//    }
//}
