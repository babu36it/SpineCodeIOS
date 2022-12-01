//
//  MainTabView.swift
//  spine


import SwiftUI

struct TabBarView: View {
    @State private var selection = 0
    @State private var showEvent = true

    var handler: Binding<Int> { Binding(
        get: { self.selection },
        set: {
            if $0 == self.selection {
                print("Reset here!!")
                if self.selection == 1 { // event home
                    eventHomeView.updateSelectedTab(.none)
                }
            }
            self.selection = $0
        }
    )}

    var body: some View {
        TabView(selection: handler) {
            FeedHomeView()
                .tabItem {
                    Image(ImageName.ic_home).renderingMode(.template)
                    Text("Feed")
                }
                .tag(0)
            
            eventHomeView
                .tabItem {
                    Image(ImageName.ic_event).renderingMode(.template)
                    Text("Event")
                }
                .tag(1)
            
            PodcastHomeView()
                .tabItem {
                    Image(ImageName.ic_podcast).renderingMode(.template)
                    Text("Podcasts")
                }
                .tag(2)
            
            ActivityView()
                .tabItem {
                    Image(ImageName.ic_activites).renderingMode(.template)
                    Text("Activities")
                }
                .tag(3)
            
            MyProfileHomeView()
                .tabItem {
                    Image(ImageName.ic_profile).renderingMode(.template)
                    Text("Profile")
                }
                .tag(4)
        }
        .accentColor(K.appColors.appTheme)
    }
    
    private let eventHomeView: EventsHomeView = {
        EventsHomeView()
    }()
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
