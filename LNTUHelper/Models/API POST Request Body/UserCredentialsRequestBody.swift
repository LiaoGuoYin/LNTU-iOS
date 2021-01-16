//
//  UserCredentialsRequestBody.swift
//  LNTUHelper
//
//  Created by Jingbin Yu on 2021/1/13.
//

import Foundation

struct UserCredentialsRequestBody: Encodable {
    var username: String
    var password: String
    
    enum CodingKeys: String, CodingKey {
        case username
        case password
    }
}
