//
//  GradeModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import Foundation

struct GradeResponse: Codable {
    let code: Int
    let message: String
    let data: GradeResponseData?
}

struct GradeResponseData: Codable {
    let grade: [GradeResponseDataGrade]
    let gpa: GradeResponseDataGPA
}

// MARK: - Grade
struct GradeResponseDataGrade: Codable {
    let name: String
    let credit: String
    let semester: String
    let status: String
    let result: String
    let code, courseType, usual, midTerm, endTerm: String
    let makeUpScore, makeUpScoreResult: String?
    let point: String
}

// MARK: - GPA
struct GradeResponseDataGPA: Codable {
    let semester: String
    let gradePointAverage, weightedAverage, gradePointTotal, scoreTotal: Double
    let creditTotal, courseCount: Int
}


enum Semester: String, Codable {
    case the201720181 = "2017-2018 1"
    case the201720182 = "2017-2018 2"
    case the201820191 = "2018-2019 1"
    case the201820192 = "2018-2019 2"
    case the201920201 = "2019-2020 1"
}
