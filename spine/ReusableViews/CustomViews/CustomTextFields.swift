//
//  CustomTextFields.swift
//  spine
//
//  Created by Mac on 31/07/22.
//

import Foundation
import SwiftUI

struct CustomTextField: View {
    @Binding var searchText: String
    let screenWidth = UIScreen.main.bounds.size.width
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text("").frame(width: screenWidth - 60, height: 30)
                .padding(5)
                //.background(Color.white)
                .background(Color(UIColor.systemBackground))
                .cornerRadius(8)
                .shadow(color: Color.gray.opacity(0.7), radius: 5)
                
            TextField("https://www.mydomain.com/path/to/podcast_rss.xml", text: $searchText)
                .font(.Poppins(type: .regular, size: 14))
                .padding(.leading, 5)
        }.padding(.horizontal, 30)
    }
}

struct CustomTextField2: View {
    @Binding var searchText: String
    let placeholder: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text("")
                .frame(maxWidth: .infinity)
                .frame(height: 30)
                .padding(5)
                //.background(Color.white)
                .background(Color(UIColor.systemBackground))
                .cornerRadius(8)
                .shadow(color: Color.gray.opacity(0.7), radius: 5)
                
                TextField(placeholder, text: $searchText)
                .font(.Poppins(type: .regular, size: 14))
                    .padding(.leading, 8)
        }
    }
}

struct CustomTextFieldWithCount: View {
    @Binding var searchText: String
    let placeholder: String
    var count = 0
    var hashCount = 0
    var keyboardType: UIKeyboardType = .default
    var autoCapitalization: TextInputAutocapitalization = .sentences
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text("")
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                //.background(Color.white)
                .background(Color(UIColor.systemBackground))
                .cornerRadius(8)
                .shadow(color: Color.gray.opacity(0.7), radius: 5)
            HStack {
                TextField(placeholder, text: $searchText)
                    .font(.Poppins(type: .regular, size: 14))
                    .padding(.leading, 10)
                    .keyboardType(keyboardType)
                    .textInputAutocapitalization(autoCapitalization)
                if count != 0 {
                    Title4(title: "\(count - searchText.count)", fColor: Color.placeHoldertxtClr)
                        .padding(5)
                }
            }
            .onChange(of: searchText) { newValue in
                if count != 0 && newValue.count > count {
                    searchText = String(searchText.prefix(count))
                }
                if hashCount != 0 && newValue.components(separatedBy: "#").count - 1 > hashCount {
                    searchText = String(searchText.prefix(newValue.count - 1))
                }
            }
        }
    }
}

struct CustomTextFieldDynamic: View {
    @Binding var searchText: String
    let placeHolder: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text("")
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                //.padding(5)
                //.background(Color.white)
                .background(Color(UIColor.systemBackground))
                .cornerRadius(8)
                .shadow(color: Color.gray.opacity(0.7), radius: 5)
                
            TextField(placeHolder, text: $searchText)
                .font(.Poppins(type: .regular, size: 14))
                .padding(.leading, 10)
        }
    }
}


struct CustomSearchBar: View {
    let placeHolder: String
    @Binding var searchText: String
    var screenWidth = UIScreen.main.bounds.size.width - 120
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Text("").frame(width: screenWidth, height: 30)
                .padding(5)
                .background(colorScheme == .dark ? .black : .white)
                .cornerRadius(8)
                .shadow(color: Color.gray.opacity(0.7), radius: 5)
                
            TextField(placeHolder, text: $searchText)
                .padding(.leading, 40)
            
            HStack {
                Image(systemName: ImageName.magnifyingglass).foregroundColor(.gray)
                    .padding(10)
                Spacer()
            }
        }.padding()
    }
}

struct CustomSearchBar1: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let items: Int
    //let totalPadding: CGFloat = 60
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Text("\(items) Items").frame(width: screenWidth - Kconstant.filterPadding, height: 30, alignment: .leading)
            .padding(.leading, 10)
                .padding(5)
                //.background(Color.white)
                .background(colorScheme == .dark ? .black : .white)
                .cornerRadius(8)
                .shadow(color: Color.gray.opacity(0.7), radius: 5)
                .foregroundColor(.primary)
    }
}


struct CustomSearchBarDynamic: View {
    let placeHolder: String
    @Binding var searchText: String
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Rectangle().frame(maxWidth: .infinity)
                .frame(height: 30)
                .padding(5)
                .foregroundColor(colorScheme == .dark ? .black : .white)
                .background(colorScheme == .dark ? .black : .white)
                .cornerRadius(8)
                .shadow(color: Color.gray.opacity(0.7), radius: 5)
                
            TextField(placeHolder, text: $searchText)
                .padding(.leading, 40)
            
            HStack {
                Image(systemName: ImageName.magnifyingglass).foregroundColor(.gray)
                    .padding(10)
                Spacer()
            }
        }
    }
}
