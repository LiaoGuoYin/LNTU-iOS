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
    var data: GradeResponseData?
}

struct GradeResponseData: Codable {
    var grade: [GradeResponseDataGrade]
    var gpa: GradeResponseDataGPA
}

// MARK: - Grade
struct GradeResponseDataGrade: Codable, Hashable {
    var name: String
    var credit: String
    var semester: String
    var status: String
    var result: String
    var code, courseType, usual, midTerm, endTerm: String
    var makeUpScore, makeUpScoreResult: String?
    var point: String
}

// MARK: - GPA
struct GradeResponseDataGPA: Codable {
    var semester: String
    var gradePointAverage, weightedAverage, gradePointTotal, scoreTotal, creditTotal: Double
    var courseCount: Int
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
