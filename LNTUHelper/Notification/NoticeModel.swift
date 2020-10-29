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
