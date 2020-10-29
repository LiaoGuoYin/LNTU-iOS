//
//  GradeViewModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import Foundation

class GradeViewModel: ObservableObject {
    
    @Published var user: User
    @Published var isShowBanner: Bool = false
    @Published var banner: BannerModifier.Data = BannerModifier.Data(content: "") {
        willSet {
            self.isShowBanner = true
        }
    }
    
    @Published var gradeList: [GradeResponseDataGrade]
    @Published var gradePointAverage: GradeResponseDataGPA
    
    init(user: User) {
        self.user = user
        self.gradeList = []
        self.gradePointAverage = GradeResponseDataGPA(semester: "", gradePointAverage: 0.0, weightedAverage: 0.0, gradePointTotal: 0.0, scoreTotal: 0.0, creditTotal: 0, courseCount: 0)
        self.refreshGradeList(semester: "2020-1")
    }
    
    init() {
        self.gradeList = try! JSONDecoder().decode(GradeResponse.self, from: gradeDemoData).data!.grade
        self.gradePointAverage = try! JSONDecoder().decode(GradeResponse.self, from: gradeDemoData).data!.gpa
        self.user = User(username: "10000", password: "*")
    }
    
}

extension GradeViewModel {
    func refreshGradeList(semester: String) {
        APIClient.grade(user: user, semester: semester) { (result) in
            switch result {
            case .failure(let error):
                self.banner.content = error.localizedDescription
            case .success(let response):
                guard let actualGradeResponseData = response.data else {
                    return
                }
                self.banner.type = .Success
                self.gradeList = actualGradeResponseData.grade
                self.gradePointAverage = actualGradeResponseData.gpa
                self.banner.content = "拉取成绩成功: \(response.message)"
            }
        }
    }
    
    func loadLocalGrade() {
        
    }
    
    func exportGradeToLocal() {
        
    }
    
}

let gradeDemoData = """
{
  "code": 200,
  "message": "Success",
  "data": {
    "grade": [
      {
        "name": "信息系统分析与设计",
        "credit": "3.5",
        "semester": "2019-20202",
        "status": "正常",
        "result": "93.3",
        "code": "H101730023056.01",
        "courseType": "专业必修",
        "usual": "89",
        "midTerm": "95",
        "endTerm": "94",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "point": "4"
      },
      {
        "name": "统计机器学习",
        "credit": "3",
        "semester": "2019-20202",
        "status": "正常",
        "result": "96",
        "code": "H101750041048.01",
        "courseType": "专业必修",
        "usual": "100",
        "midTerm": "100",
        "endTerm": "90",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "point": "4.5"
      },
      {
        "name": "大数据开发技术",
        "credit": "3",
        "semester": "2019-20202",
        "status": "正常",
        "result": "92",
        "code": "H101750042048.01",
        "courseType": "专业必修",
        "usual": "99",
        "midTerm": "95",
        "endTerm": "82",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "point": "4"
      },
      {
        "name": "大学生就业创业指导",
        "credit": "0.5",
        "semester": "2019-20202",
        "status": "正常",
        "result": "合格",
        "code": "H271780002016.25",
        "courseType": "综合教育课程",
        "usual": "",
        "midTerm": "",
        "endTerm": "合格",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "point": "3.5"
      },
      {
        "name": "数据分析设计",
        "credit": "2",
        "semester": "2019-20202",
        "status": "正常",
        "result": "优秀",
        "code": "H101772103002.01",
        "courseType": "集中实践教学",
        "usual": "",
        "midTerm": "",
        "endTerm": "优秀",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "point": "4.5"
      },
      {
        "name": "突发性疫情认知、防护与思考 *",
        "credit": "1.5",
        "semester": "2019-20202",
        "status": "正常",
        "result": "合格",
        "code": "CXTS2020.49",
        "courseType": "校级公选课（全校）",
        "usual": "",
        "midTerm": "",
        "endTerm": "合格",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "point": "3.5"
      },
      {
        "name": "专业实习",
        "credit": "4",
        "semester": "2019-20202",
        "status": "正常",
        "result": "优秀",
        "code": "H101775104004.01",
        "courseType": "集中实践教学",
        "usual": "",
        "midTerm": "",
        "endTerm": "优秀",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "point": "4.5"
      },
      {
        "name": "web 系统开发设计",
        "credit": "2",
        "semester": "2019-20202",
        "status": "正常",
        "result": "合格",
        "code": "H101772106002.01",
        "courseType": "集中实践教学",
        "usual": "",
        "midTerm": "",
        "endTerm": "合格",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "point": "3.5"
      },
      {
        "name": "信息系统项目管理",
        "credit": "3.5",
        "semester": "2019-20202",
        "status": "正常",
        "result": "95",
        "code": "H101750028056.01",
        "courseType": "专业必修",
        "usual": "99",
        "midTerm": "99",
        "endTerm": "89",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "point": "4.5"
      },
      {
        "name": "普通话水平测试轻松过 *",
        "credit": "1.5",
        "semester": "2019-20202",
        "status": "正常",
        "result": "优秀",
        "code": "CXTS0592.01",
        "courseType": "校级公选课（全校）",
        "usual": "",
        "midTerm": "",
        "endTerm": "优秀",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "point": "4.5"
      },
      {
        "name": "会计学",
        "credit": "2.5",
        "semester": "2019-20202",
        "status": "正常",
        "result": "86",
        "code": "H101730004040.01",
        "courseType": "专业必修",
        "usual": "17",
        "midTerm": "",
        "endTerm": "86",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "point": "3.5"
      }
    ],
    "gpa": {
      "semester": "2020-1",
      "gradePointAverage": 4.1389,
      "weightedAverage": 92.2426,
      "gradePointTotal": 111.75,
      "scoreTotal": 2490.55,
      "creditTotal": 27,
      "courseCount": 11
    }
  }
}
""".data(using: .utf8)!
