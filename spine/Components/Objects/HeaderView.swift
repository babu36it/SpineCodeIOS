//
//  HeaderView.swift
//  spine

import SwiftUI

struct HeaderView : View {
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
//            Color.init(K.appColors.grey4)
            Color.yellow
                .frame(width: UIScreen.main.bounds.width, height: 140, alignment: .top)
            Image(ImageName.ic_launch)
                .frame(width: 100, height: 100, alignment: .bottom)
                .padding(.top)
                .aspectRatio(contentMode: .fit)
        })
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
