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
    let title, url, date, content: String
    let appendix: [Appendix]
    struct Appendix: Codable {
        let url, name: String
    }
}

struct HelperMessageResponse: Codable {
    let code: Int
    let message: String
    let data: HelperMessageResponseData
}

struct HelperMessageResponseData: Codable {
    var notice, educationServerStatus, helperServerStatus, qualityServerStatus, week, semester: String
}

extension HelperMessageResponseData {
    init() {
        self.init(notice: "请检查网络后刷新", educationServerStatus: "未知", helperServerStatus: "未知", qualityServerStatus: "未知", week: "1", semester: "2020秋")
    }
}
