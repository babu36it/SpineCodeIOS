//
//  ReportConfirmationView.swift
//  spine
//
//  Created by Mac on 24/08/22.
//

import SwiftUI

struct ReportConfirmationView: View {
    @EnvironmentObject var dot3VM: Dot3ViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Capsule()
                .frame(width: 60, height: 4).foregroundColor(.gray).padding()
            VStack {
                SubHeader4(title: "Thanks for letting us know")
                Divider().padding(.horizontal)
            }
            
            LargeCheckMark()
            Title3(title: "Your feedback is important in helping us to keep the Spiritual Network community safe and its content in line with the Community Guidelines. ").multilineTextAlignment(.center).padding()
            Spacer()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}
struct ReportConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ReportConfirmationView()
    }
}
