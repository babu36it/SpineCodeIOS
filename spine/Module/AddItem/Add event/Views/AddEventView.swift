//
//  AddEventView.swift
//  spine
//
//  Created by Mac on 11/06/22.
//

import SwiftUI

struct AddEventView: View {
    @Environment(\.dismiss) var dismiss

    @StateObject var addEventVM = AddEventViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4).padding(.top, 10)
                    .padding(.bottom, 40)
                VStack(spacing: 50) {
                    VStack(alignment: .leading, spacing: 30) {
                        SubHeader3(title: "How would you like to start?")
                        AddEventButton(onTapped: {
                            addEventVM.showAddEvent = true
                        })
                    }
                    
                    VStack(alignment: .leading, spacing: 30) {
                        SubHeader3(title: "Drafts")
                        ExistingEventView(publish: true, onTapped: {
                            
                        })
            
                        SubHeader3(title: "Duplicate an existing event")
                        ExistingEventView(onTapped: {
                            
                        })
                    }
                }.padding(.horizontal, 20)
                
                Spacer()
            }
            VStack {
                Spacer()
                AddEventType().environmentObject(addEventVM)
                    .offset(y: addEventVM.showAddEvent ? 0: UIScreen.main.bounds.height)
            }.background((addEventVM.showAddEvent ? Color.black.opacity(0.3) : Color.clear).onTapGesture {
                addEventVM.showAddEvent.toggle()
            }).edgesIgnoringSafeArea(.all)
        }.onAppear(perform: {
            addEventVM.getEventTypes()
        })
        .animation(.default, value: addEventVM.showAddEvent)
        .navigationBarTitle(Text("ADD EVENT"), displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
    }
}

struct AddEventButton: View {
    var onTapped: ()-> Void
    
    var body: some View {
        Button {
            onTapped()
        } label: {
            HStack {
                Image(systemName: ImageName.plus).foregroundColor(Color.lightBrown)
                Header5(title: "Add a new event")
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 40)
        .padding(.leading, 10)
        .padding(5)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(8)
        .shadow(color: Color.gray.opacity(0.7), radius: 5)
        .foregroundColor(.primary)
    }
}

struct ExistingEventView: View {
    var publish: Bool = false
    var onTapped: ()-> Void
    var body: some View {
        Button {
            onTapped()
        } label: {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Header5(title: "Retreat")
                    Title4(title: "Event name lorm ipsum dolor sit amet sdfsdf sdfsd")
                        .multilineTextAlignment(.leading)
                    Title4(title: "9 May - 12 May 2021, 18:00")
                    Title4(title: "Laos")
                    if publish {
                        SubHeader5(title: "Finish & publish event", fColor: .red)
                    }
                }
                Spacer()
                Image(ImageName.ic_launch)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 70)
            }.padding(.horizontal, 5)
        }
        .frame(maxWidth: .infinity)
        .padding( 10)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(8)
        .shadow(color: Color.gray.opacity(0.7), radius: 5)
        .foregroundColor(.primary)
    }
}
