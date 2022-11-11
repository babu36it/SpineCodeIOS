//
//  AppUtility.swift
//  spine


import Foundation
import UIKit
import SwiftUI

class AppUtility {
    static let shared = AppUtility()
    var userSettings = UserSettings()
    var apiResponseMessage : String = ""
    var apiErrorCode       : Int = 0
    var fcmToken           : String = ""
    var customValue        : String = ""
    
    func isValidPassword(_ password: String) -> Bool {
        let passWordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passWordRegEx)
        return passwordTest.evaluate(with: password)
    }
    
//    func getJsonString(from object: [BallotDetails]) -> String? {
//        let jsonData = try! JSONEncoder().encode(object)
//        guard let jsonString = String(data: jsonData, encoding: .utf8) else { return nil}
//        return jsonString
//    }
}

//MARK: - Set Print Option
extension AppUtility {
    func printToConsole(_ object : Any) {
        #if DEBUG
        Swift.print(object)
        #endif
    }
}

//MARK: - Gloabl Alert View
extension AppUtility {
    /// global alert controller
    func showAlertWith(_ title:String, _ message:String, completion:@escaping(_ action:Bool?) -> Void) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: title,
                message: message,
                preferredStyle: UIAlertController.Style.alert
            )
            
            alert.addAction(UIAlertAction(
                title: "OK",
                style: UIAlertAction.Style.default,
                handler: { action in
                    completion(true)
                }
            ))
            
            DispatchQueue.main.async {
                let keyWindow = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first
                keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func getRootViewController() -> UIViewController? {
        return UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first?.rootViewController
    }
    
    func redirectToLoginScreen() {
        if let window = UIApplication.shared.windows.first {
            let loginView = LoginVC()
            window.rootViewController = UIHostingController(rootView: loginView)
            window.makeKeyAndVisible()
        }
    }
    
    func redirectToRegisterScreen() {
        if let window = UIApplication.shared.windows.first {
            let loginView = RegisterVC()
            window.rootViewController = UIHostingController(rootView: loginView)
            window.makeKeyAndVisible()
        }
    }
    
    
    func redirectToMainScreen() {
        if let window = UIApplication.shared.windows.first {
            let homeView = TabBarView()
            window.rootViewController = UIHostingController(rootView: homeView)
            window.makeKeyAndVisible()
        }
    }
    func appFont(type: Font.PoppinsType, size: CGFloat) -> Font {
        return Font.Poppins(type: type, size: size)
    }
}

extension AppUtility {
    
    func showCustomAlert(alertType: AlertType, message: String, actionButtonTitle: String?, cancelButtonTitle: String, buttonActionCompletion: AlertButtonActionCompletion?) {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.first else { return }
            let alert = CustomAlertView(alertType: alertType, message: message, actionButtonTitle: actionButtonTitle, cancelButtonTitle: cancelButtonTitle, buttonActionCompletion: { action in
                window.rootViewController?.dismiss(animated: false, completion: {
                    buttonActionCompletion?(action)
                })
            })
            let hostVC = UIHostingController(rootView: alert)
            hostVC.modalPresentationStyle = .overCurrentContext
            hostVC.view.backgroundColor = .clear
            window.rootViewController?.present(hostVC, animated: false, completion: nil)
        }
    }
}
class ShowHud:NSObject
{
    static let disablerView:UIView={
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.6)
        return view
    }()
    
    static let containerView:UIView={
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 16
        view.backgroundColor = UIColor(red: 183/255.0, green: 152/255.0, blue: 136/255.0, alpha:1.0)
        view.alpha = 1.0
        return view
    }()
    static var loadingIndicator:UIActivityIndicatorView={
        let loading = UIActivityIndicatorView()
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.style = UIActivityIndicatorView.Style.whiteLarge
        loading.backgroundColor = .clear
        loading.layer.cornerRadius = 16
        loading.layer.masksToBounds = true
        return loading
    }()
    
    static var timerToHideHud:Timer?
    static var timerToShowHud:Timer?
    
    class func show()
    {
        ShowHud.timerToHideHud?.invalidate()
        UIApplication.shared.resignFirstResponder()
        
        ShowHud.timerToShowHud = Timer.scheduledTimer(timeInterval: 0.5, target: ShowHud.self, selector: #selector(ShowHud.showHudAfterOneSecond), userInfo: nil, repeats: false)
        
        
    }
    
    class func hide(){
        
        ShowHud.timerToShowHud?.invalidate()
        ShowHud.timerToHideHud = Timer.scheduledTimer(timeInterval: 0.5, target: ShowHud.self, selector: #selector(ShowHud.hideAfterOneSecond), userInfo: nil, repeats: false)
    }
    
    @objc class func hideAfterOneSecond(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        ShowHud.loadingIndicator.stopAnimating()
        ShowHud.disablerView.removeFromSuperview()
        timerToHideHud?.invalidate()
    }
    @objc class func showHudAfterOneSecond(){
        if  let keyWindow = UIApplication.shared.windows.first
        {
            if !ShowHud.loadingIndicator.isAnimating
            {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                
                keyWindow.addSubview(disablerView)
                disablerView.rightAnchor.constraint(equalTo: keyWindow.rightAnchor).isActive = true
                disablerView.leftAnchor.constraint(equalTo: keyWindow.leftAnchor).isActive = true
                disablerView.topAnchor.constraint(equalTo: keyWindow.topAnchor).isActive = true
                disablerView.bottomAnchor.constraint(equalTo: keyWindow.bottomAnchor).isActive = true
                ShowHud.loadingIndicator.startAnimating()
                
                disablerView.addSubview(containerView)
                
                containerView.centerXAnchor.constraint(equalTo: disablerView.centerXAnchor).isActive = true
                containerView.centerYAnchor.constraint(equalTo: disablerView.centerYAnchor).isActive = true
                let squareSize:CGFloat =  100
                containerView.widthAnchor.constraint(equalToConstant: squareSize).isActive = true
                containerView.heightAnchor.constraint(equalToConstant: squareSize).isActive = true
                
                
                containerView.addSubview(loadingIndicator)
                loadingIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
                loadingIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            }
        }
    }
    
}
class ShowToast: NSObject {
    static var lastToastLabelReference:UILabel?
    static var initialYPos:CGFloat = 0
    class func show(toatMessage:String)
    {
        
        if  let keyWindow = UIApplication.shared.windows.first
        {
            ShowHud.hide()
            if lastToastLabelReference != nil
            {
                let prevMessage = lastToastLabelReference!.text?.replacingOccurrences(of: " ", with: "").lowercased()
                let currentMessage = toatMessage.replacingOccurrences(of: " ", with: "").lowercased()
                if prevMessage == currentMessage
                {
                    return
                }
            }
            
            let cornerRadious:CGFloat = 12
            let toastContainerView:UIView={
                let view = UIView()
                view.layer.cornerRadius = cornerRadious
                view.translatesAutoresizingMaskIntoConstraints = false
                view.backgroundColor = UIColor(red: 183/255.0, green: 152/255.0, blue: 136/255.0, alpha:1.0)
                view.alpha = 1.0
                return view
            }()
            let labelForMessage:UILabel={
                let label = UILabel()
                label.layer.cornerRadius = cornerRadious
                label.layer.masksToBounds = true
                label.textAlignment = .center
                label.numberOfLines = 0
                label.adjustsFontSizeToFitWidth = true
                label.translatesAutoresizingMaskIntoConstraints = false
                label.text = toatMessage
                label.textColor = .white
                label.backgroundColor = UIColor.init(white: 0, alpha: 0)
                return label
            }()
            
            keyWindow.addSubview(toastContainerView)
            
            let fontType = UIFont.systemFont(ofSize: 14)
            labelForMessage.font = fontType
            
            let sizeOfMessage = NSString(string: toatMessage).boundingRect(with: CGSize(width: keyWindow.frame.width, height: keyWindow.frame.height), options: .usesLineFragmentOrigin, attributes: [kCTFontAttributeName as NSAttributedString.Key:fontType], context: nil)
            
            let topAnchor = toastContainerView.bottomAnchor.constraint(equalTo: keyWindow.topAnchor, constant: 0)
            keyWindow.addConstraint(topAnchor)
            
            toastContainerView.centerXAnchor.constraint(equalTo: keyWindow.centerXAnchor, constant: 0).isActive = true
            
            var extraHeight:CGFloat = 0
            if (keyWindow.frame.size.width) < (sizeOfMessage.width+20)
            {
                extraHeight = (sizeOfMessage.width+20) - (keyWindow.frame.size.width)
                toastContainerView.leftAnchor.constraint(equalTo: keyWindow.leftAnchor, constant: 5).isActive = true
                toastContainerView.rightAnchor.constraint(equalTo: keyWindow.rightAnchor, constant: -5).isActive = true
            }
            else
            {
                toastContainerView.widthAnchor.constraint(equalToConstant: sizeOfMessage.width+20).isActive = true
            }
            let totolHeight:CGFloat = sizeOfMessage.height+25+extraHeight
            toastContainerView.heightAnchor.constraint(equalToConstant:totolHeight).isActive = true
            toastContainerView.addSubview(labelForMessage)
            lastToastLabelReference = labelForMessage
            labelForMessage.topAnchor.constraint(equalTo: toastContainerView.topAnchor, constant: 0).isActive = true
            labelForMessage.bottomAnchor.constraint(equalTo: toastContainerView.bottomAnchor, constant: 0).isActive = true
            labelForMessage.leftAnchor.constraint(equalTo: toastContainerView.leftAnchor, constant: 5).isActive = true
            labelForMessage.rightAnchor.constraint(equalTo: toastContainerView.rightAnchor, constant: -5).isActive = true
            keyWindow.layoutIfNeeded()
            
            let padding:CGFloat = initialYPos == 150 ? 150 : 150 // starting position
            initialYPos += padding+totolHeight
            topAnchor.constant = initialYPos
            
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.4, options: .curveEaseIn, animations: {
                keyWindow.layoutIfNeeded()
            }, completion: { (bool) in
                
                topAnchor.constant = 0
                UIView.animate(withDuration: 0.4, delay: 3, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: {
                    keyWindow.layoutIfNeeded()
                }, completion: { (bool) in
                    if let lastToastShown = lastToastLabelReference,labelForMessage == lastToastShown
                    {
                        lastToastLabelReference = nil
                    }
                    initialYPos -= (padding+totolHeight)
                    toastContainerView.removeFromSuperview()
                })
            })
        }
    }
   
}
