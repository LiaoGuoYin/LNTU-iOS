//
//  UserDefaultRepository.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/12/11.
//

import Foundation

enum SettingsKey: String, CaseIterable {
    
    // Setting
    case isOffline
    case isLogin
    case lastestSelectedTab
    
    // Account Info
    // case educationAccount
    // case qualityAccount
    case educationUsername
    case educationPassword
    case qualityUsername
    case qualityPassword
    case libraryId
    
    // Education & Quality Cache Data
    case courseTableData
    case gradeData
    case classroomData
    case noticeData
    case helperMessage
    case educationInfoData
    case examPlanData
    
    case qualityActivityData
    
    case subscribedItems
}

extension UserDefaults {
    func removeObject(forKey settingsKey: SettingsKey) {
        removeObject(forKey: settingsKey.rawValue)
    }
    subscript<Value>(key: SettingsKey) -> Value? {
        get {
            self.object(forKey: key.rawValue) as? Value
        }
        set {
            self.set(newValue, forKey: key.rawValue)
            print("\(key.rawValue) 成功写到本地")
        }
    }
}

extension UserDefaults {
    func loadLocalUser() -> User {
        if let localUsername = UserDefaults.standard.value(forKey: SettingsKey.educationUsername.rawValue) as? String,
           let localPassword =  UserDefaults.standard.value(forKey: SettingsKey.educationPassword.rawValue) as? String {
            return User(username: localUsername, password: localPassword)
        } else {
            return MockData.user
        }
    }
}
