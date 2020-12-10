//
//  MockData.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/12/4.
//

import UIKit

struct MockData {
    static let semester = Constants.currentSemester
    static let user = User(username: "1710030215", password: "")
    static let educationInfo = try! JSONDecoder().decode(EducationInfoResponse.self, from: educationInfoMockData).data!
    static let noticeList = try! JSONDecoder().decode(NoticeResponse.self, from: noticeMockData).data
    static let examPlanList = try! JSONDecoder().decode(ExamPlanResponse.self, from: examPlanMockData).data
    static let gradeList = try! JSONDecoder().decode(GradeResponse.self, from: gradeMockData).data
    static let courseTableList = try! JSONDecoder().decode(CourseTableResponse.self, from: courseTableMockData).data!
    static let classroomResponseData = try! JSONDecoder().decode(ClassroomResponse.self, from: classroomMockData).data
    static let qualityActivityList = try! JSONDecoder().decode(QualityActivityResponse.self, from: qualitActivityMockData).data
}

// MARK: - EducationInfoMockData
let educationInfoMockData = """
    {
      "code": 200,
      "message": "Success",
      "data": {
        "username": "111111111",
        "name": "测试用户",
        "photoURL": "http://202.199.224.119:8080/eams/showSelfAvatar.action?user.name=11111111",
        "nickname": "abc",
        "gender": "男",
        "grade": "2017",
        "educationLast": "4",
        "project": "主修",
        "education": "本科",
        "studentType": "本科 4 年",
        "college": "管理",
        "major": "信息",
        "direction": null,
        "enrollDate": "2017-09-01",
        "graduateDate": "2021-07-01",
        "chiefCollege": "测试学院",
        "studyType": "普通全日制",
        "membership": "是",
        "isInSchool": "是",
        "campus": "辽宁工大校区",
        "majorClass": "",
        "effectAt": "2017-09-01",
        "isInRecord": "是",
        "studentStatus": "在校",
        "isWorking": "否"
      }
    }
""".data(using: .utf8)!

// MARK: - CourseTableMockData
 let courseTableMockData = """
{
  "code": 200,
  "message": "Success",
  "data": [
    {
      "code": "H101750011032.01",
      "name": "数据分析案例",
      "teacher": "杨韬",
      "credit": "2",
      "scheduleList": [
        {
          "room": "静远楼345",
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
          "room": "静远楼345",
          "weekday": 2,
          "index": 1,
          "weeksString": "4-10",
          "weeks": [
            4,
            5,
            6,
            7,
            8,
            9,
            10
          ]
        },
        {
          "room": "静远楼345",
          "weekday": 2,
          "index": 1,
          "weeksString": "12",
          "weeks": [
            12
          ]
        },
        {
          "room": "静远楼345",
          "weekday": 2,
          "index": 1,
          "weeksString": "13",
          "weeks": [
            13
          ]
        },
        {
          "room": "耘慧楼312",
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
      "code": "H101750030040.02",
      "name": "网络规划与集成",
      "teacher": "杨彤骥",
      "credit": "2.5",
      "scheduleList": [
        {
          "room": "静远楼313",
          "weekday": 3,
          "index": 1,
          "weeksString": "双4-16",
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
          "room": "静远楼313",
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
    }
  ]
}
""".data(using: .utf8)!


// MARK: - ExamPlanMockData
let examPlanMockData = """
{
  "code": 200,
  "message": "Success",
  "data": [
    {
      "code": "H101750002032.01",
      "name": "信息系统安全",
      "type": "期末考试",
      "date": "时间未安排",
      "time": "时间未安排",
      "location": "地点未安排",
      "seatNumber": "地点未安排",
      "status": "正常",
      "comment": ""
    },
    {
      "code": "H101750011032.01",
      "name": "数据分析案例",
      "type": "期末考试",
      "date": "时间未安排",
      "time": "时间未安排",
      "location": "地点未安排",
      "seatNumber": "地点未安排",
      "status": "正常",
      "comment": ""
    },
    {
      "code": "H101750013032.02",
      "name": "网络营销",
      "type": "期末考试",
      "date": "2020-12-04",
      "time": "09:00~11:00",
      "location": "耘慧楼110",
      "seatNumber": "45",
      "status": "正常",
      "comment": ""
    },
    {
      "code": "H101750030040.02",
      "name": "网络规划与集成",
      "type": "期末考试",
      "date": "时间未安排",
      "time": "时间未安排",
      "location": "地点未安排",
      "seatNumber": "地点未安排",
      "status": "正常",
      "comment": ""
    },
    {
      "code": "H101750096032.02",
      "name": "软件测试",
      "type": "期末考试",
      "date": "2020-12-04",
      "time": "13:30~15:30",
      "location": "尔雅楼203",
      "seatNumber": "45",
      "status": "正常",
      "comment": ""
    },
    {
      "code": "H271780001002.A8",
      "name": "形势与政策",
      "type": "期末考试",
      "date": "时间未安排",
      "time": "时间未安排",
      "location": "地点未安排",
      "seatNumber": "地点未安排",
      "status": "正常",
      "comment": ""
    }
  ]
}
"""
.data(using: .utf8)!

// MARK: - GradeMockData
let gradeMockData = """
{
  "code": 200,
  "message": "Success",
  "data": [
    {
      "name": "测试课程",
      "credit": "5",
      "semester": "2020-春",
      "status": "正常",
      "result": "96",
      "code": "H271700001048.8",
      "courseType": "专业课",
      "midTerm": "0",
      "endTerm": "46",
      "usual": "50",
      "makeUpScore": null,
      "makeUpScoreResult": null,
      "totalScore": "96",
      "point": "4.5"
    },
    {
      "name": "计算机基础训练",
      "credit": "2",
      "semester": "2017-秋",
      "status": "正常",
      "result": "优秀",
      "code": "H101777100002.1",
      "courseType": "专业课",
      "midTerm": "--",
      "endTerm": "优秀",
      "usual": "优秀",
      "makeUpScore": null,
      "makeUpScoreResult": null,
      "totalScore": "优秀",
      "point": "4.5"
    },
    {
      "name": "大学体育（1）",
      "credit": "1",
      "semester": "2017-秋",
      "status": "正常",
      "result": "85",
      "code": "H271700001036.6",
      "courseType": "专业课",
      "midTerm": "--",
      "endTerm": "--",
      "usual": "--",
      "makeUpScore": null,
      "makeUpScoreResult": null,
      "totalScore": "85",
      "point": "3.5"
    },
    {
      "name": "高等数学（上）",
      "credit": "5.5",
      "semester": "2017-秋",
      "status": "正常",
      "result": "82",
      "code": "H271700001088.17",
      "courseType": "专业课",
      "midTerm": "87",
      "endTerm": "70",
      "usual": "30",
      "makeUpScore": null,
      "makeUpScoreResult": null,
      "totalScore": "82",
      "point": "3"
    },
    {
      "name": "大学外语（1）",
      "credit": "4",
      "semester": "2017-秋",
      "status": "正常",
      "result": "85",
      "code": "H271700001064.27",
      "courseType": "专业课",
      "midTerm": "55",
      "endTerm": "82",
      "usual": "30",
      "makeUpScore": null,
      "makeUpScoreResult": null,
      "totalScore": "85",
      "point": "3.5"
    },
    {
      "name": "大学生心理健康教育",
      "credit": "1",
      "semester": "2017-秋",
      "status": "正常",
      "result": "合格",
      "code": "H271780003016.23",
      "courseType": "专业课",
      "midTerm": "--",
      "endTerm": "--",
      "usual": "--",
      "makeUpScore": null,
      "makeUpScoreResult": null,
      "totalScore": "合格",
      "point": "3.5"
    },
    {
      "name": "大学生学业生涯规划与素质拓展指导",
      "credit": "1",
      "semester": "2017-秋",
      "status": "正常",
      "result": "合格",
      "code": "H271780001008.16",
      "courseType": "专业课",
      "midTerm": "--",
      "endTerm": "--",
      "usual": "--",
      "makeUpScore": null,
      "makeUpScoreResult": null,
      "totalScore": "合格",
      "point": "3.5"
    },
    {
      "name": "美学原理*",
      "credit": "1",
      "semester": "2017-秋",
      "status": "正常",
      "result": "合格",
      "code": "CX6221.1",
      "courseType": "C沟通与管理",
      "midTerm": "--",
      "endTerm": "--",
      "usual": "--",
      "makeUpScore": null,
      "makeUpScoreResult": null,
      "totalScore": "合格",
      "point": "3.5"
    },
    {
      "name": "网络创业理论与实践*",
      "credit": "1",
      "semester": "2017-秋",
      "status": "正常",
      "result": "合格",
      "code": "CX6210.6",
      "courseType": "专业课",
      "midTerm": "--",
      "endTerm": "--",
      "usual": "--",
      "makeUpScore": null,
      "makeUpScoreResult": null,
      "totalScore": "合格",
      "point": "3.5"
    },
    {
      "name": "专业概论",
      "credit": "1",
      "semester": "2017-秋",
      "status": "正常",
      "result": "合格",
      "code": "H101730011016.1",
      "courseType": "专业课",
      "midTerm": "--",
      "endTerm": "--",
      "usual": "--",
      "makeUpScore": null,
      "makeUpScoreResult": null,
      "totalScore": "合格",
      "point": "3.5"
    }
  ]
}
""".data(using: .utf8)!

// MARK: - NoticeMockData
let noticeMockData = """
{
  "code": 200,
  "message": "Success",
  "data": [
    {
      "title": "关于落实2021年春季学期教学任务的通知",
      "url": "https://jwzx.lntu.edu.cn/info/1100/1618.htm",
      "date": "2020-12-08"
    },
    {
      "title": "CET监考员守则",
      "url": "https://jwzx.lntu.edu.cn/index/../info/1103/1615.htm",
      "date": "2020-12-03"
    },
    {
      "title": "2020年12月大学英语四、六级考试防疫要求",
      "url": "https://jwzx.lntu.edu.cn/index/../info/1103/1613.htm",
      "date": "2020-12-03"
    },
    {
      "title": "全国大学外语四、六级考生须知",
      "url": "https://jwzx.lntu.edu.cn/index/../info/1103/1616.htm",
      "date": "2020-12-03"
    },
    {
      "title": "全国大学英语四、六级考试试音通知",
      "url": "https://jwzx.lntu.edu.cn/index/../info/1103/1617.htm",
      "date": "2020-12-03"
    }
  ]
}
"""
.data(using: .utf8)!

// MARK: - classroomMockData
let classroomMockData = """
{
  "code": 200,
  "message": "Success",
  "data": {
    "week": "10",
    "buildingName": "hldwlsys",
    "classroomList": [
      {
        "room": "H室外",
        "type": "室外",
        "capacity": "700",
        "scheduleList": [
          "01110",
          "01110",
          "01000",
          "01110",
          "01110",
          "00000",
          "00000"
        ]
      },
      {
        "room": "H物理实验室耘慧103",
        "type": "物理实验室",
        "capacity": "400",
        "scheduleList": [
          "00010",
          "01000",
          "00010",
          "01110",
          "00010",
          "00000",
          "00000"
        ]
      },
      {
        "room": "D3107",
        "type": "专用教室",
        "capacity": "40",
        "scheduleList": [
          "00000",
          "00000",
          "00000",
          "00000",
          "00000",
          "00000",
          "00000"
        ]
      },
      {
        "room": "H物理实验室II",
        "type": "物理实验室",
        "capacity": "400",
        "scheduleList": [
          "00000",
          "00000",
          "00000",
          "00000",
          "00000",
          "00000",
          "00000"
        ]
      }
    ]
  }
}
""".data(using: .utf8)!

// MARK: - QualityActivityMockData
let qualitActivityMockData = """
{
  "code": 200,
  "message": "离线模式: Success, 最后更新于: 2020-12-09 20:02:16",
  "data": [
    {
      "type": "employment",
      "id": "5",
      "name": "工商管理学院2018-2019下荣誉类活动",
      "semester": "2018-2019下",
      "activityDate": "2018-09-01-2019-09-01",
      "location": "测试17-2",
      "responsibility": "优秀",
      "loggingDateTime": "2019/9/1 13:46:34",
      "status": "认证通过",
      "comment": null
    },
    {
      "type": "employment",
      "id": "6",
      "name": "工商学院2017-2018下学生干部任职    ",
      "semester": "2017-2018下",
      "activityDate": "2017-09-01-2018-07-31",
      "location": "团支部信管17-2",
      "responsibility": "班长",
      "loggingDateTime": "2018/7/9 17:02:40",
      "status": "认证通过",
      "comment": null
    },
    {
      "type": "mind",
      "id": "1",
      "name": "工商学院17级“脚踏实地明理想，更进一步创未来”主题团会",
      "semester": "2020-2021上",
      "activityDate": "2020-11-01",
      "location": "辽宁省葫芦岛市",
      "responsibility": "参与者",
      "loggingDateTime": "2020/11/7 14:40:05",
      "status": "认证通过",
      "comment": null
    }
  ]
}
""".data(using: .utf8)!
