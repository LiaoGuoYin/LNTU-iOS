//
//  CourseTableModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/26.
//

import Foundation

// MARK: - CourseTable
struct CourseTableResponse: Codable {
    let code: Int
    let message: String
    let data: [CourseTableResponseData]?
}

// MARK: - CourseTableResponseData
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
        self.init(code: "H101750002032.01", name: "信息系统安全", teacher: "毛志勇", credit: "2", schedules: [Schedule(room: "静远楼", weekday: 4, index: 3, weeksString: "1-5", weeks: [1,2,3,4,5])])
    }
    
    func exportToCellList() -> [CourseTableCell] {
        var courseTableCellList: [CourseTableCell] = []
        if schedules.count != 0 {
            for i in schedules.indices {
                courseTableCellList.append(
                    CourseTableCell(code: code, name: name, teacher: teacher, credit: credit, room: schedules[i].room, weekday: schedules[i].weekday, index: schedules[i].index, weeksString: schedules[i].weeksString, weeks: schedules[i].weeks)
                )
            }
        }
        return courseTableCellList
    }
}

struct CourseTableCell: Codable {
    let code, name, teacher, credit: String
    
    let room: String
    let weekday, index: Int
    let weeksString: String
    let weeks: [Int]
}

extension CourseTableCell {
    
    init() {
        self.init(code: "H101750002032.01", name: "信息系统安全", teacher: "毛志勇", credit: "2", room: "静远楼342", weekday: 4, index: 3,weeksString: "1-5", weeks: [1,2,3,4,5])
    }
    
    init(row: Int, column: Int) {
        self.init(code: "", name: "", teacher: "", credit: "", room: "", weekday: column, index: row, weeksString: "", weeks: [])
    }
    
}

struct CourseTableMatrix {
    var courseTableCellList: [CourseTableCell]
    var matrix: [CourseTableCell]
    
    mutating func generateMatrix() {
        for i in 0...4 {
            for j in 0...7 {
                matrix.append(CourseTableCell(row: i + 1, column: j + 1))
            }
        }
        for cell in courseTableCellList {
            let row = cell.index
            let column = cell.weekday
            matrix[(row-1)*7+column] = cell
        }
    }
}

extension CourseTableMatrix {
    init(courseTableCellList: [CourseTableCell]) {
        self.courseTableCellList = courseTableCellList
        self.matrix = []
        generateMatrix()
    }
}
