//
//  NotificationRemoveRequestBody.swift
//  LNTUHelper
//
//  Created by Jingbin Yu on 2021/1/13.
//

import Foundation

struct NotificationRemoveRequestBody: Encodable {
    var token: String
    var username: String
}
