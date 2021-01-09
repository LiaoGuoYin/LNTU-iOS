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
        static let token = "token"
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
    static var notificationToken: Data? {
        didSet {
            if let assignedToken = notificationToken, isLogin {
                APIClient.notificationToken(type: .register, username: currentUser.username, token: assignedToken) { (result) in
                    var success = false
                    switch result {
                    case .failure(let error):
                        print("Nofication Registration To Server Error: " + error.localizedDescription)
                    case .success(let response):
                        if response.code != 200 {
                            print("Notification Registration To Server Responded with Code " + String(response.code) + ":" + response.message)
                        } else {
                            success = true
                            print("The Notification token was successfully sent to the server")
                        }
                    }
                    
                    if !success {
                        Thread.sleep(forTimeInterval: 30*60)
                        notificationToken = assignedToken
                    }
                }
            }
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
