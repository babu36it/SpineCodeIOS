//
//  StoriesImpluseCell.swift
//  spine
//


import SwiftUI

struct StoriesImpluseCell: View {
    @State var name : String
    @State var isSubmitted   : Bool
    @State private var isActive = false
        
    var body: some View {
        VStack {
            HStack {
                ZStack{
                    
                    Image(ImageName.ic_background)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .cornerRadius(60)
                        .padding(.leading, 10)
//                    CustomDotView(height: 10).padding(.bottom, 45)
//                        .padding(.leading, 60)
//
                        .onTapGesture {
                                        DispatchQueue.main.async { // maybe even with some delay
                                            self.isActive = true
                                        }
                                    }
                   
                    
                }//.frame(alignment: .leading)
                    
                HStack {
                    Title3(title: "Spine")
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Title4(title: "Today", fColor: .gray)
                        .padding(.trailing, 10)
                        
                }.padding(.leading, 5)
            }
            .padding(.top, 5)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            ZStack{
                VStack {
                    Image(ImageName.ic_background)//.scaledToFit()
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height:220)
                    Text("SPINE IMPULSE").padding(.top,-120)
                        .foregroundColor(Color.white)
                        .font(AppUtility.shared.appFont(type: .Bold, size: 16))
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incidi?")
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.top,-100)
                        .font(AppUtility.shared.appFont(type: .regular, size: 16))
                    Text("Spine")
                        .foregroundColor(Color.white)
                        .padding(.top,-60)
                    .font(AppUtility.shared.appFont(type: .regular, size: 16))
                }.clipped()
            }
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
//            HStack {
//                
//                Text("In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form.")
//                    .foregroundColor(Color.black)
//                    .multilineTextAlignment(.leading)
//                    .font(AppUtility.shared.appFont(type: .regular, size: 16))
//            }.padding([.leading, .top, .trailing], 10)
//                .padding(.bottom, 5)
            Divider().padding([.leading, .trailing], 10)
        }.background(Color.white).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct StoriesImpluseCell_Previews: PreviewProvider {
    static var previews: some View {
        StoriesImpluseCell(name: "", isSubmitted: false)
    }
}
