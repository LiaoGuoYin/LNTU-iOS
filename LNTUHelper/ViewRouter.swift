//
//  ViewRouter.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/27.
//

import Foundation

class ViewRouter: ObservableObject {
    @Published var isLogin: Bool = false
    @Published var user: User
    
    init(user: User, isLogin: Bool) {
        self.user = user
        self.isLogin = isLogin
    }
}
