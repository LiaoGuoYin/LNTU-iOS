//
//  TeacherEvaluationResponse.swift
//  LNTUHelper
//
//  Created by Jingbin Yu on 2021/1/15.
//

import Foundation

// MARK: - TeacherEvaluationResponse
struct TeacherEvaluationResponse: Codable {
    var code: Int
    var message: String
    var data: [TeacherEvaluationResponseData]
}

// MARK: - TeacherEvaluationResponseData
struct TeacherEvaluationResponseData: Codable, Equatable {
    var code: String
    var name: String
    var teacher: String
    var status: TeacherEvaluationStatus
}

// MARK: - TeacherEvaluationStatus
enum TeacherEvaluationStatus: String, Codable {
    case finished = "评教完成"
    case unfinished = "未完成评教"
}
