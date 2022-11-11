//
//  AdPreviewView.swift
//  spine
//
//  Created by Mac on 10/08/22.
//

import SwiftUI

struct AdPreviewView: View {
    let adType: AdType
    var imageVideo: Any?
    var event: EventDetail = event8
    @State var showNext = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var createAdVM: CreateAdViewModel
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 0) {
                LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)//.padding(.top, 10)
                VStack {
                    ProfileImgWithTitleAndName(imageStr: "Oval 57", title: "Promoted by", subtitle: "Oliver Reese", showBadge: true)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    
                    if let image = imageVideo as? UIImage {
                        switch adType {
                        case .pictureVideo:
                            AdImageVideoCell(imageData: image, link: createAdVM.destWebsite)
                        case .event:
                            EventCell(event: event, image: image, link: createAdVM.destWebsite, showArrow: true)
                        case .podcast:
                            PromotionCell(imageData: image, link: createAdVM.destWebsite, heightF: 1.8)
                        }
                    } else if let videoUrl = imageVideo as? URL {
                        VideoPreviewView(videoUrl: videoUrl)
                    }
                    
                    SubHeader5(title: C.StaticText.loremText)
                        .padding(.horizontal)
                    
                    Divider().padding(.horizontal)
                }.padding(.top, 30)
                NavigationLink(isActive: $showNext) {
                    PaymentView().environmentObject(createAdVM)
                } label: {
                    EmptyView()
                }
            }
        }
        .navigationBarTitle(Text("PREVIEW AD"), displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
        .navigationBarItems(trailing: LargeButton(disable: false, title: "NEXT", width: 50, height: 22, bColor: Color.lightBrown, fSize: 12, fColor: .white) {
            showNext = true
        }
       )
    }
}

struct AdPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        AdPreviewView(adType: .event)
    }
}


struct AdImageVideoCell: View {
    var imageStr: String?
    var imageData: UIImage?
    var link: String?
    
    var heightF: Double = 1.8
    let screenWidth = UIScreen.main.bounds.size.width
    var body: some View {
        ZStack(alignment: .bottom) {
            if let imgStr = imageStr {
                BannerImageStringView(imageStr: imgStr, width: screenWidth, height: screenWidth/heightF)
            } else if let imageData = imageData {
                BannerImageDataView(imageData: imageData, width: screenWidth, height: screenWidth/heightF)
            }
            VStack {
                BlurLabels(labels: "Herbal essence")
                Text("Made in Germany").foregroundColor(.white)
                HStack {
                    Spacer()
                    if let urlStr = link, let url = URL(string: urlStr) {
                        Link(destination: url, label: {
                            Image(systemName: ImageName.arrowUpRight).font(.title2)
                                .foregroundColor(.white)
                        }).padding()
                    } else {
                        ButtonWithSystemImage(image: ImageName.arrowUpRight, size: 15, fColor: .white) {
                            
                        }.padding()
                    }
                    
                }
            }
            
        }
    }
}
