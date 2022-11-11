//
//  SubCategoryView.swift
//  spine
//
//  Created by Mac on 14/06/22.
//

import SwiftUI

enum AlertErrorMsg: String, Identifiable {
    var id: String {
        rawValue
    }
    case invalidLength = "Please enter ateast 3 characters "
    case duplicate = "Subcategory already exist"
}

struct SubCategoryView: View {
    let mainCategory: ItemModel
    @Binding var categories: [ItemModel]
    @Binding var selectedCategories: [ItemModel]
    @State var showAdditionalCatg = false
    @State var newCategory = ""
    @State var alertMsg: AlertErrorMsg?
    var addTapped: (String)-> Void
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading) {
                Header5(title: "Choose up to 3 sub-categories of\n\(mainCategory.name)")
                ButtonGrid(categories: $categories, tempSelections: $selectedCategories)
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Button {
                        showAdditionalCatg.toggle()
                    } label: {
                        Image(systemName: showAdditionalCatg ? ImageName.minusCircle : ImageName.plusCircle)
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    Title4(title: "Add an additional category")
                    Spacer()
                }.foregroundColor(.lightBrown)
                
                if showAdditionalCatg {
                    HStack {
                        CustomTextField2(searchText: $newCategory, placeholder: "Enter a new category")
                        LargeButton(title: "ADD", width: 70, height: 30, bColor: Color.lightBrown, fSize: 12, fColor: .white) {
                            if newCategory.count > 2 {
                                if !(categories.map {$0.name}.contains(newCategory)) {
                                   // categories.insert(newCategory, at: 0)
                                    addTapped(newCategory)
                                    newCategory = ""
                                } else {
                                    //alertMsg = .duplicate
                                    ShowToast.show(toatMessage: "Subcategory already exist")
                                }
                            } else {
                                //alertMsg = .invalidLength
                                ShowToast.show(toatMessage: "Please enter ateast 3 characters")
                            }
                        }
                    }
                }
            }
        }
        .alert(item: $alertMsg) { item in
            Alert(title: Text(item.rawValue), message: Text(""), dismissButton: .cancel())
        }
    }
}

struct ButtonGrid: View {
    @Binding var categories: [ItemModel]
    @Binding var tempSelections: [ItemModel]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            LazyVGrid(columns: Array(repeating: .init(.fixed(120)), count: 3)) {
                ForEach(categories) { item in
                    let isOn = self.tempSelections.map{$0.name + $0.id}.contains(item.name + item.id)
                    Button {
                        if self.tempSelections.map({ $0.name + $0.id }).contains(item.name + item.id) {
                            self.tempSelections.removeAll(where: { $0.name == item.name && $0.id == item.id })
                        } else {
                            if self.tempSelections.count < 3 {
                                self.tempSelections.append(item)
                            }
                        }
                    } label: {
                        Text(item.name)
                            .font(.Poppins(type: .regular, size: 12))
                            .frame(width: 110, height: 35)
                            .foregroundColor(isOn ? .white : .lightBrown)
                            .background(isOn ? Color.lightBrown : .white)
                            .cornerRadius(20)
                            .border(Color.lightBrown, width: 0.7, cornerRadius: 20)
                            .padding(3)
                    }
                }
            }
        }.frame(maxHeight: 200)
       
    }
}

//struct SubCategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        SubCategoryView()
//    }
//}
