//
//  SwiftUIWebViewModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/11/1.
//

import Foundation

class SwiftUIWebViewModel: ObservableObject {
    @Published var link: String
    @Published var didFinishLoading: Bool = false
    
    init(link: String) {
        self.link = link
    }
    init(privacy: Bool=true) {
        self.link = "https://lntu.liaoguoyin.com/privacy.html"
    }
}
