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

