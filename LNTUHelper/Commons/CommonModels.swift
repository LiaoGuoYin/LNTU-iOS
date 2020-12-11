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
    static let AboutItemList = [
        AboutItemModel(name: "用户反馈群", iconName: "person.2.square.stack", urlString: "mqqapi://card/show_pslcard?src_type=internal&version=1&card_type=group&uin=646177319"),
        AboutItemModel(name: "关注作者", iconName: "number.square", urlString: "https://weibo.com/liaoguoyin"),
        AboutItemModel(name: "用户协议", iconName: "doc.plaintext", urlString: "https://lntu.liaoguoyin.com/privacy.html"),
        AboutItemModel(name: "项目开源地址", iconName: "link", urlString: "https://github.com/LiaoGuoYin/LNTU-API"),
    ]
}
