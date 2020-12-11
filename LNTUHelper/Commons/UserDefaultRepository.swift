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
    
    // Account Info
    case educationAccount
    case qualityAccount
    case libraryId
    
    // Education & Quality Cache Data
    case courseTableData
    case gradeData
    case classroomData
    case noticeData
    case educationInfoData
    case examPlanData
    
    case qualityActivityData
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
