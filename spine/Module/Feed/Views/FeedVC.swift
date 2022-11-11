//
//  FeedVC.swift
//  spine
//

import SwiftUI

struct FeedVC: View {
    @State private var selectTab:HomeHeaderTabType?
    
    var body: some View {
        VStack {
            HomeHeaderView { tabType in
                print(tabType)
                selectTab = tabType
            }
//            FeedListVC()
        }
    }
}

//struct FeedVC_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedVC()
//    }
//}

