//
//  CategoriesVC.swift
//  spine
//
//  Created by OM Apple on 25/05/22.
//

import SwiftUI

var CatData = ["Boxing ","LIFE TRANSFORMATION","YOGA","MEDITATION","LOREM IPSUM MEGA EVENT","LOREM IPSUM","LOREM IPSUM","LOREM IPSUM","LOREM IPSUM","LOREM IPSUM"]


struct CategoriesVC: View {
    
    @State var index = 0
    @State private var didTap1:Bool = true
    @State private var didTap2:Bool = false
    
    var body: some View {
        VStack {
            HStack {
                
                Spacer()
                
                Text("CATEGORIES")
                    .font(AppUtility.shared.appFont(type: .regular, size: 20))
                Spacer()
                
                Image(systemName: ImageName.magnifyingglass)
                    .font(.title2)
            }
            .frame(width: UIScreen.main.bounds.width-40)
            .padding()
            .padding(.top,-100)
            
            
            
            VStack{
                
                
                
                HStack {
                    VStack {
                        Button(action: {
                            
                            self.index = 0
                            self.didTap1 = true
                            self.didTap2 = false
                            
                        }, label: {
                            Text("All")
                                .frame(width: 120, height: 40, alignment: .center)
                                .font(AppUtility.shared.appFont(type: .regular, size: 18))
                                .background(self.index == 0 ? K.appColors.appTheme : Color.white)
                                .foregroundColor(self.index == 0 ? .white : .black)
                                .cornerRadius(10)
                            
                        })
                            .background(self.index == 0 ? Color.white : Color.clear)
                            .clipShape(Capsule())
                            .shadow(radius: 0.8)
                            .padding(.leading,-40)
                    }
                    
                    
                    
                    
                    Button(action: {
                        
                        
                        self.index = 1
                        self.didTap1 = false
                        self.didTap2 = true
                        
                        
                    }, label: {
                        Text("Trending")
                            .frame(width: 140, height: 40, alignment: .center)
                            .font(AppUtility.shared.appFont(type: .regular, size: 18))
                            .background(self.index == 1 ? K.appColors.appTheme : Color.white)
                            .foregroundColor(self.index == 1 ? Color.white : Color.black )
                    })
                        .background(self.index == 1 ? Color.white : Color.clear)
                        .clipShape(Capsule())
                        .shadow(radius: 0.8)
                }
                
                
                
                if(didTap1 == true){
                    CategoriesAllView()
                }else{
                    CategoriesTreadingView()
                }
            }
        }

    }
}

struct CategoriesVC_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesVC()
        
    }
}



struct CategoriesAllView: View {
    var body: some View {
        List(0..<2) { item in
            
            
            ForEach(CatData,id:\.self){x in
                
                HStack {
                    Title4(title: x, fColor: .white)
                        .padding(10)
                        .frame(minWidth: 60, maxWidth: .infinity,minHeight: 15)
                        .background(K.appColors.appTheme)
                        .cornerRadius(30)
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 5))
                        .fixedSize(horizontal: true, vertical: false)
                    Spacer()
                    Button {
                        print("Button tapped!")
                    } label: {
                        Title4(title: "+ FOLLOW", fColor: .lightBrown)
                    }
                    
                    
                }
            }
        }
        .listStyle(.plain)
    }
}



struct CategoriesTreadingView: View {
    var body: some View {
        List(0..<2) { item in
            ForEach(CatData,id:\.self){x in
                HStack {
                    Text(x).padding(10)
                        .frame(minWidth: 60, maxWidth: .infinity,minHeight: 15)
                        .background(K.appColors.appTheme)
                        .foregroundColor(Color.white)
                        .font(AppUtility.shared.appFont(type: .regular, size: 14))
                        .cornerRadius(30)
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 5))
                        .fixedSize(horizontal: true, vertical: false)
                    Spacer()
                    Title4(title: "UNFOLLOW", fColor: .lightBrown)
                }
                .frame(width: UIScreen.main.bounds.width-40)
            }
        }
        .listStyle(.plain)
    }
}
