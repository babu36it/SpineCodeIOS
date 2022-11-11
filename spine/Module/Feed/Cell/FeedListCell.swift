//
//  FeedListCell.swift
//  spine
//


import SwiftUI



struct FeedListCell1: View {
    @State var name : String
    @State var isSubmitted   : Bool
    @State private var isActive = false
        
    var body: some View {
        VStack {
            HStack {
                ZStack{
                    NavigationLink(destination: StoriesVC(), isActive: self.$isActive){
                    }   .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)
                    
                    Image(ImageName.ic_launch)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .cornerRadius(60)
                        .padding(.leading, 20)
                    CustomDotView(height: 10).padding(.bottom, 45)
                        .padding(.leading, 60)
                        
                        .onTapGesture {
                                        DispatchQueue.main.async { // maybe even with some delay
                                            self.isActive = true
                                        }
                                    }
                }//.frame(alignment: .leading)
                    
                VStack(alignment: .leading) {
                    Title3(title: "Promoted by")
                        .multilineTextAlignment(.leading)
                    Title4(title: "Oliver Reese", fColor: .gray)
                }.padding(.leading, 10)
            }
            .padding(.top, 5)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            HStack {
                Image(ImageName.ic_launch)//.scaledToFit()
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height:250)
            }.clipped()
            HStack {
                Button(action: {
                    print("ic_heart pressed")
                }) {
                    Image(ImageName.ic_heart)
                        .padding(.trailing,5)
                }
                Text("0")
                    .font(AppUtility.shared.appFont(type: .regular, size: 16))
                    .padding(.trailing,2)
                
                Button(action: {
                    print("ic_message pressed")
                }) {
                    Image(ImageName.ic_message)
                        .padding(.trailing,5)
               }
                
                Text("0")
                    .font(AppUtility.shared.appFont(type: .regular, size: 16))
                    .padding(.trailing,2)

                Button(action: {
                    print("ic_leftarrow pressed")
                }) {
                    Image(ImageName.ic_leftarrow)
                        .padding(.trailing,5)
               }
                Button(action: {
                    print("ic_bookmark pressed")
                }) {
                    Image(ImageName.ic_bookmark)
                        .padding(.leading,180)
                }
                
                Button(action: {
                    print("ic_threedot pressed")
                }) {
                    Image(ImageName.ic_threedot)
                        .padding(.leading,10)
                }
                
            }.padding(.top, 5)
            HStack {
                
                Text("In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form.")
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .font(AppUtility.shared.appFont(type: .regular, size: 16))
            }.padding([.leading, .top, .trailing], 10)
                .padding(.bottom, 5)
            Divider().padding([.leading, .trailing], 10)
        }.background(Color.white).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
    }
}

//struct FeedListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedListCell(name: "", isSubmitted: false)
//    }
//}
