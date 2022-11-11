//
//  SwiftUIViewModifier.swift
//  spine

import Foundation
import SwiftUI

//MARK: Separator Style Modifier
struct ListSeparatorStyle: ViewModifier {
    
    let style: UITableViewCell.SeparatorStyle
    
    func body(content: Content) -> some View {
        content
            .onAppear() {
                UITableView.appearance().separatorStyle = self.style
            }
    }
}
 
//MARK: View Extension
extension View {
    func listSeparatorStyle(style: UITableViewCell.SeparatorStyle) -> some View {
        ModifiedContent(content: self, modifier: ListSeparatorStyle(style: style))
    }
    
    func navigationBarColor(_ backgroundColor: UIColor?, hideShadow: Bool) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, hidesShadow: hideShadow))
    }
    
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)

                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

//MARK: NavigationBar Modifier
struct NavigationBarModifier: ViewModifier {
    var backgroundColor: UIColor?
    var hideShadow : Bool = false
    @State var strTitle : String = ""
    
    init( backgroundColor: UIColor?, hidesShadow : Bool) {
        self.backgroundColor = backgroundColor
        self.hideShadow = hidesShadow
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont(name: FontStyle.Montserrat_SemiBold.rawValue, size: 20)!]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        coloredAppearance.shadowColor = nil // or a custom tint color
        if !self.hideShadow {
            coloredAppearance.shadowImage = UIImage(named: "ic_shadow")
        }
        else {
            coloredAppearance.shadowImage = nil
        }
        
        coloredAppearance.backgroundColor = self.backgroundColor
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = self.backgroundColor
    }
    
    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    //Color(self.backgroundColor ?? .clear)
                        //.frame(height: geometry.safeAreaInsets.top)
                        //.edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

struct NavigationUtil {
    static func popToRootView() {
//        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
//        let vContoller = UIHostingController(rootView: WelcomeView())
//        appDelegate?.loadNewRootSwiftUIView(rootViewController: vContoller)
        findNavigationController(viewController: AppUtility.shared.getRootViewController())?.popToRootViewController(animated: true)
    }

    static func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
        guard let viewController = viewController else {
            return nil
        }

        if let navigationController = viewController as? UINavigationController {
            return navigationController
        }

        for childViewController in viewController.children {
            return findNavigationController(viewController: childViewController)
        }

        return nil
    }
}
