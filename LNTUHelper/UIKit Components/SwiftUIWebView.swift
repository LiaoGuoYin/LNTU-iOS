//
//  SwiftUIWebView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/11/1.
//

import SwiftUI
import WebKit

struct SwiftUIWebView: UIViewRepresentable {
    
    @ObservedObject var viewModel: SwiftUIWebViewModel
    let webView = WKWebView()

    func makeUIView(context: UIViewRepresentableContext<SwiftUIWebView>) -> WKWebView {
        self.webView.navigationDelegate = context.coordinator
        if let url = URL(string: viewModel.link) {
            self.webView.load(URLRequest(url: url))
        }
        return self.webView
    }

    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<SwiftUIWebView>) {
        return
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        private var viewModel: SwiftUIWebViewModel

        init(_ viewModel: SwiftUIWebViewModel) {
            self.viewModel = viewModel
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.viewModel.didFinishLoading = true
        }
    }

    func makeCoordinator() -> SwiftUIWebView.Coordinator {
        Coordinator(viewModel)
    }
}

struct SwiftUIWebView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIWebView(viewModel: SwiftUIWebViewModel(privacy: true))
    }
}

