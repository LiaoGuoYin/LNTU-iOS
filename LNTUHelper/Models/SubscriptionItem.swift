//
//  SubscriptionItem.swift
//  LNTUHelper
//
//  Created by Jingbin Yu on 2021/1/13.
//

import Foundation

enum SubscriptionItem: String, CaseIterable, Codable {
    case notice = "NOTICE"
    case grade = "GRADE"
    
    static let description: [SubscriptionItem: String] = [
        .notice: "教务公告",
        .grade: "成绩更新"
    ]
}
