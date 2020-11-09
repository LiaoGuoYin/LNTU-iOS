//
//  CourseTableModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/26.
//

import Foundation

struct CourseTableResponse: Codable {
    let code: Int
    let message: String
    let data: [CourseTableResponseData]?
}

struct CourseTableResponseData: Codable {
    let code, name, teacher, credit: String
    let schedules: [Schedule]
    
    struct Schedule: Codable {
        let room: String
        let weekday, index: Int
        let weeksString: String
        let weeks: [Int]
    }
}

extension CourseTableResponseData {
    init() {
        self.init(code: "H101750002032.01", name: "演示课程", teacher: "毛志勇", credit: "2", schedules: [Schedule(room: "静远楼", weekday: 4, index: 3, weeksString: "1-5", weeks: [1,2,3,4,5])])
    }
}

// MARK: - CoursTableMatrixCell
struct CourseTableMatrixCell: Codable, CustomStringConvertible {
    let code, name, teacher, credit: String
    let room: String
    let weekday, index: Int
    let weeksString: String
    let weeks: [Int]
    var description: String {
        return "room: \(room), weeksString: \(weeksString), (weekday, index): (\(weekday), \(index))"
    }
}

extension CourseTableMatrixCell {
    init(x: Int, y: Int) {
        self.init(code: "", name: "", teacher: "", credit: "", room: "", weekday: x, index: y, weeksString: "", weeks: [])
    }
    init() {
        self.init(code: "H101750002032.01", name: "演示课程", teacher: "毛志勇", credit: "2", room: "静远楼", weekday: 4, index: 3, weeksString: "1-5", weeks: [1,2,3,4,5])
    }
}

// MARK: - CourseTableMatrix
struct CourseTableMatrix {
    var matrix: [[CourseTableMatrixCell]] = []
    
    init() {
        matrix.append([CourseTableMatrixCell()])
        for y in 1...5 {
            for x in 1...7 {
                matrix.append([CourseTableMatrixCell(x: x, y: y)])
            }
        }
    }
    
    subscript(x: Int, y: Int, at offset: Int = -1) -> [CourseTableMatrixCell] {
        get {
            return matrix[(y - 1) * 7 + x]
        }
        set(newValue) {
            if offset == 0 {
                matrix[(y - 1) * 7 + x].insert(contentsOf: newValue, at: matrix[(y - 1) * 7 + x].startIndex)
            } else {
                matrix[(y - 1) * 7 + x].insert(contentsOf: newValue, at: matrix[(y - 1) * 7 + x].endIndex)
            }
        }
    }
}
