//
//  CommonModels.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/26.
//

import Foundation

struct User: Codable {
    var username: String
    var password: String
}

func getCurrentWeekDay() -> Int {
    let today = Date()
    let calendar = Calendar.current
    let dayNumber = calendar.component(.weekday, from: today)
    return (dayNumber == 1) ? 7 : (dayNumber - 1)
}

func refreshToGetCurrentWeek(completion: @escaping (Int) -> ()) {
    APIClient.helperMessage { (result) in
        switch result {
        case .failure( _):
            completion(1)
        case .success(let response):
            if response.code == 200 {
                completion(Int(response.data.week) ?? 1)
            } else {
                completion(1)
            }
        }
    }
}

enum TabBarItemEnum: String, CaseIterable {
    case courseTable = "课表"
    case grade = "成绩"
    case qualitActivity = "素拓网活动记录"
    case classroom = "空教室"
    case notice = "News"
    case account = "个人中心"
}

struct AboutItemModel {
    var name: String
    var iconName: String
    var urlString: String
}

struct SettingData: Hashable {
    static let AboutProjectList = [
        AboutItemModel(name: "用户协议", iconName: "doc.plaintext", urlString: "https://lntu.liaoguoyin.com/privacy.html"),
        AboutItemModel(name: "GitHub Repo", iconName: "link", urlString: "https://github.com/LiaoGuoYin/LNTU-API"),
    ]
    static let ContactUsList = [
        AboutItemModel(name: "用户群", iconName: "QQ", urlString: "mqqapi://card/show_pslcard?src_type=internal&version=1&card_type=group&uin=646177319"),
        AboutItemModel(name: "Xkinler", iconName: "Xkinler", urlString: "https://weibo.com/p/1005051821212433"),
        AboutItemModel(name: "LiaoGuoYin", iconName: "LiaoGuoYin", urlString: "https://weibo.com/liaoguoyin"),
    ]
}
