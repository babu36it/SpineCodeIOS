//
//  CreateAdView.swift
//  spine
//
//  Created by Mac on 08/08/22.
//

import SwiftUI

struct CreateAdView: View {
    var editForm = false
    @StateObject var createAdVM = CreateAdViewModel()
    @Environment(\.dismiss) var dismiss
    @State var showDuration = false
    @State var showAdType = false
    @State var disableSave = true
    @State var showSheet = false
    @State var showPreview = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4).padding(.top, 10)
                    
                    VStack(spacing: 30) {
                        
                        Title2(title: "Want to promote a service, product, event or podcast of yours?").padding(.top)
                        
                        VStack(alignment: .leading) {
                            EventDetailTitle(text: "Ad Duration")
                            CustomNavigationView(selectedItem: $createAdVM.selectedDuration, placeholder: "Select")
                                .onTapGesture {
                                    showDuration = true
                                }
                        }
                        
                        VStack(alignment: .leading) {
                            EventDetailTitle(text: "Time Slot")
                            HStack {
                                DateSelectionView(type: .date, selectedDate: $createAdVM.startDateT, size: 15).padding(.vertical,2)
                                DateSelectionView(type: .time, selectedDate: $createAdVM.startTimeT, size: 15).padding(.vertical,2)
                            }
                        }
                        Title3(title: "Your add will be displayed continously every day at the chosen time slot.")
                        
                        VStack(alignment: .leading) {
                            EventDetailTitle(text: "Ad Type")
                            CustomNavigationView(selectedItem: $createAdVM.selectedAdType, placeholder: "Select")
                                .onTapGesture {
                                    showAdType = true
                                }
                                .onChange(of: createAdVM.selectedAdType) { newValue in
                                    createAdVM.selectedMedia = nil
                                }
                        }
                        
                        Divider()
                        
                        if createAdVM.selectedDuration != "" &&  createAdVM.selectedAdType != "" {
                            SingleImageOrVideoPickerView(selectedMedia: $createAdVM.selectedMedia, supportVideo: createAdVM.selectedAdType == AdType.pictureVideo.rawValue)
//                            if createAdVM.selectedAdType == AdType.pictureVideo.rawValue {
//                                SingleImageOrVideoPickerView(selectedMedia: $createAdVM.selectedMedia)
//                            } else {
//                                AddImageView(images: $createAdVM.images, isMultiPicker: false)
//                            }
                            
                            
                            if createAdVM.selectedAdType == AdType.event.rawValue {
                                VStack(spacing: 30) {
                                    VStack(alignment: .leading) {
                                        EventDetailTitle(text: "Event Title")
                                        CustomTextFieldWithCount(searchText: $createAdVM.eventTitle, placeholder: "Enter title", count: 40)
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        EventDetailTitle(text: "Event Type")
                                        NavigationLink(destination: ItemSelectionView(selectedItem: $createAdVM.eventType, itemType: .location)) {
                                            CustomNavigationView(selectedItem: $createAdVM.eventType, placeholder: C.PlaceHolder.eventType)
                                        }
                                    }
                                    
                                    HStack {
                                        VStack(alignment: .leading) {
                                            EventDetailTitle(text: "Start")
                                            DateSelectionView(type: .date, selectedDate: $createAdVM.startDate, size: 15).padding(.vertical,2)
                                            DateSelectionView(type: .time, selectedDate: $createAdVM.startTime, size: 15).padding(.vertical,2)
                                        }.frame(width: 160)
                                        Spacer()
                                        VStack(alignment: .leading) {
                                            EventDetailTitle(text: "End")
                                            DateSelectionView(type: .date, selectedDate: $createAdVM.endDate, size: 15).padding(.vertical,2)
                                            DateSelectionView(type: .time, selectedDate: $createAdVM.endTime, size: 15).padding(.vertical,2)
                                        }.frame(width: 160)
                                        
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        EventDetailTitle(text: "Timezone")
                                        NavigationLink(destination: ItemSelectionView(selectedItem: $createAdVM.selectedTimeZone, itemType: .timezone)) {
                                            CustomNavigationView(selectedItem: $createAdVM.selectedTimeZone, placeholder: C.PlaceHolder.timeZone)
                                        }
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        EventDetailTitle(text: "Location")
                                        NavigationLink(destination: ItemSelectionView(selectedItem: $createAdVM.selectedLocation, itemType: .location)) {
                                            CustomNavigationView(selectedItem: $createAdVM.selectedLocation, placeholder: C.PlaceHolder.address)
                                        }
                                    }
                                }
                            }
                            
                            VStack(alignment: .leading) {
                                EventDetailTitle(text: createAdVM.selectedAdType == AdType.podcast.rawValue ? "Destination website/Spotify/Itunes, etc" : "Destination website")
                                //NavigationLink(destination: CustomWebView()) {
                                    CustomNavigationView(selectedItem: $createAdVM.destWebsite, placeholder: C.PlaceHolder.destWebsite)
                                    .onTapGesture {
                                        showSheet = true
                                    }
                               // }
                            }
                            
                            VStack(alignment: .leading) {
                                EventDetailTitle(text: createAdVM.selectedAdType == AdType.pictureVideo.rawValue ? "Promote your ad": "Promote your ad (optional)")
                                CustomTextEditorWithCount(txt: $createAdVM.promoteAd, placeholder: C.PlaceHolder.promoteAd, count: 90, height: 80)
                            }
                            
                            LargeButton(title: "PREVIEW", width: 120, height: 30, bColor: Color.lightBrown, fSize: 15, fColor: .white) {
                                showPreview = true
                            }.frame(maxWidth: .infinity, alignment: .trailing)
                        
                        NavigationLink(isActive: $showPreview) {
                            AdPreviewView(adType: AdType(rawValue: createAdVM.selectedAdType) ?? .event, imageVideo: createAdVM.selectedMedia).environmentObject(createAdVM)
                        } label: {
                            EmptyView()
                        }
                        }
                        
                    }.padding()
                }
                Spacer()
            }
            if showDuration {
                VStack {
                    Spacer()
                    CustomHalfSheet(showSheet: $showDuration, items: createAdVM.durationList, selectedItem: $createAdVM.selectedDuration, pageTitle: "Select Ad Duration").offset(y: self.showDuration ? 0: UIScreen.main.bounds.height)
                }.background((self.showDuration ? Color.black.opacity(0.3) : Color.clear).onTapGesture {
                    self.showDuration.toggle()
                }).edgesIgnoringSafeArea(.all)
            } else if showAdType {
                VStack {
                    Spacer()
                    CustomHalfSheet(showSheet: $showAdType, items: createAdVM.addTypes, selectedItem: $createAdVM.selectedAdType,pageTitle: "Select Ad Type", height: 120).offset(y: self.showAdType ? 0: UIScreen.main.bounds.height)
                }.background((self.showAdType ? Color.black.opacity(0.3) : Color.clear).onTapGesture {
                    self.showAdType.toggle()
                }).edgesIgnoringSafeArea(.all)
            }
        }
        //.animation(.default, value: showAdType)
        //.animation(.default, value: showDuration)
        .sheet(isPresented: $showSheet, content: {
//            CustomWebView(urlStr: createAdVM.destWebsite){ str in
//                createAdVM.destWebsite = str
//            }
            CustomWebView(urlStr: createAdVM.destWebsite) { str in
                createAdVM.destWebsite = str
            }
        })
        .navigationBarTitle(Text(editForm ? "EDIT AD": "CREATE AD"), displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
        .navigationBarItems(trailing: LargeButton(disable: disableSave, title: "PREVIEW", width: 60, height: 22, bColor: Color.lightBrown, fSize: 12, fColor: .white) {
           // aboutTxt = tempTxt
            self.dismiss()
        })
    }
}

struct CreateAdView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAdView()
    }
}
