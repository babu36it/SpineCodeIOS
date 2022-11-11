//
//  AlertView.swift
//  spine


import SwiftUI

enum AlertAction {
    case ok
    case cancel
    case others
}

enum AlertButtonAction {
    case actionButton
    case cancelButton
}

enum AlertType {
    case success, error, info
    
    var image:UIImage {
        switch self {
        case .success:
            return UIImage(named: K.imgNames.success)!
        case .error:
            return UIImage(named: K.imgNames.warning)!
        default:
            return UIImage(named: K.imgNames.warning)!
        }
    }
    
}

typealias AlertButtonActionCompletion = ((_ action: AlertButtonAction) -> Void)

struct AlertView: View {
    @Binding var shown: Bool
    @Binding var closureA: AlertAction?
    var isSuccess: Bool
    var message: String
    @State var buttonTitle : String
    var isShowButton: Bool
    var isShowCancel: Bool
    @State var height : CGFloat = 0.0
    @State var errorCode : Int = Session.expire.rawValue
    var action: (() -> Void)?
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4).ignoresSafeArea()
            VStack {
                HStack {
                    Spacer()
                    if isShowCancel {
                        Image(K.imgNames.close)
                            .padding([.top, .trailing], 10)
                            .onTapGesture {
                                closureA = .cancel
                                shown.toggle()
                            }
                    }
                }
                Image(isSuccess ? K.imgNames.success:K.imgNames.warning).resizable().frame(width: 50, height: 50).padding(.top, 5)
                Spacer()
                GeometryReader { reader in
                    ScrollView {
                        Text(message)
                            .font(.custom(FontStyle.Montserrat_Medium.rawValue, size: 14))
                            .foregroundColor(Color.gray)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(width: reader.size.width-50, height: self.getHeight(msg: message))
                            .padding()
                    }
                    .frame(width: reader.size.width)
                }
                Spacer()
                if isShowButton {
                    if nil != action {
                        Button(action: action!, label: {
                            Text(buttonTitle)
                                .frame(width: 200.0, height: 45.0)
                                .font(.system(size: 18))
                                .padding()
                                .foregroundColor(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(K.appColors.appTheme, lineWidth: 2)
                                )
                        })
                            .frame(width: 200.0, height: 45.0)
                            .background(K.appColors.appTheme)
                        //                        .foregroundColor(.green)
                        //                        .font(.custom(FontStyle.Montserrat_SemiBold.rawValue, size: 16))
                        //                        .clipShape(Capsule())
                            .cornerRadius(25)
                            .padding(.bottom, 10)
                        
                    }
                    Spacer()
                }
            }
            .background(Color.white)
            .frame(width: UIScreen.main.bounds.width-50, height: self.getHeight(msg: message) + (isShowCancel == true ? 200.0 : 180.0))
            .cornerRadius(10)
            .clipped()
        }
    }
    
    func getHeight(msg : String) -> CGFloat {
        DispatchQueue.main.async {
            height = msg.textHeightFrom(width: UIScreen.main.bounds.width-50, fontName: FontStyle.Montserrat_Medium.rawValue, fontSize: 14)
        }
        return height
    }
    
    func buttonAction(perform action: @escaping () -> Void ) -> Self {
        var copy = self
        copy.action = action
        return copy
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(shown: .constant(false), closureA: .constant(.others), isSuccess: true, message: "dvrr robhr boe boefbhoefbh feobhefobhefobefhboefhboefbhefobhefobefhboefbhoefbhefobheo feobhefobhefobefhboefhboefbhefobhefobefhboefbhoefbhefobheo feobhefobhefobefhboefhboefbhefobhefobefhboefbhoefbhefobheo feobhefobhefobefhboefhboefbhefobhefobefhboefbhoefbhefobheo feobhefobhefobefhboefhboefbhefobhefobefhboefbhoefbhefobheofeobhefobhefobefhboefhboefbhefobhefobefhboefbhoefbhefobheofeobhefobhefobefhboefhboefbhefobhefobefhboefbhoefbhefobheo", buttonTitle: K.appButtonTitle.ok, isShowButton: true, isShowCancel: true).buttonAction {
            
        }
    }
}



struct CustomAlertView: View {
    var alertType:AlertType = .success
    var message:String
    var actionButtonTitle:String?
    var cancelButtonTitle:String = K.appButtonTitle.ok
    var buttonActionCompletion:AlertButtonActionCompletion?
    @State var height : CGFloat = 0.0
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4).ignoresSafeArea()
            VStack {
                Image(uiImage: alertType.image).resizable().frame(width: 50, height: 50).padding(.top, 15)
                Spacer()
                GeometryReader { reader in
                    ScrollView {
                        Text(message)
                            .font(.custom(FontStyle.Montserrat_Medium.rawValue, size: 14))
                            .foregroundColor(Color.gray)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(width: reader.size.width-50, height: self.getHeight(msg: message))
                            .padding()
                    }
                    .frame(width: reader.size.width)
                }
                Spacer()
                if actionButtonTitle != nil {
                    Button(action: {
                        buttonActionCompletion?(.actionButton)
                    }, label: {
                        Text(actionButtonTitle!)
//                            .frame(width: 200.0, height: 45.0)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .font(.system(size: 18))
                            .padding()
                            .foregroundColor(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(K.appColors.appTheme, lineWidth: 2)
                            )
                    })
//                        .padding(.bottom, 10)
                        .frame(width: 200.0, height: 45.0)
                        .background(K.appColors.appTheme)
                    //                    .foregroundColor(.white)
                    //                    .font(.custom(FontStyle.Montserrat_SemiBold.rawValue, size: 16))
                    //                    .clipShape(Capsule())
                        .cornerRadius(25)
//                        .padding(.bottom, 10)
                    Spacer()
                }
                Button(action: {
                    buttonActionCompletion?(.cancelButton)
                }, label: {
                    Text(cancelButtonTitle)
                        .frame(width: 200.0, height: 45.0)
                })
                    .frame(width: 200.0, height: 45.0)
                    .foregroundColor(K.appColors.appTheme)
//                    .padding(.bottom, 10)
                Spacer()
            }
            .background(Color.white)
            .frame(width: UIScreen.main.bounds.width-50, height: self.getHeight(msg: message) + 260.0)
            .cornerRadius(10)
            .clipped()
        }
    }
    
    func getHeight(msg : String) -> CGFloat {
        DispatchQueue.main.async {
            height = msg.textHeightFrom(width: UIScreen.main.bounds.width-50, fontName: FontStyle.Montserrat_Medium.rawValue, fontSize: 14)
        }
        return height
    }
}

struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlertView(alertType: .success, message: "Terst Message", actionButtonTitle: "Submit", cancelButtonTitle: "Cancel", buttonActionCompletion: { action in
            print(action)
        })
    }
}
