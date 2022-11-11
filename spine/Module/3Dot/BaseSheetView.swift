//
//  BaseSheetView.swift
//  spine
//
//  Created by Mac on 27/08/22.
//

import SwiftUI

struct BaseSheetView: View {
    @Binding var showSheet: Bool
    @Binding var type: Post3DotOption
    var body: some View {
        if type == .reoprtPost {
            ReportingMainView(showSheet: $showSheet)
        } else {
            HidePostView()
        }
    }
}

//struct BaseSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        BaseSheetView()
//    }
//}
