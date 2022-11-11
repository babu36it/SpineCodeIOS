//
//  CustomWebView.swift
//  spine
//
//  Created by Mac on 09/08/22.
//

import SwiftUI
import WebKit

struct CustomWebView: View {
    let urlStr: String
    @StateObject var model = WebViewModel1()
    var onTapped: (String)-> Void
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        
        VStack(spacing: 20) {
            Capsule().frame(width: 70, height: 2).foregroundColor(.lightBrown)
                .offset(y: 10)
            
            HStack(spacing: 10) {
                SystemButton(image: ImageName.multiply) {
                    self.dismiss()
                }
                
                CustomTextFieldWithCount(searchText: $model.urlString, placeholder: "Enter url")
                    .keyboardType(.URL)
                    .autocapitalization(.none)
                    .onSubmit {
                        model.loadUrl()
                    }
                
                LargeButton(disable: false, title: "ADD LINK", width: 60, height: 30, bColor: Color.lightBrown, fSize: 12, fColor: .white) {
                    onTapped(model.urlString)
                    self.dismiss()
                }
                
            }.padding(10)
            
            WebView1(webView: model.webView).padding()
                .background(Color.gray)
        }
        .onAppear(perform: {
            model.urlString = urlStr
            model.loadUrl()
        })
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button(action: {
                    model.goBack()
                }, label: {
                    Image(systemName: ImageName.arrowShapeUpBack)
                })
                //.disabled(!model.canGoBack)
                
                Button(action: {
                    model.goForward()
                }, label: {
                    Image(systemName: ImageName.arrowShapeUpRight)
                })
                //.disabled(!model.canGoForward)
                
                Spacer()
            }
        }
    }
}


class WebViewModel1: ObservableObject {
    let webView: WKWebView
    @Published var urlString: String = ""
    @Published var canGoBack: Bool = false
    @Published var canGoForward: Bool = false
    
    init() {
        webView = WKWebView(frame: .zero)
        loadUrl()
    }
    
    func loadUrl() {
        guard let url = URL(string: urlString) else {
            return
        }
        webView.load(URLRequest(url: url))
    }
    
    func goForward() {
        webView.goForward()
    }
    
    func goBack() {
        webView.goBack()
    }
    
    private func setupBindings() {
        webView.publisher(for: \.canGoBack)
            .assign(to: &$canGoBack)
        
        webView.publisher(for: \.canGoForward)
            .assign(to: &$canGoForward)
    }
}
                  
                  

struct WebView1: UIViewRepresentable {
    typealias UIViewType = WKWebView

    let webView: WKWebView
    
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) { }
}


/*
//method3
struct CustomWebView3: View {
    let urlStr: String
    @StateObject var navigationState = NavigationState()
    @Environment(\.dismiss) var dismiss
    var onTapped: (String)-> Void
    
    var body: some View {
        VStack(spacing: 20){
            Capsule().frame(width: 70, height: 2).foregroundColor(.lightBrown)
                .offset(y: 10)
            HStack {
                SystemButton(image: "multiply") {
                    self.dismiss()
                }
                Text(navigationState.url?.absoluteString ?? "(none)").lineLimit(1)
                    .padding(.horizontal, 5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 40)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: Color.gray.opacity(0.7), radius: 5)
                    .foregroundColor(.primary)
                LargeButton(disable: false, title: "ADD LINK", width: 60, height: 30, bColor: Color.lightBrown, fSize: 12, fColor: .white) {
                    onTapped(navigationState.url?.absoluteString ?? "")
                    self.dismiss()
                }
            }.padding(.horizontal)
            
            
            WebView3(request: URLRequest(url: URL(string: urlStr == "" ? "https://www.google.com" : urlStr)!), navigationState: navigationState).padding()
                .background(Color.gray)
            HStack {
                Button("Back") {
                    navigationState.webView.goBack()
                }
                Spacer()
                Button("Forward") {
                    navigationState.webView.goForward()
                }
            }.padding()
        }
    }
}

class NavigationState : NSObject, ObservableObject {
    @Published var url : URL?
   // @Published var str = ""
    let webView = WKWebView()
}

extension NavigationState : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.url = webView.url
    }
}

struct WebView3 : UIViewRepresentable {
    
    let request: URLRequest
    var navigationState : NavigationState
    
    func makeUIView(context: Context) -> WKWebView  {
        let webView = navigationState.webView
        webView.navigationDelegate = navigationState
        webView.load(request)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) { }
}




//method 0

struct CustomWebView0: View {
    @State var searchText = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        VStack(spacing: 20) {
            HStack {
                SystemButton(image: "multiply") {
                    self.dismiss()
                }
                CustomTextFieldWithCount(searchText: $searchText, placeholder: "Add URL")
                LargeButton(disable: false, title: "ADD LINK", width: 60, height: 22, bColor: Color.lightBrown, fSize: 12, fColor: .white) {
                }
                
            }.padding()
            
           // WebView(url: URL(string: "https://www.google.com")!)
            WebView1(url: URL(string: "https://www.google.com")!)
            
        }
        .navigationBarHidden(true)
         

    }
}

//struct CustomWebView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomWebView()
//    }
//}

//method2
class WebViewManager : ObservableObject {
    var webview: WKWebView = WKWebView()
    
    init() {
        webview.load(URLRequest(url: URL(string: "https://apple.com")!))
    }
    
    func searchFor(searchText: String) {
        if let searchTextNormalized = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
           let url = URL(string: "https://google.com/search?q=\(searchTextNormalized)") {
            self.loadRequest(request: URLRequest(url: url))
        }
    }
    
    func loadRequest(request: URLRequest) {
        webview.load(request)
    }
    
    func goBack(){
        webview.goBack()
    }
    
    func goForward(){
        webview.goForward()
    }
    
    func refresh(){
        webview.reload()
    }
}

struct Webview : UIViewRepresentable {
    var manager : WebViewManager
    
    init(manager: WebViewManager) {
        self.manager = manager
    }
    
    func makeUIView(context: Context) -> WKWebView  {
        return manager.webview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}


struct CustomWebView2: View {
    @StateObject private var manager = WebViewManager()
    @State private var searchText = ""
    @State private var txt = ""
    
    var body: some View {
        ZStack {
            HStack {
                SystemButton(image: "multiply") {
                    //self.dismiss()
                }
                //CustomTextFieldWithCount(searchText: $searchText, placeholder: "Add URL")
                CustomWebTextField(searchText: $searchText, placeholder: "Add URL") { str in
                    manager.searchFor(searchText: str)
                }
                LargeButton(disable: false, title: "ADD LINK", width: 60, height: 22, bColor: Color.lightBrown, fSize: 12, fColor: .white) {
                }
            }.padding()
        }
        Webview(manager: manager)
    }
}

//method 1
import SwiftUI
import WebKit
 
struct WebView1: UIViewRepresentable {
 
    var url: URL
 
    func makeUIView(context: Context) -> WKWebView {
        let request = URLRequest(url: url)
        let wkWebView = WKWebView()
        wkWebView.load(request)
        return wkWebView
    }
 
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<WebView1>) {
        
    }
}

struct CustomWebTextField: View {
    @Binding var searchText: String
    let placeholder: String
    var onTapped: (String)-> Void
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text("")
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: Color.gray.opacity(0.7), radius: 5)
                
            HStack {
                TextField(placeholder, text: $searchText, onCommit: {
                    onTapped(searchText)
                }).keyboardType(.URL)
                    .font(.custom("Poppins", size: 14))
                    .padding(.leading, 10)
                
            }
            
        }
    }
}
 */
