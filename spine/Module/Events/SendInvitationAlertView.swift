//
//  SendInvitationAlertView.swift
//  spine
//
//  Created by Mac on 24/06/22.
//

import SwiftUI

struct SendInvitationAlertView: View {
    @Binding var showAdd: Bool
    @Binding var inviteSent: Bool
    let screenWidth = UIScreen.main.bounds.width - 60
    @State var commentTxt = "Type a message"
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 100)
            
            VStack {
                Button {
                    self.showAdd.toggle()
                } label: {
                    Image(systemName: ImageName.multiply)
                        .font(.title)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(30)
                ZStack {
                    Rectangle()
                    VStack(spacing: 20) {
                        Header2(title: "I'd like to join!")
                        Header5(title: "Yoga Weekend Retreat")
                        Title4(title: "09 May - 11 May 2020")
                        CustomTextEditorEditable(text: $commentTxt, height: 80)
                            .padding(.horizontal, 20)
                        LargeButton(title: "SEND", width: 80, height: 30, bColor: .lightBrown, fSize: 12, fColor: .white) {
                            self.showAdd.toggle()
                            inviteSent = true
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 20)
                    }.foregroundColor(.black)
                }.border(.white, width: 2, cornerRadius: 10) //dark mode
                .frame(width: screenWidth, height: screenWidth - 20, alignment: .center)
                .cornerRadius(10)
                .foregroundColor(colorScheme == .dark ? .black : .white)
            }
            
            .offset(y: self.showAdd ? 0: UIScreen.main.bounds.height)
            Spacer()
            // Spacer()
            
        }.background((self.showAdd ? Color.black.opacity(0.6) : Color.clear).onTapGesture {
            //self.showAdd.toggle()
        }).edgesIgnoringSafeArea(.all)
            
    }
}

//struct SendInvitationAlertView_Previews: PreviewProvider {
//    static var previews: some View {
//        SendInvitationAlertView()
//    }
//}

struct SendInvitationOnlineMeta: View {
    @Binding var showAdd: Bool
    @Binding var inviteSent: Bool
    let screenWidth = UIScreen.main.bounds.width - 60
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 100)
            
            VStack {
                Button {
                    self.showAdd.toggle()
                } label: {
                    Image(systemName: ImageName.multiply)
                        .font(.title)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(30)
                ZStack {
                    Rectangle()
                    VStack(spacing: 25) {
                        Header2(title: "I'd like to join!")
                        VStack(spacing: 8) {
                            Header5(title: "Sahaja Yoga online meditation")
                            Title4(title: "Sat, 09 May 2020, 18:00")
                        }
                        Title4(title: "Once the host accepts your request, the link to the event is shared with you.")
                            .multilineTextAlignment(.center)
                        
                        LargeButton(title: "SEND REQUEST TO HOST", width: 180, height: 30, bColor: .lightBrown, fSize: 12, fColor: .white) {
                            self.showAdd.toggle()
                            inviteSent = true
                        }
                        
                    }.foregroundColor(.black)
                        .padding()
                        .padding(.horizontal, 20)
                }.border(.white, width: 2, cornerRadius: 10) //dark mode
                .frame(width: screenWidth, height: screenWidth - 20, alignment: .center)
                .cornerRadius(10)
                .foregroundColor(colorScheme == .dark ? .black : .white)
            }
            
            .offset(y: self.showAdd ? 0: UIScreen.main.bounds.height)
            Spacer()
            // Spacer()
            
        }.background((self.showAdd ? Color.black.opacity(0.6) : Color.clear).onTapGesture {
            //self.showAdd.toggle()
        }).edgesIgnoringSafeArea(.all)
            
    }
}


struct SendMessageAlert: View {
    @Binding var showAdd: Bool
    //var sendTapped: ()-> Void
    let screenWidth = UIScreen.main.bounds.width - 60
    @State var commentTxt = "Dear host Oliver, I'd like to join your event"
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 150)
            ZStack(alignment: .top){
                ZStack {
                    Rectangle()
                    VStack(spacing: 25) {
                        Title2(title: "Oliver Reese")
                            .padding(.top, 50)
                        CustomTextEditorEditable(text: $commentTxt, height: 120)
                        
                        HStack {
                            LargeButton(title: "CANCEL", width: 80, height: 30, bColor: .lightBrown, fSize: 12, fColor: .white) {
                                self.showAdd.toggle()
                            }
                            Spacer()
                            LargeButton(title: "SEND", width: 80, height: 30, bColor: .lightBrown, fSize: 12, fColor: .white) {
                                self.showAdd.toggle()
                            }
                        }
                    }.foregroundColor(.black)
                        .padding()
                }
                .frame(width: screenWidth, height: screenWidth - 20, alignment: .center)
                .cornerRadius(10)
                .foregroundColor(colorScheme == .dark ? .black : .white)
                .frame(maxWidth: .infinity)
                CircularBorderedProfileView(image: "Oval 57", size: 120, borderWidth: 5, showShadow: true)
                    .offset(y: -60)
            }
            .offset(y: self.showAdd ? 0: UIScreen.main.bounds.height)
            Spacer()
        }.background((self.showAdd ? Color.black.opacity(0.6) : Color.clear)).edgesIgnoringSafeArea(.all)
            
    }
}




struct GoingYesNoView: View {
    @Binding var showAdd: Bool
    @State private var selectedColorIndex = 0
    let screenWidth = UIScreen.main.bounds.width - 60
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 100)
            
            VStack {
                Button {
                    self.showAdd.toggle()
                } label: {
                    Image(systemName: ImageName.multiply)
                        .font(.title)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(30)
                ZStack {
                    Rectangle()
                    VStack(spacing: 25) {
                        Header2(title: "Going?")
                        
                       // VStack {
                                    Picker("Favorite Color", selection: $selectedColorIndex, content: {
                                        Text("No").tag(0)
                                            //.frame(height: 100)
                                        Text("Yes").tag(1)
                                           // .frame(height: 100)
                                    })
                                .pickerStyle(.segmented) // <1>
                                //.frame(height: 80)
                                  //  Text("Selected color: \(selectedColorIndex)")
                          //      }
                        
                        LargeButton(title: "UPDATE", width: screenWidth - 40, height: 30, bColor: .lightBrown, fSize: 12, fColor: .white) {
                            self.showAdd.toggle()
                            
                        }
                        
                    }.foregroundColor(.black)
                        .padding()
                        .padding(.horizontal, 20)
                }
                .frame(width: screenWidth, height: screenWidth/1.5, alignment: .center)
                .cornerRadius(10)
                .foregroundColor(colorScheme == .dark ? .black : .white)
            }
            
            .offset(y: self.showAdd ? 0: UIScreen.main.bounds.height)
            Spacer()
            
        }.background((self.showAdd ? Color.black.opacity(0.6) : Color.clear)).edgesIgnoringSafeArea(.all)
            
    }
}


struct GoingAlert: View {
    @Binding var showAdd: Bool
    let screenWidth = UIScreen.main.bounds.width - 60
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 100)
            
            VStack {
                Button {
                    self.showAdd.toggle()
                } label: {
                    Image(systemName: ImageName.multiply)
                        .font(.title)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(30)
                ZStack {
                    Rectangle()
                    VStack(spacing: 25) {
                        Header2(title: "You're going!")
                        VStack(spacing: 8) {
                            Header5(title: "Sahaja Yoga online meditation")
                            Title4(title: "Sat, 09 May 2020, 18:00")
                        }
                        
                        Title4(title: "The link to join the online event is now available on the event screen for you.")
                            .multilineTextAlignment(.center)
                        
                        LargeButton(title: "FORWARD TO A FRIEND", width: 180, height: 30, bColor: .lightBrown, fSize: 12, fColor: .white) {
                            self.showAdd.toggle()
                        
                        }
                        Title5(title: "ADDED TO YOUR CALENDER", fColor: .lightBlackText)
                        
                    }.foregroundColor(.black)
                        .padding()
                        .padding(.horizontal, 20)
                }
                .frame(width: screenWidth, height: screenWidth - 20, alignment: .center)
                .cornerRadius(10)
                .foregroundColor(colorScheme == .dark ? .black : .white)
            }
            
            .offset(y: self.showAdd ? 0: UIScreen.main.bounds.height)
            Spacer()
            
        }.background((self.showAdd ? Color.black.opacity(0.6) : Color.clear)).edgesIgnoringSafeArea(.all)
            
    }
}


struct GoingYesNoView_Previews: PreviewProvider {
    static var previews: some View {
        GoingYesNoView(showAdd: .constant(true))
    }
}
