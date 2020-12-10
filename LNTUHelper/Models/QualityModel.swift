//
//  QualityModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/12/9.
//

// MARK: - QualityActivityResponse
struct QualityActivityResponse: Codable {
    var code: Int
    var message: String
    var data: [QualityActivityResponseData]
}

// MARK: - QualityActivityResponseData
struct QualityActivityResponseData: Codable {
    var type, id, name, semester: String
    var activityDate, location, responsibility, loggingDateTime: String
    var status: String
    var comment: String?
}
