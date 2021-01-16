//
//  TeacherEvaluationRequestBody.swift
//  LNTUHelper
//
//  Created by Jingbin Yu on 2021/1/15.
//

import Foundation

struct TeacherEvaluationRequestBody: Codable {
    var user: User
    var submit: Bool
    
    enum ExclusiveCodingKeys: String, CodingKey {
        case submit
    }
    
    func encode(to encoder: Encoder) throws {
        var userContainer = encoder.container(keyedBy: UserCredentialsRequestBody.CodingKeys.self)
        try userContainer.encode(user.username, forKey: .username)
        try userContainer.encode(user.password, forKey: .password)
        
        var submitContainer = encoder.container(keyedBy: ExclusiveCodingKeys.self)
        try submitContainer.encode(submit, forKey: .submit)
        
    }
}
