//
//  ViewRouter.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/27.
//

import Foundation

class ViewRouter: ObservableObject {
    
    @Published var isShowBanner: Bool = false
    @Published var banner: BannerModifier.Data = BannerModifier.Data(content: "登录成功") {
        willSet {
            self.isShowBanner = true
        }
    }
    
    @Published var user: User
    @Published var isLogin: Bool = false
    
    init(user: User, isLogin: Bool) {
        self.user = user
        self.isLogin = isLogin
    }
}
