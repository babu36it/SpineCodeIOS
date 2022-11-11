//
//  Collapsible.swift
//  spine


import SwiftUI

struct Collapsible<Content: View>: View {
    @State var cardTitle: () -> Text
    @State var cardSubTitle: () -> Text
    @State var isSubmitted : Bool
    @State var content: () -> Content
    
    @State private var collapsed: Bool = true
    
    var collapseCard: some View {
        Button(action: {
            if !isSubmitted {
                self.collapsed.toggle()
            }
        }) {
            ZStack {
                HStack {
                    VStack {
                        HStack {
                            self.cardTitle()
                                .font(.custom(FontStyle.Montserrat_Medium.rawValue, size: 16))
                                .foregroundColor(K.appColors.primaryBlack)
                                .padding(.leading, 5)
                            Spacer()
                        }
                        if !collapsed {
                            HStack {
                                self.cardSubTitle()
                                    .font(.custom(FontStyle.Montserrat_Medium.rawValue, size: 12))
                                    .foregroundColor(Color.init(K.appColors.grey1))
                                    .padding(.leading, 5)
                                    .padding(.top, 0.1)
                                Spacer()
                            }
                        }
                    }
                    .padding(.all,10)
                    Spacer()
                    let imageName = isSubmitted ? K.imgNames.checkCircle : (self.collapsed ? K.imgNames.arrowDown : K.imgNames.arrowUp)
                    Image(imageName)
                        .padding()
                }
            }
            .background(Color.init(K.appColors.grey4))
            .cornerRadius(10, corners: (self.collapsed ? [.allCorners] : [.topLeft, .topRight]))
        }
    }
    
    var body: some View {
        VStack {
            VStack {
                collapseCard
            }
            if !collapsed {
                VStack {
                    self.content()
                        .padding(.bottom, 10)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: collapsed ? 0 : .none)
                .clipped()
                .animation(.easeInOut)
                .transition(.opacity)
                .padding(.horizontal)
            }
            
        }
        .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.init(K.appColors.grey1), lineWidth: collapsed ? 0 : 0.2))
        .padding(.horizontal)
    }
}

struct Collapsible_Previews: PreviewProvider {
    static var previews: some View {
        Collapsible(
            cardTitle: { Text("Collapsible") }, cardSubTitle: { Text("Subtitle") }, isSubmitted: false,
            content: {
                HStack {
                    Text("Content")
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .background(Color.clear)
            }
        )
    }
}

struct RoundedEdge: ViewModifier {
    let width: CGFloat
    let color: Color
    let cornerRadius: CGFloat

    func body(content: Content) -> some View {
        content.cornerRadius(cornerRadius - width)
            .padding(width)
            .background(color)
            .cornerRadius(cornerRadius)
    }
}
