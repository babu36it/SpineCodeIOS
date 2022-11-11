//
//  UIFont.swift

//  Copyright © 2020 iOS Developer. All rights reserved.
//

import UIKit
import Foundation
import SwiftUI

extension Font {

    public enum PoppinsType: String {
        case Bold = "-Bold"
        case regular = "-Regular"
        case SemiBold = "-SemiBold"
        
    }

    static func Poppins(type: PoppinsType, size: CGFloat) -> Font {
        return Font.custom("Poppins\(type.rawValue)", size: size)
    }

}

struct Fonts {

    static func avenirRegular(size:CGFloat) -> Font{
        return Font.custom("Avenir-Regular", size: size)
    }
    
//    static func poppinsLight(size:CGFloat) -> Font{
//        return Font.custom("Poppins-Light", size: size)
//    }
    
    static func poppinsRegular(size:CGFloat) -> Font{
        return Font.custom("Poppins-Regular", size: size)
    }

    static func poppinsSemiBold(size:CGFloat) -> Font{
        return Font.custom("Poppins-SemiBold", size: size)
    }

    static func poppinsBold(size:CGFloat) -> Font{
        return Font.custom("Poppins-Bold", size: size)
    }

}

