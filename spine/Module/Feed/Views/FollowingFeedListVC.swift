//
//  FollowingFeedListVC.swift
//  spine
//
//  Created by OM Apple on 13/05/22.
//

import SwiftUI


struct FollowingFeedListVC: View {
    
    @State var categoryList: [CategoryModel] = [CategoryModel(index: 0, name: "Test", isSubmitted: false), CategoryModel(index: 1, name: "Test2", isSubmitted: false), CategoryModel(index: 2, name: "Test1231", isSubmitted: false)]
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(self.categoryList) { items in
                        FeedListCell1(name: items.name ?? "", isSubmitted: items.isSubmitted ?? false)
                        .disabled((items.isSubmitted ?? false))
                    }
                }.padding(.top,40)
            }
        }
    }
}

struct FollowingFeedListVC_Previews: PreviewProvider {
    static var previews: some View {
        FollowingFeedListVC()
    }
}

