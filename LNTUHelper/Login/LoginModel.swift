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
    let username: Int
    let name, photoUrl, nickname, gender, grade, educationLast: String
    let project, education, studentType, college, major: String
    let direction: String?
    let enrollDate, graduateDate, chiefCollege, studyType: String
    let membership, isInSchool, campus, majorClass: String
    let effectAt, isInRecord, studentStatus, isWorking: String
}

let educationInfoResponseDataDemo = """
    {
      "code": 200,
      "message": "Success",
      "data": {
        "username": 1710030215,
        "name": "廖国胤",
        "photoUrl": "http://202.199.224.119:8080/eams/showSelfAvatar.action?user.name=1710030215",
        "nickname": "abc",
        "gender": "男",
        "grade": "2017",
        "educationLast": "4",
        "project": "主修",
        "education": "本科",
        "studentType": "本科 4 年",
        "college": "工商管理学院",
        "major": "信息管理与信息系统",
        "direction": null,
        "enrollDate": "2017-09-01",
        "graduateDate": "2021-07-01",
        "chiefCollege": "工商管理学院",
        "studyType": "普通全日制",
        "membership": "是",
        "isInSchool": "是",
        "campus": "辽宁工大葫芦岛校区",
        "majorClass": "信管 17-2",
        "effectAt": "2017-09-01",
        "isInRecord": "是",
        "studentStatus": "在校",
        "isWorking": "否"
      }
    }
    """.data(using: .utf8)!
let educationInfoResponseDataObjectDemo = try! JSONDecoder().decode(EducationInfoResponse.self, from: educationInfoResponseDataDemo).data
