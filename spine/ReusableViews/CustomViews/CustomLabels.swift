//
//  CustomLabels.swift
//  spine
//
//  Created by Mac on 11/08/22.
//

import SwiftUI

struct Header: View {
    let title: String
    var fColor: Color = .primary
    var lineLimit: Int?
    var fWeight: Font.Weight = .heavy
    var body: some View {
        Text(title)
            .font(.Poppins(type: .Bold, size: 24))
            .foregroundColor(fColor)
            //.fontWeight(fWeight)
            .lineLimit(lineLimit)
    }
}

struct Header1: View {
    let title: String
    var fColor: Color = .primary
    var lineLimit: Int?
    var fWeight: Font.Weight = .heavy
    var body: some View {
        Text(title)
            .font(.Poppins(type: .Bold, size: 22))
            .foregroundColor(fColor)
            .lineLimit(lineLimit)
    }
}

//header2 -20
struct Header2: View {
    let title: String
    var fColor: Color = .primary
    var lineLimit: Int?
    var body: some View {
        Text(title)
            .font(.Poppins(type: .Bold, size: 20))
            .foregroundColor(fColor)
            .lineLimit(lineLimit)
    }
}


struct Header3: View {
    let title: String
    var fColor: Color = .primary
    var lineLimit: Int?
    var body: some View {
        Text(title)
            .font(.Poppins(type: .Bold, size: 18))
            .foregroundColor(fColor)
            .lineLimit(lineLimit)
    }
}

struct Header4: View {
    let title: String
    var fColor: Color = .primary
    var lineLimit: Int?
    var body: some View {
        Text(title)
            .font(.Poppins(type: .Bold, size: 16))
            .foregroundColor(fColor)
            .lineLimit(lineLimit)
    }
}

struct Header5: View {
    let title: String
    var fColor: Color = .primary
    var lineLimit: Int?
    var body: some View {
        Text(title)
            .font(.Poppins(type: .Bold, size: 14))
            .foregroundColor(fColor)
            .lineLimit(lineLimit)
    }
}

struct Header6: View {
    let title: String
    var fColor: Color = .primary
    var lineLimit: Int?
    var body: some View {
        Text(title)
            .font(.Poppins(type: .Bold, size: 12))
            .foregroundColor(fColor)
            .lineLimit(lineLimit)
    }
}


//Subheadings:
struct SubHeader3: View {
    let title: String
    var fColor: Color = .primary
    var lineLimit: Int?
    var body: some View {
        Text(title)
            .font(.Poppins(type: .SemiBold, size: 18))
            .foregroundColor(fColor)
            .lineLimit(lineLimit)
    }
}

struct SubHeader4: View {
    let title: String
    var fColor: Color = .primary
    var lineLimit: Int?
    var body: some View {
        Text(title)
            .font(.Poppins(type: .SemiBold, size: 16))
            .foregroundColor(fColor)
            .lineLimit(lineLimit)
    }
}


struct SubHeader5: View {
    let title: String
    var fColor: Color = .primary
    var lineLimit: Int?
    var body: some View {
        Text(title)
            .font(.Poppins(type: .SemiBold, size: 14))
            .foregroundColor(fColor)
            .lineLimit(lineLimit)
    }
}

struct SubHeader6: View {
    let title: String
    var fColor: Color = .primary
    var lineLimit: Int?
    var body: some View {
        Text(title)
            .font(.Poppins(type: .SemiBold, size: 12))
            .foregroundColor(fColor)
            .lineLimit(lineLimit)
    }
}


//same header3
//struct Title: View {
//    let title: String
//    var fColor: Color = .primary
//    var lineLimit: Int?
//    var body: some View {
//        Text(title)
//            .font(.custom("Poppins", size: 18))
//            .foregroundColor(fColor)
//            .fontWeight(.heavy)
//            .lineLimit(lineLimit)
//    }
//}

//same as header 5
//struct Title1: View {
//    let title: String
//    var fColor: Color = .primary
//    var lineLimit: Int?
//    var body: some View {
//        Text(title)
//            .font(.custom("Poppins", size: 14))
//            .foregroundColor(fColor)
//            .fontWeight(.heavy)
//            .lineLimit(lineLimit)
//    }
//}


//rows
struct Title2: View {
    let title: String
    var fColor: Color = .primary
    var lineLimit: Int?
    var body: some View {
        Text(title)
            .font(.Poppins(type: .regular, size: 18))
            .foregroundColor(fColor)
            .lineLimit(lineLimit)
    }
}

struct Title3: View {
    let title: String
    var fColor: Color = .primary
    var lineLimit: Int?
    var body: some View {
        Text(title)
            .font(.Poppins(type: .regular, size: 16))
            .foregroundColor(fColor)
            .lineLimit(lineLimit)
    }
}

struct Title4: View {
    let title: String
    var fColor: Color = .primary
    var lineLimit: Int?
    //var fWeight: Font.Weight = .regular
    var body: some View {
        Text(title)
            .font(.Poppins(type: .regular, size: 14))
            .foregroundColor(fColor)
            .lineLimit(lineLimit)
    }
}

struct Title5: View {
    let title: String
    var fColor: Color = .primary
    var lineLimit: Int?
    //var fWeight: Font.Weight = .regular
    var body: some View {
        Text(title)
            .font(.Poppins(type: .regular, size: 12))
            .foregroundColor(fColor)
            .lineLimit(lineLimit)
    }
}

struct SubTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(K.appColors.lightGray)
            .font(.Poppins(type: .regular, size: 14))
            //.fontWeight(.medium)
    }
}


struct ScrollableLabel: View {
    let text: String
    var height: CGFloat = 100
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView {
            Text(text)
                .font(.Poppins(type: .regular, size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
        }.padding(5)
        .background(colorScheme == .dark ? .black : .lightGray5)
        .frame(height: height)
    }
}


struct GradientDivider: View {
    var body: some View {
        LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)
    }
}
