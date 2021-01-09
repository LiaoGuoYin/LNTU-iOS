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
    var data: [ExamPlanResponseData]?
}

struct ExamPlanResponseData: Codable {
    var code, name, type, date, time, status : String
    var location, seatNumber : String
    var comment: String
    
    var secondsIntervalToNow: Double {
        get {
            return Date().timeIntervalSince1970 - dateTime.timeIntervalSince1970
        }
    }
    
    var currentStatus: ExamStatus {
        if dateTime.timeIntervalSince1970 == 0 {
            return .unknown
        } else {
            if secondsIntervalToNow > 0 {
                return .finished
            } else {
                return .preparing
            }
        }
    }
    
    var dateTimeString: String {
        return "\(self.date) \(self.time)"
    }
    
    var dateTime: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm~HH:mm"
        if let datetime = formatter.date(from: dateTimeString) {
            return datetime
        } else {
            return Date(timeIntervalSince1970: 0) // 时间安排未知
        }
    }
}

enum ExamStatus: String {
    case unknown = "未安排"
    case preparing = "准备中"
    case finished = "已考完"
}
