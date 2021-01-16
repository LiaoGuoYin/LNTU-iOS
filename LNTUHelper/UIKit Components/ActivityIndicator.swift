//
//  ActivityIndicator.swift
//  LNTUHelper
//
//  Created by Jingbin Yu on 2021/1/16.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: Context) -> some UIView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        isAnimating ? (uiView as! UIActivityIndicatorView).startAnimating() :
            (uiView as! UIActivityIndicatorView).stopAnimating()
    }
}
