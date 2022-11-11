//
//  HomeSectionView.swift
//  spine
//
//

import SwiftUI

struct HomeSectionView1: View {
    @State private var isActive = false
    @State private var isMemberActive = false
    @State private var isHelpActive = false
    var body: some View {
        VStack {
            HStack {
                HStack {
                    VStack {
                        ZStack {
                            ZStack {
                                NavigationLink(destination: StoriesVC(), isActive: self.$isActive){
                                }   .navigationBarBackButtonHidden(true)
                                    .navigationBarHidden(true)
                                Image(ImageName.sample3)
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .cornerRadius(30)
                                    .overlay(RoundedRectangle(cornerRadius: 30).stroke(K.appColors.appTheme, lineWidth: 2))
                                    .onTapGesture {
                                                    DispatchQueue.main.async { // maybe even with some delay
                                                        self.isActive = true
                                                    }
                                                }
                            }.padding(.bottom, 30)
                                .padding(.leading, 40)
                            
                           ZStack {
                                Image(ImageName.sample2)
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    .cornerRadius(20)
                                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(K.appColors.appTheme, lineWidth: 2))
                                    .onTapGesture {
                                                    DispatchQueue.main.async { // maybe even with some delay
                                                        self.isActive = true
                                                    }
                                                }
                            }.padding(.top, 30)
                                .padding(.leading, 40)
                            
                            ZStack {
                                Image(ImageName.sample1)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(50)
                                    .overlay(RoundedRectangle(cornerRadius: 50).stroke(K.appColors.appTheme, lineWidth: 2))
                                    .onTapGesture {
                                                    DispatchQueue.main.async { // maybe even with some delay
                                                        self.isActive = true
                                                    }
                                                }
                                CustomDotView(height: 10).padding(.bottom, 40)
                                    .padding(.leading, 30)
                                
                            }.padding(.trailing, 10)
                                .padding(.bottom, 5)
                            
                        }.frame(width:80, height: 70)
//                            .background(Color.green)
                        Text("Discover\nstories")
                            .font(AppUtility.shared.appFont(type: .SemiBold, size: 16))
                            .multilineTextAlignment(.center)
                            .foregroundColor(K.appColors.appTheme)
                    }
                    .frame(width:100)
                }.padding(.leading, 20)
                Spacer()
                HStack {
                    VStack {
                        ZStack {
                            ZStack {
                                NavigationLink(destination: MemberListVC(), isActive: self.$isMemberActive){
                                }   .navigationBarBackButtonHidden(true)
                                    .navigationBarHidden(true)
                                Image(ImageName.sample1)
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .cornerRadius(30)
                                    .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.white, lineWidth: 1))
                                    .onTapGesture {
                                                    DispatchQueue.main.async { // maybe even with some delay
                                                        self.isMemberActive = true
                                           }
                                     }
                            }
                            .padding(.trailing, 30)
                            
                            ZStack {
                                Image(ImageName.sample2)
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .cornerRadius(30)
                                    .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.white, lineWidth: 1))
                                    .onTapGesture {
                                                    DispatchQueue.main.async { // maybe even with some delay
                                                        self.isMemberActive = true
                                           }
                                     }
                            }
                            ZStack {
                                Image(ImageName.sample3)
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .cornerRadius(30)
                                    .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.white, lineWidth: 1))
                                    .onTapGesture {
                                                    DispatchQueue.main.async { // maybe even with some delay
                                                        self.isMemberActive = true
                                           }
                                     }
                            }
                            .padding(.leading, 30)
                        }.frame(width:80, height: 70)
                        Text("Discover\nmembers")
                            .font(AppUtility.shared.appFont(type: .SemiBold, size: 16))
                            .multilineTextAlignment(.center)
                            .foregroundColor(K.appColors.appTheme)
                    }
                    .frame(width:100)
                }
                Spacer()
                HStack {
                    VStack {
                        ZStack {
                            ZStack {
                                NavigationLink(destination: PracticionersListVC(), isActive: self.$isHelpActive){
                                }   .navigationBarBackButtonHidden(true)
                                    .navigationBarHidden(true)
                                Image(ImageName.sample1)
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .cornerRadius(30)
                                    .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.white, lineWidth: 1))
                                    .onTapGesture {
                                                    DispatchQueue.main.async { // maybe even with some delay
                                                        self.isHelpActive = true
                                           }
                                     }
                            }
                            .padding(.trailing, 30)
                            
                            ZStack {
                                Image(ImageName.sample2)
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .cornerRadius(30)
                                    .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.white, lineWidth: 1))
                                    .onTapGesture {
                                                    DispatchQueue.main.async { // maybe even with some delay
                                                        self.isHelpActive = true
                                           }
                                     }
                            }
                            ZStack {
                                Image(ImageName.sample3)
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .cornerRadius(30)
                                    .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.white, lineWidth: 1))
                                    .onTapGesture {
                                                    DispatchQueue.main.async { // maybe even with some delay
                                                        self.isHelpActive = true
                                           }
                                     }
                            }
                            .padding(.leading, 30)
                        }.frame(width:80, height: 70)
                        Text("Find help/\npracticioners")
                            .font(AppUtility.shared.appFont(type: .SemiBold, size: 16))
                            .multilineTextAlignment(.center)
                            .foregroundColor(K.appColors.appTheme)
                    }
                    .frame(width:130)
                }
//                Spacer()
//                HStack {
//                    VStack {
//                        VStack(alignment: .trailing) {
//                            VStack {
//                                Text("YOGA")
//                                    .frame(height: 25.0)
//                                    .font(AppUtility.shared.appFont(type: .regular, size: 14))
//                                    .foregroundColor(Color.white)
//                                    .padding([.leading, .trailing], 20)
//                            }.background(K.appColors.appTheme).cornerRadius(25.0)
//
//                            VStack {
//                                Text("MEDICATIONS")
//                                    .frame(height: 25.0)
//                                    .font(.system(size: 14))
//                                    .foregroundColor(Color.white)
//                                    .padding([.leading, .trailing], 20)
//                            }.background(K.appColors.appTheme).cornerRadius(25.0)
//
//                        }.frame(width:150, height: 70)
//                        Text("Discover\nCategories")
//                            .font(AppUtility.shared.appFont(type: .SemiBold, size: 16))
//                            .multilineTextAlignment(.center)
//                            .foregroundColor(K.appColors.appTheme)
//                    }
//                    .frame(width:150)
//                }.padding(.trailing, 30)
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
//            .frame(height:120)
//            .background(Color.yellow)
    }
}

//struct HomeSectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeSectionView()
//    }
//}
