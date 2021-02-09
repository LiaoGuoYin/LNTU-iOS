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
    
    case semesterStyle
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
    
    func loadSubscribedItems() -> [SubscriptionItem]? {
        let subscribedItemsStringArray = UserDefaults.standard.stringArray(forKey: SettingsKey.subscribedItems.rawValue)
        
        if let subscribedItemsStringArray = subscribedItemsStringArray {
            var returnValue = [SubscriptionItem]()
            
            for itemString in subscribedItemsStringArray {
                if let subscribedItem = SubscriptionItem(rawValue: itemString) {
                    returnValue.append(subscribedItem)
                } else {
                    return nil
                }
            }
            
            return returnValue
        } else {
            return nil
        }
    }
    
    func storeSubscribedItems(_ subscribedItems: [SubscriptionItem]?) {
        if let subscribedItems = subscribedItems {
            var valueForUserDefaults = [String]()
            
            for item in subscribedItems {
                valueForUserDefaults.append(item.rawValue)
                // We need to first convert the enum values to Strings before storing them to
                // UserDefaults
            }
            
            UserDefaults.standard[.subscribedItems] = valueForUserDefaults
        }
    }
}
