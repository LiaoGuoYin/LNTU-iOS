//
//  Constants.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import Foundation

struct K {
    
    static let offline = "offline"
    static let imei = "imei"
    
    struct Education {
        static let baseURL = "https://api.liaoguoyin.com"
        // static let baseURL = "https://dev.liaoguoyin.com"
        
        static let username = "username"
        static let password = "password"
        static let semester = "semester"
        
        static let week = "week"
        static let buildingName = "name"
    }
}

struct Constants {
    static let currentSemester = "2020-秋"
    static var currentUser = UserDefaults.standard.loadLocalUser() {
        didSet {
            UserDefaults.standard[.educationUsername] = currentUser.username
            UserDefaults.standard[.educationPassword] = currentUser.password
        }
    }
    static var isLogin = UserDefaults.standard.bool(forKey: SettingsKey.isLogin.rawValue) {
        didSet {
            UserDefaults.standard[.isLogin] = isLogin
        }
    }
}

enum ContentType: String {
    case json = "application/json"
}

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}
