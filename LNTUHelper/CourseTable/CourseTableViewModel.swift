//
//  CourseTableViewModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/26.
//

import Foundation

class CourseTableViewModel: ObservableObject {
    
    @Published var isShowBanner: Bool = false
    @Published var banner: BannerModifier.Data = BannerModifier.Data(content: "") {
        willSet {
            self.isShowBanner = true
        }
    }
    
    @Published var user: User
    @Published var martrix = CourseTableMatrix()
    @Published var currentWeek: Int = 10 {
        willSet {
            self.martrix = flatToMatrix(courseList: courseTableResponseList, currentWeek: newValue)
        }
    }
    @Published var courseTableResponseList: [CourseTableResponseData] {
        willSet {
            self.martrix = flatToMatrix(courseList: newValue, currentWeek: currentWeek)
        }
    }
    
    init(user: User) {
        self.user = user
        self.courseTableResponseList = []
        self.refreshCourseTable()
    }
}

extension CourseTableViewModel {
    func refreshCourseTable() {
        APIClient.courseTable(user: self.user, semester: "2020-2") { (result) in
            switch result {
            case .failure(let error):
                self.banner.type = .Error
                self.banner.title = "拉取课表失败"
                self.banner.content = error.localizedDescription
            case .success(let response):
                self.banner.content = response.message
                if response.code == 200 {
                    self.banner.type = .Success
                    self.banner.title = "拉取课表成功"
                    guard response.data != nil else { return }
                    self.courseTableResponseList = response.data!
                } else {
                    self.banner.type = .Error
                    self.banner.title = "拉取课表失败"
                }
            }
        }
    }
}

func flatToMatrix(courseList: [CourseTableResponseData], currentWeek: Int) -> CourseTableMatrix {
    var courseTableMatrix = CourseTableMatrix()
    
    // 按照 scheudles 展平
    courseList.forEach { (course) in
        course.schedules.forEach { (schedule) in
            let cell = CourseTableMatrixCell(code: course.code, name: course.name, teacher: course.teacher, credit: course.credit, room: schedule.room, weekday: schedule.weekday, index: schedule.index, weeksString: schedule.weeksString, weeks: schedule.weeks)
            if schedule.weeks.contains(currentWeek)  {
                courseTableMatrix[schedule.weekday, schedule.index].insert(cell, at: courseTableMatrix[schedule.weekday, schedule.index].startIndex)
            } else {
                courseTableMatrix[schedule.weekday, schedule.index].append(cell)
            }
        }
    }
    
    return courseTableMatrix
}

let courseTableDemoData = """
{
  "code": 200,
  "message": "Success",
  "data": [
    {
      "code": "H101750002032.01",
      "name": "信息系统安全",
      "teacher": "毛志勇",
      "credit": "2",
      "schedules": [
        {
          "room": "静远楼 344",
          "weekday": 4,
          "index": 2,
          "weeksString": "4-11",
          "weeks": [
            4,
            5,
            6,
            7,
            8,
            9,
            10,
            11
          ]
        },
        {
          "room": "静远楼 344",
          "weekday": 2,
          "index": 2,
          "weeksString": "4-11",
          "weeks": [
            4,
            5,
            6,
            7,
            8,
            9,
            10,
            11
          ]
        }
      ]
    },
    {
      "code": "H101750011032.01",
      "name": "数据分析案例",
      "teacher": "杨韬",
      "credit": "2",
      "schedules": [
        {
          "room": "静远楼 345",
          "weekday": 5,
          "index": 2,
          "weeksString": "4-5 7-8 10-11",
          "weeks": [
            4,
            5,
            7,
            8,
            10,
            11
          ]
        },
        {
          "room": "静远楼 345",
          "weekday": 2,
          "index": 1,
          "weeksString": "4-11",
          "weeks": [
            4,
            5,
            6,
            7,
            8,
            9,
            10,
            11
          ]
        },
        {
          "room": "静远楼 345",
          "weekday": 2,
          "index": 1,
          "weeksString": "12",
          "weeks": [
            12
          ]
        },
        {
          "room": "耘慧楼 312",
          "weekday": 6,
          "index": 2,
          "weeksString": "6",
          "weeks": [
            6
          ]
        }
      ]
    },
    {
      "code": "H101750013032.02",
      "name": "网络营销",
      "teacher": "张芳",
      "credit": "2",
      "schedules": [
        {
          "room": "静远楼 242",
          "weekday": 1,
          "index": 2,
          "weeksString": "12",
          "weeks": [
            12
          ]
        },
        {
          "room": "静远楼 242",
          "weekday": 1,
          "index": 3,
          "weeksString": "12",
          "weeks": [
            12
          ]
        },
        {
          "room": "静远楼 342",
          "weekday": 1,
          "index": 2,
          "weeksString": "4-9 11",
          "weeks": [
            11
          ]
        },
        {
          "room": "静远楼 342",
          "weekday": 1,
          "index": 3,
          "weeksString": "4-9 11",
          "weeks": [
            11
          ]
        }
      ]
    },
    {
      "code": "H101750030040.02",
      "name": "网络规划与集成",
      "teacher": "杨彤骥",
      "credit": "2.5",
      "schedules": [
        {
          "room": "静远楼 313",
          "weekday": 3,
          "index": 1,
          "weeksString": "双 4-16",
          "weeks": [
            4,
            6,
            8,
            10,
            12,
            14,
            16
          ]
        },
        {
          "room": "静远楼 313",
          "weekday": 1,
          "index": 1,
          "weeksString": "4-16",
          "weeks": [
            4,
            5,
            6,
            7,
            8,
            9,
            10,
            11,
            12,
            13,
            14,
            15,
            16
          ]
        }
      ]
    },
    {
      "code": "H101750096032.02",
      "name": "软件测试",
      "teacher": "王彦彬",
      "credit": "2",
      "schedules": [
        {
          "room": "静远楼 315",
          "weekday": 5,
          "index": 1,
          "weeksString": "4-13",
          "weeks": [
            4,
            5,
            6,
            7,
            8,
            9,
            10,
            11,
            12,
            13
          ]
        },
        {
          "room": "静远楼 315",
          "weekday": 3,
          "index": 2,
          "weeksString": "4-9",
          "weeks": [
            4,
            5,
            6,
            7,
            8,
            9
          ]
        }
      ]
    },
    {
      "code": "H101772105002.02",
      "name": "信息系统分析与设计",
      "teacher": "杨彤骥",
      "credit": "2",
      "schedules": []
    },
    {
      "code": "H101777102001.02",
      "name": "erp 实训",
      "teacher": "杨红玉",
      "credit": "1",
      "schedules": []
    },
    {
      "code": "H271780001002.A8",
      "name": "形势与政策",
      "teacher": "刘蔚",
      "credit": "2",
      "schedules": [
        {
          "room": "尔雅楼 101",
          "weekday": 1,
          "index": 5,
          "weeksString": "8",
          "weeks": [
            8
          ]
        }
      ]
    }
  ]
}
""".data(using: .utf8)!
