//
//  TutorialView.swift
//  spine


import SwiftUI

struct TutorialView: View {
    
    @State var index = 0
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                //            Rectangle().fill().foregroundColor(K.appColors.appTheme)
                PageView(index: $index) {
                    PageView.Page { AnyView(
                        ZStack {
                            VStack {
                                Spacer()
                                SpineTextView().padding(.bottom, 100)
                                Text("The Spiritual Network").font(AppUtility.shared.appFont(type: .regular, size: 18))
                                    .foregroundColor(.white)
                                    .padding(.bottom, 160)
                            }
                        }
                            .background(Image("ic_spine_logo").padding(.bottom, 80))
                    )}
                    PageView.Page { AnyView(
                        ZStack {
                            VStack(alignment: .center, spacing: 20) {
                                Text("DEINE DIGITALE HEIMAT").font(AppUtility.shared.appFont(type: .Bold, size: 20))
                                    .foregroundColor(.white)
                                Text("Hier, sind wir untereinander.\neine Gemeinschaft, die dich dafür liebt,\ndass Du Deine Individualität lebst.\n\neine Gemeinschaft, die verstanden hat, dass Entfaltung nur im Vertrauen geschieht.\n\nEine Gemeinschaft, die einander hilft.")
                                    .font(AppUtility.shared.appFont(type: .regular, size: 16))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                Text("The Spiritual Network").font(AppUtility.shared.appFont(type: .regular, size: 16)).padding()
                                    .foregroundColor(.white)
                                Text("Hier sind unsere Regein für ein \nrespektvolles Miteinander").font(AppUtility.shared.appFont(type: .regular, size: 16)).padding()
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                            }
                        }
                    )}
                    PageView.Page { AnyView(
                        ZStack {
                            VStack(alignment: .center, spacing: 20) {
                                Text("HASS HAT HAUSARREST").font(AppUtility.shared.appFont(type: .Bold, size: 20))
                                    .foregroundColor(.white)
                                Text("Hift uns gemeinsam, eine starke \nGemeinschaftaufzubauen.\n\nSei freundlich, höflich undhilfbereit.\n\nLass uns alle einander mit Respekt behandeln.\n\nRespektlose Kommentare werden sofort\ngelöscht und wir bittendich, jeglichen Verstoß\nsofort zu melden, umandere zu schützen.").font(AppUtility.shared.appFont(type: .regular, size: 16))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                            }.padding(.top, -130)
                        }
                    )}
                    PageView.Page { AnyView(
                        ZStack {
                            VStack(alignment: .center, spacing: 20) {
                                Text("ENTFALTUNG BRAUCHT\n          VERTRAUEN").font(AppUtility.shared.appFont(type: .Bold, size: 20))
                                    .foregroundColor(.white)
                                Text("Lass Zensur und regionale Beschränkungen\n hinter dir.\n\n Diese Gemeinschaft trät die Verantwortung für sich, nicht wir und wir verkaufen dafür Deine Daten nicht an Dritte.").font(AppUtility.shared.appFont(type: .regular, size: 16))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                            }.padding(.top, -190)
                        }
                    )}
                    PageView.Page { AnyView(
                        ZStack {
                            VStack(alignment: .center, spacing: 20) {
                                Text("HIER BIN ICH MENSCH HIRE \n DARF ICH GANZ ICH SEIN").font(AppUtility.shared.appFont(type: .Bold, size: 20))
                                    .foregroundColor(.white)
                                Text("Wir definieren uns nicht über Likes anderer, sondern über unser Wirken für die Gemeinschaft.\nDaher findest Du bei uns keine Anzeige deiner Likes. \n\n Anonyme Konten werden sofort gelöscht.").font(AppUtility.shared.appFont(type: .regular, size: 16))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                            }.padding(.top, -170)
                        }
                    )}
                    PageView.Page { AnyView(
                        ZStack {
                            VStack {
                                Spacer()
                                SpineTextView().padding(.bottom, 40)
                                
                                NavigationLink(destination: RegisterVC()) {
                                    Text("REGISTER")
                                        .font(AppUtility.shared.appFont(type: .regular, size: 18))
                                        .frame(width: 250, height: 45, alignment: .center)
                                        .foregroundColor(K.appColors.appTheme)
                                        .background(Color.white)
                                        .cornerRadius(
                                            30).padding(.bottom, 10)
                                        .navigationTitle("")
                                        .navigationBarTitleDisplayMode(.inline)
                                }
                                
                                NavigationLink(destination: LoginVC()) {
                                    Text("LOGIN")
                                        .font(AppUtility.shared.appFont(type: .regular, size: 18))
                                        .frame(width: 250, height: 45, alignment: .center)
                                        .foregroundColor(K.appColors.appTheme)
                                        .background(Color.white)
                                        .cornerRadius(
                                            30).padding(.bottom, 100)
                                        .navigationTitle("")
                                        .navigationBarTitleDisplayMode(.inline)
                                }
                            }
                        }.background(Image("ic_spine_logo").padding(.bottom, 80))
                    )}
                }
                HStack(spacing: 0) {
                    ForEach(0..<6) { index in
                        BottomIndicatorView { self.index = index }
                        .foregroundColor(.white)
                        .modifier(IndicatorModifier(index: index, currentIndex: self.$index))
                    }
                }.padding(.bottom, 60).disabled(true)
            }.ignoresSafeArea(.container, edges: [.bottom, .top])
                .background(
                    Image("ic_launchBG")
                        .resizable()
                        .scaleEffect()
                        .edgesIgnoringSafeArea(.all)
                )
        }        
    }
    func buttonLoginAction(){
        //do write here your button action logic
        print("buttonLoginAction")
        AppUtility.shared.redirectToLoginScreen()
        
    }
    func buttonRegisterAction(){
        //do write here your button action logic
        print("buttonRegisterAction")
        AppUtility.shared.redirectToRegisterScreen()
          
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}

struct SpineTextView: View {
    var body: some View {
        HStack {
            Text("S").padding(.trailing, 12).font(AppUtility.shared.appFont(type: .Bold, size: 24))
            Text("P").padding(.trailing, 12).font(AppUtility.shared.appFont(type: .Bold, size: 24))
            Text("I").padding(.trailing, 12).font(AppUtility.shared.appFont(type: .Bold, size: 24))
            Text("N").padding(.trailing, 12).font(AppUtility.shared.appFont(type: .Bold, size: 24))
            Text("E").padding(.trailing, 12).font(AppUtility.shared.appFont(type: .Bold, size: 24))
        }.foregroundColor(.white)
    }
}

struct BottomIndicatorView: View {
    var action: () -> Void
    var body: some View {
        Button(action: { withAnimation { self.action() } }) {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 24, height: 24)
                Circle().fill().frame(width: 8, height: 12)
            }
        }
    }
}

struct IndicatorModifier: ViewModifier {
    let index: Int
    @Binding var currentIndex: Int
    
    func body(content: Content) -> some View {
        content.opacity(index == currentIndex ? 1.0 : 0.5)
    }
}


