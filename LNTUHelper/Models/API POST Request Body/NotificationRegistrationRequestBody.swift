//
//  NotificationRegistrationRequestBody.swift
//  LNTUHelper
//
//  Created by Jingbin Yu on 2021/1/13.
//

import Foundation

struct NotificationRegistrationRequestBody: Encodable {
    var token: String
    var username: String
    var subscriptionList: [String]
}
