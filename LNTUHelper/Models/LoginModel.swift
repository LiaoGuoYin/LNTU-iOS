//
//  LoginModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/27.
//

import Foundation

struct EducationDataResponse: Codable {
    let code: Int
    let message: String
    let data: EducationDataResponseData?
}

struct EducationDataResponseData: Codable {
    let info: EducationInfoResponseData
    let courseTable: [CourseTableResponseData]
    let grade: [GradeResponseDataGrade]
    let gpa: GradeResponseDataGPA
}

struct EducationInfoResponse: Codable {
    let code: Int
    let message: String
    let data: EducationInfoResponseData?
}

struct EducationInfoResponseData: Codable {
    let username, name, photoURL, nickname, gender, grade, educationLast: String
    let project, education, studentType, college, major: String
    let direction: String?
    let enrollDate, graduateDate, chiefCollege, studyType: String
    let membership, isInSchool, campus, majorClass: String
    let effectAt, isInRecord, studentStatus, isWorking: String
}

let demoUserInfoResponseData = """
    {
      "code": 200,
      "message": "Success",
      "data": {
        "username": "111111111",
        "name": "测试用户",
        "photoURL": "http://202.199.224.119:8080/eams/showSelfAvatar.action?user.name=11111111",
        "nickname": "abc",
        "gender": "男",
        "grade": "2017",
        "educationLast": "4",
        "project": "主修",
        "education": "本科",
        "studentType": "本科 4 年",
        "college": "管理",
        "major": "信息",
        "direction": null,
        "enrollDate": "2017-09-01",
        "graduateDate": "2021-07-01",
        "chiefCollege": "测试学院",
        "studyType": "普通全日制",
        "membership": "是",
        "isInSchool": "是",
        "campus": "辽宁工大校区",
        "majorClass": "",
        "effectAt": "2017-09-01",
        "isInRecord": "是",
        "studentStatus": "在校",
        "isWorking": "否"
      }
    }
    """.data(using: .utf8)!
let demoUserInfoResponse = try! JSONDecoder().decode(EducationInfoResponse.self, from: demoUserInfoResponseData).data!
