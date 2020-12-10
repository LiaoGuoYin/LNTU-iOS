//
//  GradeModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import Foundation

struct GradeResponse: Codable {
    var code: Int
    var message: String
    var data: [GradeResponseData]
}

// MARK: - Grade
struct GradeResponseData: Codable, Hashable {
    var name: String
    var credit: String
    var semester: String
    var status: String
    var result: String
    var code, courseType, usual, midTerm, endTerm: String
    var makeUpScore, makeUpScoreResult: String?
    var point: String
    
    var isNormal: Bool {
        return self.status == "正常" ? true : false
    }
}

