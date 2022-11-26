//
//  HomeHeaderView.swift
//  spine
//
//

import SwiftUI
var data = ["Question or thought","Picture or video","Story","Event","Podcast","Ad"]


enum HomeHeaderTabType {
    case discover
    case following
}
struct HomeHeaderView: View {
    let tabTypeCompletion: (_ tabType:HomeHeaderTabType) -> ()
    @State private var selectTab:HomeHeaderTabType = .discover
    @State var halfModel_shown = false
    @State private var didSelectTab:Bool = true
    @State var doIWantThisViewToShow: Bool = false
    @State private var isEditing = false
    @State private var searchText  : String = ""
    @State private var selectedCategory = "Members"
    var searchCategory = ["Members", "Tags", "Categories","Practitioners"]
    @State var categoryToShow: Bool = false
    let color = Color.black
    @State private var preselectedIndex  : Int = 0
        
    var body: some View {
       
        ZStack {
            VStack {
                HStack {
                    Button {
                        halfModel_shown.toggle()
                    } label: {
                        Text("+")
                            .font(.system(size: 30))
                            .foregroundColor(Color.black)
                            .padding(.all, 5)
                            .padding(.leading, 10)
                    }
                    Spacer()
                    HStack {
                        VStack {
                            Button {
                                print("DISCOVER Button Pressed")
                                selectTab = .discover
                                tabTypeCompletion(selectTab)
                                self.didSelectTab = true
                            } label: {
                                SubHeader5(title: "DISCOVER")
                                    .padding(.top, 20)
                            }
                            Rectangle().frame(height: 4.0, alignment: .top)
                                .foregroundColor(K.appColors.appTheme).opacity(selectTab == .discover ? 1.0 : 0.0)
                        }
                        .frame(width:90)
                    }
                    HStack {
                        VStack {
                            Button {
                                print("FOLLOWING Button Pressed")
                                selectTab = .following
                                tabTypeCompletion(selectTab)
                                self.didSelectTab = false
                            } label: {
                                SubHeader5(title: "FOLLOWING")
                                    .padding(.top, 20)
                            }
                            
                            Rectangle().frame(height: 4.0, alignment: .top)
                                .foregroundColor(K.appColors.appTheme)
                                .opacity(selectTab == .following ? 1.0 : 0.0)
                        }
                        .frame(width:100)
                    }.padding(.leading, 10)
                    Spacer()
                    
                    Button {
                        print("Search Button Pressed")
                        doIWantThisViewToShow.toggle()
                        categoryToShow.toggle()
                        self.searchText = ""
                        UIApplication.shared.endEditing()
                    } label: {
                        Image(ImageName.ic_search)
                            .padding(.all, 5)
                            .padding(.trailing, 10)
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            VStack {
                TextField("Search", text: $searchText)
                    . onChange(of: searchText, perform: { value in
                        print(searchText)
                    })
                    .padding(14)
                    .background(Color(.white))
                    .cornerRadius(6)
                    .onTapGesture {
                        self.isEditing = true
                    }
                    .shadow(radius: 12)
                    .padding([.top,.trailing,.leading],40)
                    .opacity(doIWantThisViewToShow ? 1 : 0)
                
                if isEditing {
                    Button(action: {
                        self.isEditing = false
                        self.searchText = ""
                        
                    }) {
                        // Image("ic_search")
                        //.padding(.all, 5)
                        // .padding(.trailing, 10)
                        
                    }
                    //.padding(.trailing, 10)
                    //.transition(.move(edge: .trailing))
                    //.animation(.default)
                }
                HStack(spacing: 0) {
                            ForEach(searchCategory.indices, id:\.self) { index in
                                ZStack {
                                    Rectangle()
                                        .fill(color.opacity(0.0))
                                    Rectangle()
                                        .fill(color)
                                        .cornerRadius(17)
                                        .padding([.leading,.trailing],5)
                                        .opacity(preselectedIndex == index ? 1 : 0.01)
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
                                        .foregroundColor(preselectedIndex == index ? Color.white : Color.black)
                                        
                                ).opacity(categoryToShow ? 1 : 0)
                                
                            }
                        }
                        .frame(height: 34)
                        .cornerRadius(17)
                
            }
            
                           
                          
                 
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
            .frame(height:50)
           
            
        }
//        if searchCategory[preselectedIndex] == "Members" {
//            memberListView()
//        } else if searchCategory[preselectedIndex] == "Tags" {
//            memberListView()
//        } else if searchCategory[preselectedIndex] == "Tags" {
//            memberListView()
//        } else {
//            
//        }
        if(didSelectTab == true){
            FeedListVC()
        }else{
            FeedFollowingVC()
        }
        if halfModel_shown {
            addFeedPopup(halfModel_shown: $halfModel_shown)
        }
    }
}
extension HomeHeaderView {
    func addButtonClick() {
        print("Pluse Button Pressed")
        halfModel_shown.toggle()
        // addFeedPopup(halfModel_shown: $halfModel_shown)
    }
}
struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView { tabType in
            print(tabType)
        }
    }
}


struct CustomDivider: View {
    let height: CGFloat = 5
    let color: Color
    let opacity: Double = 1
    
    var body: some View {
        Group {
            Rectangle()
        }
        .frame(height: height)
        .foregroundColor(color)
        .opacity(opacity)
    }
}

struct CustomDotView: View {
    var height: CGFloat = 20
    var color: Color = Color.orange1
    
    var body: some View {
        Group {
            Rectangle()
        }
        .frame(width:height, height: height)
        .foregroundColor(color)
        .cornerRadius(height)
    }
}

//struct CustomDotView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomDotView()
//    }
//}

struct FeedFollowingVC: View {
    var body: some View {
        ScrollView(.vertical){
            VStack{
                FollowingFeedListVC()
            }
        }
    }
}

struct addFeedPopup:View{
    @Binding var halfModel_shown:Bool
    
    var body: some View{
        
        
        CustomHalfSheetsUIView(isShown: $halfModel_shown){
            
            VStack{
                Rectangle()
                    .frame(width: 200, height: 10, alignment: .center)
                    .foregroundColor(Color.init(red: 0.2, green: 0.2, blue: 0.2, opacity: 0.2))
                    .cornerRadius(10)
                    .shadow(radius: 0.4)
                
                Text("ADD")
                    .font(AppUtility.shared.appFont(type: .Bold, size: 18))
                
                List(0..<1) { item in
                    ForEach(data.indices, id:\.self){x in
                        VStack{
                            CardView(filter: data[x])
                                .font(AppUtility.shared.appFont(type: .regular, size: 16))
                        }
                        
                    }
                    
                }
                .listStyle(.plain)
                .padding(.top,10)
                
            }
            
        }
    }
}

struct CardView:View{
    @State var filter:String = "hello"
    
    var body: some View{
        HStack{
            Text(filter)
                .font(AppUtility.shared.appFont(type: .regular, size: 16))
                .foregroundColor(Color.black.opacity(0.7))
                .padding()
            Spacer()
            ZStack{
                Image(ImageName.ic_rightarrow)
                    .padding()
            }
        }
        .padding(.horizontal)
    }
}



struct memberListView: View {
    var body: some View {
        VStack {
            List(0..<2){items in
                
                ForEach(memberimg,id:\.self){x in
                    
                    HStack {
                        
                        Image(x)
                            .resizable()
                            .scaledToFill()
                        //.frame(minWidth: 0, maxWidth: .infinity,minHeight: 60)
                            .frame(width: 70, height: 70, alignment: .center)
                            .cornerRadius(35)
                            .shadow(color: Color.primary.opacity(0.3), radius: 1)
                            .overlay(
                                RoundedRectangle(cornerRadius: 35).stroke(K.appColors.appTheme, lineWidth: 5)
                                
                            )
                            .padding(.top,5)
                            .onTapGesture {
                                DispatchQueue.main.async { // maybe even with some delay
                                    //   self.isActive = true
                                }
                            }
                        VStack {
                            Title4(title: "Craig Warner")
                                .padding(.bottom,5)
                            Title5(title: "Lorem Ipsum", fColor: .gray)
                                .padding(.bottom,5)
                        }
                        .padding()
                        Button {
                            print("Button tapped!")
                        } label: {
                            Title4(title: "+ FOLLOWING", fColor: .white)
                            .frame(width: 110,height:40)
                                .background(K.appColors.appTheme)
                                .cornerRadius(20)
                                .padding(.leading,20)
                        }
                        
                    }
                }
            }
            .listStyle(.plain)
        }
        
    }
}

struct CustomView<Content: View, IsShowingContent: View>: View {
    
    let isShowing: Bool
    @ViewBuilder let content: () -> Content
    @ViewBuilder let isShowingContent: () -> IsShowingContent
    
    var body: some View {
        
        Group {
            
            if isShowing { ZStack { content().blur(radius: isShowing ? 5.0 : 0.0); isShowingContent() } }
            else { content() }
 
        }
        .animation(.default, value: isShowing)
        
    }
}
