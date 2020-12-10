//
//  CommonModels.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/26.
//

import Foundation
import SwiftUI

struct User: Codable {
    var username: String
    var password: String
}

func backupUserToLocal(user: User) {
    let userData = try? JSONEncoder().encode(user)
    UserDefaults.standard.setValue(userData, forKey: "user")
}

func loadLocalUser() -> User? {
    if let actualUserData = UserDefaults.standard.value(forKey: "user") as? Data,
       let user = try? JSONDecoder().decode(User.self, from: actualUserData) {
        return user
    } else {
        return nil
    }
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
