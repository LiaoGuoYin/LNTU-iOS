//
//  NoticeModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import Foundation

struct NoticeResponse: Codable {
    let code: Int
    let message: String
    let data: [NoticeResponseData]
}

struct NoticeResponseData: Codable {
    let title, url, date: String
}

struct HelperMessageResponse: Codable {
    let code: Int
    let message: String
    let data: HelperMessageResponseData
}

struct HelperMessageResponseData: Codable {
    var notice, educationServerStatus, helperServerStatus, qualityServerStatus, week, semester: String
}
