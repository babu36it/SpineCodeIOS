//
//  ItemSelectionView.swift
//  spine
//
//  Created by Mac on 31/05/22.
//

import SwiftUI

struct ItemSelectionView: View {
    @Binding var selectedItem: String
    let itemType: ItemType
    let items = ["Item1", "Item2", "Item3","Item4", "Item5"]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 30) {
            GradientDivider().padding(.top, 10)
            VStack {
                Divider().padding(.horizontal)
                List {
                    ForEach(items, id: \.self) { item in
                        VStack(alignment: .leading) {
                            Title3(title: item)
                            Divider()
                        }
                        .listRowSeparator(.hidden)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedItem = item
                            dismiss()
                        }
                    }
                }.listStyle(.plain)
            }
        }
        .navigationBarTitle("SELECT \(itemType.rawValue.uppercased())", displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
    }
}


struct SingleItemSelectionView: View {
    @Binding var selectedItem: ItemModel?
    let itemType: ItemType
    let items: [ItemModel]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 30) {
            GradientDivider().padding(.top, 10)
            VStack {
                Divider().padding(.horizontal)
                List {
                    ForEach(items) { item in
                        VStack(alignment: .leading) {
                            Title3(title: item.name)
                            Divider()
                        }
                        .listRowSeparator(.hidden)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedItem = item
                            dismiss()
                        }
                    }
                }.listStyle(.plain)
            }
            
        }
        .navigationBarTitle("SELECT \(itemType.rawValue.uppercased())", displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
    }
}
