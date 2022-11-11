//
//  FeedListVC.swift
//  spine
//
//

import SwiftUI

struct FeedListVC: View {
    
    @State var categoryList: [CategoryModel] = [CategoryModel(index: 0, name: "Test", isSubmitted: false), CategoryModel(index: 1, name: "Test2", isSubmitted: false), CategoryModel(index: 2, name: "Test1231", isSubmitted: false)]
    
    var body: some View {
        
       VStack {
            ScrollView {
                FeedHeaderView().padding(.top, 10)
                LazyVStack {
                    
                    ForEach(self.categoryList) { items in
                        FeedListCell1(name: items.name ?? "", isSubmitted: items.isSubmitted ?? false)
                        //.disabled((items.isSubmitted ?? false))
                    }
                }.padding(.top)
            }
        }
    }
}

struct FeedListVC_Previews: PreviewProvider {
    static var previews: some View {
        FeedListVC()
    }
}
