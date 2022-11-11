//
//  FeedHeaderView.swift
//  spine
//
//  Created by Mac on 11/07/22.
//

import SwiftUI

struct FeedHeaderView: View {
    @State private var isActive = false
    @State private var isMemberActive = false
    @State private var isHelpActive = false
    @State var showSearchPract = false
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            
            NavigationLink {
                StoryListView()
            } label: {
                VStack {
                    ZStack(alignment: .top) {
                        CircularBorderedProfileView(image: "Oval 57", size: 40, borderWidth: 2, borderClr: .lightBrown)
                        ZStack(alignment: .bottom) {
                            CircularBorderedProfileView(image: "Oval 5", size: 75, borderWidth: 3, showBadge: true, borderClr: .lightBrown).offset(x: -45, y: -5)
                            CircularBorderedProfileView(image: "ProfileImage4", size: 30, borderWidth: 2, borderClr: .lightBrown).offset(x: -5)
                        }
                    }
                    Button("Discover\n Stories"){
                        
                    }.offset(x: -45)
                        .font(.Poppins(type: .regular, size: 12))
                            .foregroundColor(.lightBrown)
                }
            }

            
            
            
            Spacer()
            
            NavigationLink {
               // DiscoverMembersListView()
                MemberGalleryVC()
            } label: {
                VStack(spacing: 20) {
                    HStack(spacing: 0) {
                        CircularBorderedProfileView(image: "ProfileImage3", size: 40, borderWidth: 2)
                        CircularBorderedProfileView(image: "ProfileImage4", size: 40, borderWidth: 2).offset(x:-10)
                        CircularBorderedProfileView(image: "ProfileImage5", size: 40, borderWidth: 2).offset(x:-20)
                    }//.padding()
                    
                    Button("Discover\n Members"){
                        
                    }.font(.Poppins(type: .regular, size: 12))
                        .foregroundColor(.lightBrown)
                }
            }
            
            Spacer()
            
            /*
            NavigationLink {
                PractitionersDetailsView()
            } label: {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        CircularBorderedProfileView(image: "ProfileImage3", size: 40, borderWidth: 2)
                        CircularBorderedProfileView(image: "ProfileImage4", size: 40, borderWidth: 2).offset(x:-10)
                        CircularBorderedProfileView(image: "ProfileImage5", size: 40, borderWidth: 2).offset(x:-20)
                    }//.padding()
                    CustomDotView(height: 10)
                    Button("Find Help/ practicioners"){
                        
                    }.font(.custom("Poppins-Regular", size: 12))
                        .foregroundColor(.lightBrown)
                }
            } */
            
            VStack(spacing: 5) {
                VStack(spacing: 5) {
                    HStack(spacing: 0) {
                        CircularBorderedProfileView(image: "ProfileImage3", size: 40, borderWidth: 2)
                        CircularBorderedProfileView(image: "ProfileImage4", size: 40, borderWidth: 2).offset(x:-10)
                        CircularBorderedProfileView(image: "ProfileImage5", size: 40, borderWidth: 2).offset(x:-20)
                    }//.padding()
                    CustomDotView(height: 15)
                }
                Button("Find Help/ practicioners"){
                    
                }.font(.Poppins(type: .regular, size: 12))
                    .foregroundColor(.lightBrown)
            }.onTapGesture {
                self.showSearchPract = true
            }

            
        }.padding().padding(.leading, 45)
            .fullScreenCover(isPresented: $showSearchPract) {
                NavigationView{
                    PractitionersDetailsView()
                }
            }
    }
}

struct FeedHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        FeedHeaderView()
    }
}


struct HomeFeedCell: View {
    let item: FeedItemDetail
    @State var showProfile = false
    
    var body: some View {
        VStack {
            HStack {
                ProfileImgWithTitleAndName(imageStr: item.profileImg, title: item.profTitle, subtitle: item.profSubtitle, showBadge: item.isNew)
                Spacer()
                Title5(title: item.days, fColor: .lightGray1)
            }.padding(.horizontal)
                .onTapGesture {
                    showProfile = true
                }
           // BannerImageView(image: "ic_launch", heightF: 1.8)
            if item.contentType == .event {
                if let event = item.eventdetail {
                   // EventCell(event: event)
                    NavigationLink {
                        PostDetailListView()
                    } label: {
                        EventCell(event: event, showArrow: true)
                            .multilineTextAlignment(.leading)
                    }
                }
            } else if item.contentType == .promotion {
                PromotionCell(imageStr: item.images.first ?? "", heightF: 1.8)
            } else if item.contentType == .audio {
                AudioCell(image: item.images.first ?? "")
            }
            else if item.contentType == .text {
                if let textContnt = item.imagetxt {
                    ContentTextCell(content: textContnt)
                }
            } else if item.contentType == .podcast {
                if let event = item.eventdetail {
                    PodcastCell(podcast: event, arrow: false)
                }
            } else if item.contentType == .imageMultiple {
                HorizontalImageScroller(images: self.getImages(images: item.images))
            } else if item.contentType == .spineImpulse {
                if let textContnt = item.imagetxt {
                    NavigationLink(destination: SpineImpulseListView()) {
                        //LoginVC()
                        SpineImpulseCell(content: textContnt)
                    }
                }
            }
            
            ButtonListHView(item: item)
            
            if item.contentType != .spineImpulse {
                Title4(title: "Guided meditation with Laura Melina Seller Lorem ipsum dolor sit amet, consecter adipising elit mode.")
                    .padding(.horizontal, 10)
            }
            
        }
        .fullScreenCover(isPresented: $showProfile) {
            EmployeeProfileView(attendee: Attendee(name: item.profSubtitle, type: .personal, img: item.profileImg, msgEn: true))
        }
    }
    
    func getImages(images: [String])-> [UIImage] {
        var images1: [UIImage] = []
        for image in images {
            images1.append(UIImage(named: image)!)
        }
        return images1
    }
}

enum Post3DotOption {
    case reoprtPost
    case hidePost
}

struct ButtonListHView: View {
    let item: FeedItemDetail
    @State var show3Dot = false
    @State var showSheet = false
   // @StateObject var dot3VM = Dot3ViewModel()
    @State var post3DotOption: Post3DotOption = .reoprtPost
    
    
    var body: some View {
        
        HStack(spacing: 10) {
            ButtonWithCustomImage(image: ImageName.ic_heart, size: 20) {
                
            }.padding(.trailing, 10)
            
            ButtonWithCustomImage(image: ImageName.ic_message, size: 20) {
                
            }
            
            Text("\(item.comments)")
                .font(AppUtility.shared.appFont(type: .regular, size: 16))
                .foregroundColor(.lightGray4)
                .padding(.trailing,2)
            
            ButtonWithCustomImage(image: ImageName.ic_leftarrow, size: 20) {
                
            }
            Spacer()
            if item.contentType != .promotion {
                ButtonWithCustomImage(image: ImageName.ic_bookmark, size: 16) {
                    
                }
                ButtonWithCustomImage(image: ImageName.ic_threedot, size: 20, mode: .fit) {
                    show3Dot.toggle()
                }
            }
            
        }.padding(.horizontal).padding(.vertical, 5)
        
            .adaptiveSheet(isPresented: $showSheet, detents: [.medium()], smallestUndimmedDetentIdentifier: .large) {
//                switch post3DotOption {
//                case .reoprtPost:
//                    ReportingMainView(showSheet: $showSheet)//.environmentObject(dot3VM)
//                case .hidePost:
//                    Text("hide post")
//                case .none:
//                    Text("None")
//                }
                //ReportingMainView(showSheet: $showSheet)
                BaseSheetView(showSheet: $showSheet, type: $post3DotOption)
                    
            }
        
            .confirmationDialog("", isPresented: $show3Dot) {
                
                Button("Hide post") {
                    post3DotOption = .hidePost
                    showSheet = true
                }
                Button("Follow") {
                    
                }
                Button("Report post") {
                    post3DotOption = .reoprtPost
                    showSheet = true
                }
                
            }
    }
}

struct BackgroundClearView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}


struct PromotionCell: View {
    var imageStr: String?
    var imageData: UIImage?
    var link: String?
    var heightF: Double = 2.0
    let screenWidth = UIScreen.main.bounds.size.width
    @State var isShare = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if let imgStr = imageStr {
                Image(imgStr)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: screenWidth, height: screenWidth/heightF)
                    .clipped()
            } else if let imageData = imageData {
                Image(uiImage: imageData)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: screenWidth, height: screenWidth/heightF)
                    .clipped()
            }
            HStack(alignment: .bottom) {
                BlurLabels(labels: "Empowerment Meditation")
                Spacer()
                
                if let urlStr = link, let url = URL(string: urlStr) {
                    Link(destination: url, label: {
                        Image(systemName: ImageName.arrowUpRight).font(.title2)
                            .foregroundColor(.white)
                    })
                } else {
                    ButtonWithSystemImage(image: ImageName.arrowUpRight, size: 15, fColor: .white) {
                        isShare = true
                    }
                }
                
                
                
            }.padding()
//            NavigationLink(isActive: $isShare) {
//                //Text("web browser")
//                //Link("", destination: URL(string: "https://www.appcoda.com")!)
//                WebView(url: URL(string: "https://www.appcoda.com")!)
//            } label: {
//                EmptyView()
//            }

        }//.frame(height: screenWidth/heightF)
    }
}


struct ContentTextCell: View {
    let content: TextContentFormat
    var factor = 1.8
    var body: some View {
        ZStack {
            BannerImageView(image: "grayBanner", heightF: factor)
            VStack(alignment: .leading, spacing: 20) {
                Title4(title: content.descr, fColor: .white)
                Title4(title: content.author, fColor: .white)
            }.padding(20)
        }
    }
}

struct SpineImpulseCell: View {
    let content: TextContentFormat
    var factor = 1.8
    var body: some View {
        ZStack {
            BannerImageView(image: "grayBanner", heightF: factor)
            VStack {
                Title4(title: content.title, fColor: .white)
                Spacer()
                Title4(title: content.descr, fColor: .white)
                    .multilineTextAlignment(.center)
                Spacer()
                Title4(title: content.author, fColor: .white)
            }.padding(40)
        }
    }
}

struct AudioCell: View {
    let image: String
    var heightF: Double = 0.65
    let screenWidth = UIScreen.main.bounds.size.width
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(image)
                .resizable()
                //.aspectRatio(contentMode: .fill)
                .frame(width: screenWidth, height: screenWidth/heightF)
            
            /* uncomment once u get the profer image
            HStack {
                ButtonWithSystemImage(image: "person.circle.fill", size: 25, fColor: .black) {
                }
                Spacer()
                ButtonWithSystemImage(image: "speaker.wave.2.circle.fill", size: 25, fColor: .primary) {
                }
            }.padding()
            */
        }
    }
}




struct BlurLabels: View {
    let labels: String
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if labels.count <= 20 {
                BlurLabel(text: labels)
            } else {
                ForEach(labels.components(separatedBy: " "), id: \.self) { label in
                    BlurLabel(text: label)
                }
            }
            
        }//.font(.Poppins(type: .regular, size: 18))
    }
}

struct BlurLabel: View {
    let text: String
    var body: some View {
        Header3(title: text)
            .padding(6)
            .background(Color(UIColor.systemBackground).opacity(0.7))
    }
}
