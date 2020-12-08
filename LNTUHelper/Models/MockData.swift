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
