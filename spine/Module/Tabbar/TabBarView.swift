//
//  MainTabView.swift
//  spine


import SwiftUI

struct TabBarView: View {
//    @State private var currentView: Tab = .Ballots
    @State private var selection = 0
    @State private var showEvent = true
    
    init() {
           // UITabBar.appearance().backgroundColor = UIColor.white
        }
    
    var body: some View {
//        .navigationViewStyle(StackNavigationViewStyle())
//        .navigationBarHidden(true)
//        .edgesIgnoringSafeArea(.all)
//        NavigationView { //prash
            TabView(selection: $selection) {
//                FeedListVC()
                //FeedVC()
                FeedHomeView()
               // Text("Feed Tab")
                //PodcastHomeView()
                    .tabItem {
                        Image(ImageName.ic_home).renderingMode(.template)
                        Text("Feed")
                    }
                    .tag(0)

               // Text("Event Tab")
                //tab2View()
                 //   .font(.system(size: 30, weight: .bold, design: .rounded))
               // PodcastHomeView()

//                NavigationLink("", isActive: $showEvent) {
//                    EventsHomeView()
//                }
            
                EventsHomeView()
                    .tabItem {
                        Image(ImageName.ic_event).renderingMode(.template)
                        Text("Event")
                    }
                    .tag(1)

//                Text("Podcasts Tab")
//                    .font(.system(size: 30, weight: .bold, design: .rounded))
                 PodcastHomeView()
               // tab3View()
                    .tabItem {
                        Image(ImageName.ic_podcast).renderingMode(.template)
                        Text("Podcasts")
                    }
                    .tag(2)

                //Text("Activities Tab")
                  //  .font(.system(size: 30, weight: .bold, design: .rounded))
                ActivityView()
               //tab4View()
                    .tabItem {
                        Image(ImageName.ic_activites).renderingMode(.template)
                        Text("Activities")
                    }
                    .tag(3)
                
               // Text("Profile Tab")
//                    .font(.system(size: 30, weight: .bold, design: .rounded))
                //ProfileVC()
               // tab5View()
                MyProfileHomeView()
                    .tabItem {
                        Image(ImageName.ic_profile).renderingMode(.template)
                        Text("Profile")
                    }
                    .tag(4)
            }//.modifier(DarkModeViewModifier())
            .accentColor(K.appColors.appTheme)
                   // .navigationViewStyle(StackNavigationViewStyle())
                   // .navigationBarHidden(true)
                  //  .edgesIgnoringSafeArea(.all)
   //     }
        
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}


struct tab2View: View {
    
    var body: some View {
        ZStack(alignment: .center) {
            VStack {
                Text("vie2").frame(maxWidth: .infinity)
                Spacer()
                Text("Bottom")
                Spacer()
            }
        }
        .background(
            Image(ImageName.ic_background)
                .resizable()
                .scaleEffect()
                .edgesIgnoringSafeArea(.all)
        )
        
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct tab3View: View {
    var body: some View {
        VStack {
            Text("vie3")
            Spacer()
            Text("Bottom")
            Spacer()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct tab4View: View {
    var body: some View {
        VStack {
            Text("vie4")
            Spacer()
            Text("Bottom")
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct tab5View: View {
    var body: some View {
       
            VStack {
                Text("vie5")
                Spacer()
                Text("Bottom")
                Spacer()
            }
        .navigationBarBackButtonHidden(true)
    }
}
