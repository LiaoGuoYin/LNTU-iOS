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
    let grade: [GradeResponseData]
}

struct EducationInfoResponse: Codable {
    let code: Int
    let message: String
    let data: EducationInfoResponseData?
}

struct EducationInfoResponseData: Codable {
    var username, name, photoURL, nickname, gender, grade, educationLast: String
    var project, education, studentType, college, major: String
    var direction: String?
    var enrollDate, graduateDate, chiefCollege, studyType: String
    var membership, isInSchool, campus, majorClass: String
    var effectAt, isInRecord, studentStatus, isWorking: String
}
