//
//  Constants.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

struct K {
    struct Education {
        static let baseURL = "https://api.liaoguoyin.com"
        
        static let username = "username"
        static let password = "password"
        static let semester = "semester"
        static let isIncludingOptionalCourse = "isIncludingOptionalCourse"
        
        static let week = "week"
        static let buildingName = "name"
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
