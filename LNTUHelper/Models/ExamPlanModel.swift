//
//  ExamPlanModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/11/9.
//

import Foundation

struct ExamPlanResponse: Codable {
    var code: Int
    var message: String
    var data: [ExamPlanResponseData]
}

struct ExamPlanResponseData: Codable {
    var code, name, type, date: String
    var time, location, seatNumber, status: String
    var comment: String
}
