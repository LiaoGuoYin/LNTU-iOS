//
//  SafariView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/11/1.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    
    var urlString: String = "https://lntu.liaoguoyin.com/privacy.html"
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        if urlString.lowercased().starts(with: "http") {
            return SFSafariViewController(url: URL(string: urlString)!)
        } else {
            return SFSafariViewController(url: URL(string: "https://liaoguoyin.com")!)
        }
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) { }
}

struct SwiftUIWebView_Previews: PreviewProvider {
    static var previews: some View {
        SafariView(urlString: "https://liaoguoyin.com/")
    }
}
