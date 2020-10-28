//
//  CourseTableView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/26.
//

import SwiftUI

struct CourseTableView: View {
    
    @ObservedObject var viewModel: CourseTableViewModel
    @State var teachingWeek: Int = 9
    
    var body: some View {
        NavigationView {
            CourseTableBodyView(courseTableMatrix: $viewModel.martrix)
                .padding()
                .navigationBarTitle(Text("课表"), displayMode: .large)
                .navigationBarItems(trailing: refreshButton)
        }
        .banner(data: $viewModel.banner, isShow: $viewModel.isShowBanner)
    }
    
    var refreshButton: some View {
        Button(action: viewModel.refreshCourseTable) {
            Text("刷新")
        }
    }
}

struct CourseTableView_Previews: PreviewProvider {
    static var previews: some View {
        CourseTableView(viewModel: CourseTableViewModel(courseTableList: courseTableDemo!.data!))
    }
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
          "weeksString": "4-5 7-11",
          "weeks": [
            4,
            5,
            7,
            8,
            9,
            10,
            11
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
          "room": "静远楼 342",
          "weekday": 1,
          "index": 2,
          "weeksString": "4-9 11",
          "weeks": [
            4,
            5,
            6,
            7,
            8,
            9,
            11
          ]
        },
        {
          "room": "静远楼 342",
          "weekday": 1,
          "index": 3,
          "weeksString": "4-9 11",
          "weeks": [
            4,
            5,
            6,
            7,
            8,
            9,
            11
          ]
        },
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

let courseTableDemo = try? JSONDecoder().decode(CourseTableResponse.self, from: courseTableDemoData)
