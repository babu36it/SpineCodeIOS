//
//  StoriesImpluseVC.swift
//  spine
//
//  Created by OM Apple on 27/05/22.
//


import SwiftUI

struct StoriesImpluseVC: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isActive = false
   
    @State var categoryList: [CategoryModel] = [CategoryModel(index: 0, name: "Test", isSubmitted: false), CategoryModel(index: 1, name: "Test2", isSubmitted: false), CategoryModel(index: 2, name: "Test1231", isSubmitted: false)]
    
    var body: some View {
        VStack {
            HStack {
            Button(action: {
                      self.presentationMode.wrappedValue.dismiss()
                   }) {
                       Image(ImageName.ic_back)
                           .renderingMode(.template)
                                         .foregroundColor(.black)
                                          .aspectRatio(contentMode: .fit)
                                          .padding(.leading, -5)
                   }
                   .navigationBarHidden(true)
            Spacer()
            Text("STORIES IMPULSES")
                .font(AppUtility.shared.appFont(type: .regular, size: 20))
                .padding(.leading,10)
            Spacer()
                Button(action: {
                          print("Follow")
                       }) {
                           Text("+ Follow")
                               .font(AppUtility.shared.appFont(type: .Bold, size: 16))
                               .foregroundColor(K.appColors.appTheme)
                       }
        }
        .frame(width: UIScreen.main.bounds.width-40)
        .padding(.top,10)
        Text("Inspirational thoughts and wisdom to encourage…")
            .foregroundColor(Color.gray)
            .font(AppUtility.shared.appFont(type: .regular, size: 16))
            .padding(.all,10)
            .multilineTextAlignment(.center)
            ScrollView {
               
                LazyVStack {
                
                    ForEach(self.categoryList) { items in
                        StoriesImpluseCell(name: items.name ?? "", isSubmitted: items.isSubmitted ?? false)
                        .disabled((items.isSubmitted ?? false))
                    }
                    
                }.padding(.top)
            }
        }
    }
}

struct StoriesImpluseVC_Previews: PreviewProvider {
    static var previews: some View {
        StoriesImpluseVC()
    }
}
