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
struct GradeResponseDataGrade: Codable, Hashable {
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
    let gradePointAverage, weightedAverage, gradePointTotal, scoreTotal, creditTotal: Double
    let courseCount: Int
}

extension GradeResponseDataGrade {
    init() {
        // 用于测试的初始化数据
        let demoData = """
        {
            "name": "信息系统分析与设计",
            "credit": "3.5",
            "semester": "2019-20202",
            "status": "正常",
            "result": "93.3",
            "code": "H101730023056.01",
            "courseType": "专业必修",
            "usual": "89",
            "midTerm": "95",
            "endTerm": "94",
            "makeUpScore": null,
            "makeUpScoreResult": null,
            "point": "4"
        }
        """.data(using: .utf8)!
        let demo = try! JSONDecoder().decode(GradeResponseDataGrade.self, from: demoData)
        self.init(name: demo.name, credit: demo.credit, semester: demo.semester, status: demo.status, result: demo.result, code: demo.code, courseType: demo.courseType, usual: demo.usual, midTerm: demo.midTerm, endTerm: demo.endTerm, makeUpScore: demo.makeUpScore, makeUpScoreResult: demo.makeUpScoreResult, point: demo.point)
    }
}
