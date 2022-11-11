//
//  ReportingSubView.swift
//  spine
//
//  Created by Mac on 24/08/22.
//

import SwiftUI

enum ReportingType {
    case post
    case user
}

struct ReportingSubView: View {
    @Binding var selectedItem: String
    let items: [String]
    let title: String
    var type: ReportingType = .post
    @EnvironmentObject var dot3VM: Dot3ViewModel
    @Environment(\.dismiss) var dismiss
    @State var showReportReason = false
    
    var body: some View {
        
        VStack(spacing: 20) {
            Capsule()
                .frame(width: 60, height: 4).foregroundColor(.gray)
                .padding(.top)
            SubHeader4(title: title)
            List {
                ForEach(items, id: \.self) { item in
                    HStack {
                        Image(systemName: item == selectedItem ? ImageName.checkmarkCircle: ImageName.circle)
                            .font(Font.title2.weight(.light))//.font(.title2)
                        Title3(title: item)
                    }.onTapGesture {
                        selectedItem = item
                    }
                }
                
            }.listStyle(.plain)
               // .frame(height: 280)
            LargeButton(disable: selectedItem == "", title: "NEXT", width: UIScreen.main.bounds.width - 40, height: 40, bColor: Color.lightBrown, fSize: 15, fColor: .white) {
                showReportReason = true
            }
            
            Button("BACK") {
                selectedItem = ""
                self.dismiss()
            }.foregroundColor(.primary)
            
            NavigationLink(isActive: $showReportReason) {
                ReportReasonView(helpText: type == .post ? generalReportGuide : userReportGuide)
            } label: {
                EmptyView()
            }

        }//.padding(.vertical)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        //.ignoresSafeArea(.all, edges: .bottom)
        //.background(.red)
    }
}


//struct ReportingSubView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReportingSubView()
//    }
//}
