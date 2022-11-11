//
//  SwiftUIWebView.swift
//  spine

import SwiftUI
import WebKit
import Combine

struct SwiftUIWebView: UIViewRepresentable {
    @ObservedObject var viewModel: WebViewModel
    
    let webView = WKWebView()
    
    func makeUIView(context: UIViewRepresentableContext<SwiftUIWebView>) -> WKWebView {
        let fontSetting = self.htmlHeaderWithCustomFont(16, lineHeight: 25)
        self.webView.navigationDelegate = context.coordinator
        self.webView.sizeToFit()
        self.webView.loadHTMLString(fontSetting + viewModel.htmlContent, baseURL: nil)
        return self.webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<SwiftUIWebView>) {
        return
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        private var viewModel: WebViewModel
        
        init(_ viewModel: WebViewModel) {
            self.viewModel = viewModel
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.viewModel.didFinishLoading = true
        }
    }
    
    func makeCoordinator() -> SwiftUIWebView.Coordinator {
        Coordinator(viewModel)
    }
    
    func htmlHeaderWithCustomFont(_ fontSize: Int = 16, lineHeight: Int = 28) -> String {
        return "<html><head><link href=\"https://fonts.googleapis.com/css2?family=Montserrat:wght@200;300;400;500;600;700;900&display=swap\" rel=\"stylesheet\"><meta name='viewport' content='width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no' /></head><body style=\"font-family: 'Montserrat', sans-serif; font-size:\(fontSize); line-height:\(lineHeight)px; word-break:break-word;\"><div style=\"pedding: 0px 13px;\"></div></body></html>"
    }
}

struct SwiftUIWebView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIWebView(viewModel: WebViewModel(htmlContent: "<h1 class=\"ql-indent-3\"><strong>Terms And Condition</strong></h1>"))
    }
}
