//
//  ItemSelectionView.swift
//  spine
//
//  Created by Mac on 31/05/22.
//

import SwiftUI

protocol SelectionListItemable: Identifiable {
    var itemId: String { get set }
    var title: String { get set }
}

protocol SelectionListable: ObservableObject {
    var listItems: [any SelectionListItemable] { get set }
    var selectedItem: (any SelectionListItemable)? { get set }
    var showLoader: Bool { get set }
    var showAlert: Bool { get set }
    var searchText: String { get set }
    var alertTitle: String { get set }
    var alertMessage: String { get set }
    var navTitle: String { get }

    func getListItems()
    func didSelect(item: any SelectionListItemable, completion: @escaping (Bool) -> Void)
}

struct SelectionListView<ViewModel: SelectionListable>: View {
    @Environment(\.dismiss) var dismiss

    @StateObject var listViewModel: ViewModel

    var body: some View {
        VStack {
            CustomSearchBar(placeHolder: "Search", searchText: $listViewModel.searchText).padding(.horizontal, 5)
            VStack {
                Divider().padding(.horizontal)
                List {
                    ForEach($listViewModel.listItems, id: \.itemId) { item in
                        VStack(alignment: .leading) {
                            HStack(spacing: 10) {
//                                Image(systemName: listViewModel.selectedItem?.itemId == item.itemId.wrappedValue ? ImageName.checkmarkSquareFill : ImageName.square)
//                                    .resizable()
//                                    .frame(width: 25, height: 25)
                                Title3(title: item.title.wrappedValue)
                                Spacer()
                                if listViewModel.selectedItem?.itemId == item.itemId.wrappedValue {
                                    Image(systemName: "checkmark.circle")
                                }
                            }
                            Divider()
                        }
                        .listRowSeparator(.hidden)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            listViewModel.didSelect(item: item.wrappedValue) { shouldDismiss in
                                if shouldDismiss {
                                    dismiss()
                                }
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .onAppear(perform: { listViewModel.getListItems() })
        .modifier(LoadingView(isLoading: $listViewModel.showLoader))
        .alert(listViewModel.alertTitle, isPresented: $listViewModel.showAlert, actions: {
        }, message: {
            Text(listViewModel.alertMessage)
        })
        .navigationBarTitle(listViewModel.navTitle, displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
    }
}

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
