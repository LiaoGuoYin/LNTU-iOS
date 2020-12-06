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
    

// MARK: - NoticeMockData
let noticeMockData = """
{
  "code": 200,
  "message": "Success",
  "data": [
    {
      "title": "全国大学英语四、六级考试试音通知",
      "date": "2020-12-03",
      "content": "全国大学英语四、六级考试试音通知  一、阜新校区试音时间：12月10日（周四）至11日（周五）上午9：30至下午15：00试音频率：大学英语考试台，南校区FM74，北校区FM86试音内容：“您现在收听的是大学英语考试台，You are listening for College English Test；请检查答题卡上考号与卷种是否填涂正确，Please check your number and type of paper on the answer sheet.”请考生务必到所在考场各个角落提前试音，若有问题及时向外国语学院反馈，反馈电话：13904180505。二、葫芦岛校区试音时间：12月9日（周三）至10日（周四）上午10：00至下午14：00 试音频率：FM 83MHZ。试音内容：“您现在收听的是辽宁工程技术大学大学英语广播电台”。请考生务必到所在考场各个角落提前试音，若有问题及时向基础教学部反馈，反馈电话：15124292381。   辽宁工程技术大学全国大学外语等级考试领导小组                                               2020年12月3日",
      "appendix": [],
      "url": "http://jwzx.lntu.edu.cn/index/../info/1103/1617.htm"
    },
    {
      "title": "全国大学外语四、六级考生须知",
      "date": "2020-12-03",
      "content": "全国大学外语四、六级考生须知     本次考试，考生进入校园及考试楼参加考试需要携带并提交出示的证件及防疫要求，请考生详细阅读教务在线教务公告内《2020年12月大学英语四、六级考试防疫要求》（http://jwzx.lntu.edu.cn/info/1103/1613.htm）通知。一、考试当天（12月12日）必须按规定的时间（上午8：20开始，下午2：20开始）入场，入场开始40分钟（即上午9：00，下午3：00）后，禁止入场。入场时必须主动出示准考证以及有效身份证件（下列证件之一：居民身份证、户口本、公安户籍部门开具的贴有近期免冠照片的身份证号码证明、护照等）、学生证（全日制在校生），接受考试工作人员核验，并按要求在考场座位表上签名。二、考生须携带HB-2B铅笔(涂答题卡用)、黑色签字笔、橡皮等文具。任何书籍、笔记、资料、报刊、草稿纸以及各种无线通信工具（如寻呼机、移动电话）、录放音机、电子记事本等违规物品不得携带入场，一经发现，将按违规处理，成绩无效。三、入场后，要对号入座，将本人准考证以及有效身份证件放在课桌上，以便核验。四、答题前应认真阅读试题册正面的“敬告考生”内容，按要求填写答题卡中的姓名、准考证号等栏目。凡答题卡中该栏目漏填涂、错填涂或字迹不清、无法辩认的，成绩无效。英语四级（CET4）和英语六级（CET6）还需将试题册背面条形码粘贴条粘贴至答题卡1上规定位置，错贴、漏贴、损毁条形码粘贴条将按违规处理，成绩无效。除有特殊原因，在考试结束前禁止提前退场。五、必须严格按要求做答题目。书写部分一律用黑色字迹签字笔做答，填涂信息点时须使用HB-2B铅笔在答题卡上相应位置填涂，修改时须用橡皮擦净。只能在规定考生做答的位置书写或填涂信息点。不按规定要求填涂和做答的，一律无效。六、英语四级（CET4）和英语六级（CET6）须在规定时间内依次完成作文、听力、阅读、翻译各部分考试，作答作文期间不得翻阅该试题册。听力录音播放完毕后，请立即停止作答，监考员将立即回收答题卡1，得到监考员指令后方可继续作答。作文题内容印在试题册背面，作文题及其他主观题必须用黑色签字笔在答题卡指定区域内作答，选择题均为单选题，错选、不选或多选将不得分。七、遇试卷分发错误或试题字迹不清等情况应及时要求更换；涉及试题内容的疑问，不得向监考员询问。八、考生应自觉遵守考试纪录，诚信应考，拒绝作弊行为，考场内服从考试工作人员管理，保持良好考试秩序。实施作弊行为一经发现将按违规处理取消成绩，对扰乱考场秩序，参与作弊团伙、恐吓、威胁考试工作人员的将移交公安机关追究其责任。九、考试期间非听力考试时间，不得佩戴耳机，否则按违规处理，成绩无效。十、考试结束铃声响时，要立即停止答题，将试卷扣放在桌面上，待监考员允许后方可离开考场。离开考场时必须交卷，不准携带试卷、答题卡离开考场。                     祝同学们考试顺利，取得优异成绩！                              全国大学外语等级考试工作领导小组                 二〇二〇年十二月三日",
      "appendix": [],
      "url": "http://jwzx.lntu.edu.cn/index/../info/1103/1616.htm"
    },
    {
      "title": "关于全国大学外语等级考试封楼的通知",
      "date": "2020-12-03",
      "content": "关于全国大学外语等级考试封楼的通知  我校在2020年12月12日（星期六）举行全国大学外语等级考试，按照需要须将考试楼封闭，现将具体情况通知如下：2020年12月11日17：30分至12日18：00分，对博雅楼（中华路校园）、博文楼（玉龙校园）、尔雅楼（葫芦岛龙湾校园）、耘慧楼（葫芦岛龙湾校园）、静远楼（葫芦岛龙湾校园）进行封闭。在上述时间段内与全国大学外语等级考试无关人员禁止入内。请各有关单位、实验室等在2020年12月11日17：30分前处理好本单位在封楼期间需在考试楼内办理的相关事务，提前安排好工作日程，做好相应安排和调整，避免所安排工作与考试时间发生冲突。因考试封楼给各位教职员工的工作带来不便，敬请谅解。   辽宁工程技术大学全国大学外语等级考试领导小组               2020年12月3日",
      "appendix": [],
      "url": "http://jwzx.lntu.edu.cn/index/../info/1103/1614.htm"
    }
  ]
}
"""
.data(using: .utf8)!
