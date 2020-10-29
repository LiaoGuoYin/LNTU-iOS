//
//  LoginModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/27.
//

import Foundation

struct EducationInfoResponse: Codable {
    let code: Int
    let message: String
    let data: EducationInfoResponseData?
}

struct EducationInfoResponseData:Codable {
    let username: Int
    let name, photoUrl, nickname, gender, grade, educationLast: String
    let project, education, studentType, college, major: String
    let direction: String?
    let enrollDate, graduateDate, chiefCollege, studyType: String
    let membership, isInSchool, campus, majorClass: String
    let effectAt, isInRecord, studentStatus, isWorking: String
}
