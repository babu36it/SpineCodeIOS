//
//  FeedSearchVC.swift
//  spine
//
//  Created by OM Apple on 01/07/22.
//

import SwiftUI

struct FeedSearchVC: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @State var searchText = ""
    @State private var selectedCategory = "Members"
    var searchCategory = ["Members", "Tags", "Categories","Practitioners"]
    @State var categoryToShow: Bool = false
    let color = Color.primary
    @State private var preselectedIndex  : Int = 0
    @State var showPractitioners = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                    
                    HStack {
                        /*
                        CustomButton(image: "AddMenu") {
                           self.showAdd.toggle()
                        }
                         */
                        CustomSearchBar(placeHolder: "Search", searchText: $searchText).padding(.horizontal, 5)
                        Spacer()
                        ButtonWithSystemImage(image: ImageName.multiply, size: 18) {
                            dismiss()
                        }
                    }.padding(.horizontal)
                    
                    HStack(spacing: 0) {
                        ForEach(searchCategory.indices, id:\.self) { index in
                            ZStack {
                                //Rectangle()
                                //    .fill(color.opacity(0.0))
                                Rectangle()
                                    .fill(color)
                                    .cornerRadius(17)
                                    .padding([.leading,.trailing],5)
                                    .opacity(preselectedIndex == index ? 1 : 0.1)
                                    .onTapGesture {
                                        withAnimation(.interactiveSpring()) {
                                            preselectedIndex = index
                                            print(searchCategory[preselectedIndex])
                                            
                                            
                                        }
                                    }
                            }
                            .overlay(
                                Text(searchCategory[index])
                                    .font(AppUtility.shared.appFont(type: .regular, size: 12))
                                    //.foregroundColor(preselectedIndex == index ? Color.white : Color.black)
                                    .foregroundColor(preselectedIndex == index ? (colorScheme == .dark ? Color.black : Color.white) : (colorScheme == .dark ? Color.white : Color.black))
                                
                            )//.opacity(categoryToShow ? 1 : 0)
                            
                        }
                    }
                    .frame(height: 34)
                    .cornerRadius(17)
                    
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                    .frame(height:50)
                    if searchCategory[preselectedIndex] == "Members" {
                        SearchMembersListView()
                    } else if searchCategory[preselectedIndex] == "Tags" {
                        SearchTagListVC()
                    } else if searchCategory[preselectedIndex] == "Categories" {
                        SearchCategoriesVC()
                    } else {
                       // PractitionersDetailsView()
                        SearchPracticionerListView()
                        
                    }
                }.padding(.top, 0)
            
        }
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $showPractitioners) {
            FilterPodcastView()
        }
        
    }
}

//struct FeedSearchVC_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedSearchVC()
//    }
//}


struct SearchMembersListView: View {
    @State private var isActive = false
    var body: some View {
        VStack {
           // NavigationLink(destination: MemberGalleryVC(), isActive: self.$isActive){ }
            List {
                ForEach(attendeeLst, id: \.self) { attendee in
                    VStack {
                        FollowerRow(attendee: attendee)
                        Divider().opacity(0.3)
                    }
                    .listRowSeparator(.hidden)
                }
            }.listStyle(.plain)
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

//struct SearchMemberListVC_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchMemberListV()
//
//    }
//}
var tagData = ["#lamborghini","#lamborghiniaventador","#lamborghinihuracan","#lamborghinigallardo","#lamborghiniveneno","#lamborghiniaventador","#lamborghini"]



struct SearchTagListVC: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isActive = false
    
    var body: some View {
        VStack {
            
            List(0..<2){items in
                ForEach(tagData,id:\.self){ tag in
                    HStack {
                        Text("#").padding(5)
                            .foregroundColor(Color.gray)
                            .font(AppUtility.shared.appFont(type: .regular, size: 20))
                           // .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 5))
                         VStack(alignment: .leading, spacing: 0) {
                             SubHeader5(title: tag)
                                 .padding(.top,7)
                            
                             Title5(title: "2,241 posts", fColor: .gray)
                                .padding(.bottom,7)
                              //  .multilineTextAlignment(.leading)
                        }
                    }
                }
            }
            .listStyle(.plain)
        }.navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
    }
}

struct SearchCategoriesVC: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
           
            List {
                ForEach(CatData, id:\.self){ tag in
                    HStack {
                        Title4(title: tag, fColor: .white).padding(10)
                            .frame(minWidth: 60, maxWidth: .infinity,minHeight: 15)
                            .background(K.appColors.appTheme)
                            .cornerRadius(30)
                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 5))
                            .fixedSize(horizontal: true, vertical: false)
                        Spacer()
                        Title4(title: "+FOLLOW", fColor: K.appColors.appTheme)
                    }
                    //.padding(.horizontal, 20)
                    //.listRowSeparator(.hidden)
                }
            }.listStyle(.plain)
        } .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
    }
}


//struct PractitionersDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PractitionersDetailsView()
//    }
//}

struct SearchPracticionerListView: View {
    var body: some View {
        List {
            ForEach(attendeeLst, id: \.self) { attendee in
                PracticionerCell(attendee: attendee)
            }
        }.listStyle(.plain)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
    }
}
