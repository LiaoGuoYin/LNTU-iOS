//
//  GradeView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import SwiftUI

struct GradeView: View {
    
    @ObservedObject var viewModel: GradeViewModel
    @State private var isShowDetail = false
    @State private var tappedCourse: GradeResponseDataGrade {
        didSet {
            isShowDetail = true
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(Array(viewModel.gradeResultKeyList), id: \.self) { key in
                            Text(key)
                                .foregroundColor(.white)
                                .padding()
                                .background(viewModel.selectedSemester == key ? Color("primary") : Color("primary").opacity(0.4))
                                .cornerRadius(6)
                                .onTapGesture {
                                    viewModel.selectedSemester = key
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                if viewModel.gradeResultKeyList.contains(viewModel.selectedSemester) {
                    ForEach(Array(arrayLiteral: viewModel.gradeResult[viewModel.selectedSemester]!), id: \.self) { each in
                        ForEach(each, id: \.code) { course in
                            GradeRowView(course: course)
                                .padding(.horizontal)
                                .padding(.vertical, 2)
                                .onTapGesture {
                                    self.tappedCourse = course
                                }
                        }
                    }
                } else {
                    Text("Oops, 还没有考试成绩噢")
                        .padding()
                }
                // SemesterPickerView()
                // GradePointAverageView(gpa: $viewModel.gradePointAverage)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarItems(trailing: refreshButton)
            .navigationBarTitle("成绩",displayMode: .large)
            .sheet(isPresented: $isShowDetail) {
                GradeRowDetailView(course: $tappedCourse)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .banner(data: $viewModel.banner, isShow: $viewModel.isShowBanner)
    }
    
    var refreshButton: some View {
        Button(action: {
            Haptic.shared.tappedHaptic()
            viewModel.refreshGradeList {
                viewModel.selectedSemester = viewModel.gradeResultKeyList.first ?? "2020-春"
            }
        }) {
            Text("刷新")
                .foregroundColor(Color("primary"))
        }
    }
}

extension GradeView {
    init(viewModel: GradeViewModel) {
        let tappedCourse = viewModel.gradeList.first ?? GradeResponseDataGrade()
        self.init(viewModel: viewModel, tappedCourse: tappedCourse)
    }
}

struct GradeView_Previews: PreviewProvider {
    static var previews: some View {
        let demoData = """
{
  "code": 200,
  "message": "Success",
  "data": {
    "grade": [
      {
        "name": "思想道德修养与法律基础",
        "credit": "3",
        "semester": "2017-秋",
        "status": "正常",
        "result": "72",
        "code": "H271700001048.8",
        "courseType": "专业课",
        "midTerm": "0",
        "endTerm": "53",
        "usual": "45.9",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "72",
        "point": "2"
      },
      {
        "name": "面向对象程序设计（Java）",
        "credit": "3",
        "semester": "2018-春",
        "status": "正常",
        "result": "91",
        "code": "H101730024048.1",
        "courseType": "专业课",
        "midTerm": "98",
        "endTerm": "82",
        "usual": "20",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "91",
        "point": "4"
      },
      {
        "name": "管理学",
        "credit": "2.5",
        "semester": "2018-春",
        "status": "正常",
        "result": "61",
        "code": "H101710002040.2",
        "courseType": "专业课",
        "midTerm": "0",
        "endTerm": "51",
        "usual": "20",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "61",
        "point": "1"
      },
      {
        "name": "广告作品赏析*",
        "credit": "1",
        "semester": "2018-春",
        "status": "正常",
        "result": "良",
        "code": "HXC26150133.1",
        "courseType": "专业课",
        "midTerm": "--",
        "endTerm": "--",
        "usual": "--",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "良",
        "point": "3.5"
      },
      {
        "name": "云计算与大数据*",
        "credit": "1.5",
        "semester": "2018-春",
        "status": "正常",
        "result": "良",
        "code": "HXC2715837.1",
        "courseType": "专业课",
        "midTerm": "--",
        "endTerm": "--",
        "usual": "--",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "良",
        "point": "3.5"
      },
      {
        "name": "程序设计基础实训",
        "credit": "1",
        "semester": "2018-春",
        "status": "正常",
        "result": "合格",
        "code": "H101777101001.1",
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
        "name": "大学体育（2）",
        "credit": "1",
        "semester": "2018-春",
        "status": "正常",
        "result": "93",
        "code": "H271700002036.98",
        "courseType": "专业课",
        "midTerm": "--",
        "endTerm": "--",
        "usual": "--",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "93",
        "point": "4"
      },
      {
        "name": "大学外语（3）",
        "credit": "4",
        "semester": "2018-秋",
        "status": "正常",
        "result": "82",
        "code": "H271700003064.28",
        "courseType": "专业课",
        "midTerm": "0",
        "endTerm": "75",
        "usual": "29",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "82",
        "point": "3"
      },
      {
        "name": "市场营销策略",
        "credit": "1",
        "semester": "2018-秋",
        "status": "正常",
        "result": "84",
        "code": "HCX0008.1",
        "courseType": "专业课",
        "midTerm": "0",
        "endTerm": "85",
        "usual": "16",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "84",
        "point": "3"
      },
      {
        "name": "运筹学",
        "credit": "3.5",
        "semester": "2018-秋",
        "status": "正常",
        "result": "72",
        "code": "H101710002056.1",
        "courseType": "专业课",
        "midTerm": "0",
        "endTerm": "60",
        "usual": "30",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "72",
        "point": "2"
      },
      {
        "name": "概率论与数理统计",
        "credit": "3.5",
        "semester": "2018-秋",
        "status": "正常",
        "result": "73",
        "code": "H271700001056.5",
        "courseType": "专业课",
        "midTerm": "0",
        "endTerm": "62",
        "usual": "30",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "73",
        "point": "2"
      },
      {
        "name": "计算机网络",
        "credit": "3",
        "semester": "2018-秋",
        "status": "正常",
        "result": "91",
        "code": "H101730020048.1",
        "courseType": "专业课",
        "midTerm": "0",
        "endTerm": "89",
        "usual": "20",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "91",
        "point": "4"
      },
      {
        "name": "马克思主义基本原理概论",
        "credit": "3",
        "semester": "2018-秋",
        "status": "正常",
        "result": "73",
        "code": "H271700002048.2",
        "courseType": "专业课",
        "midTerm": "0",
        "endTerm": "61",
        "usual": "30",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "73",
        "point": "2"
      },
      {
        "name": "创业基础",
        "credit": "2",
        "semester": "2018-秋",
        "status": "正常",
        "result": "88",
        "code": "H151780000032.5",
        "courseType": "专业课",
        "midTerm": "0",
        "endTerm": "83",
        "usual": "99.4",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "88",
        "point": "3.5"
      },
      {
        "name": "股票交易实务*",
        "credit": "1.5",
        "semester": "2018-秋",
        "status": "正常",
        "result": "84",
        "code": "HCX0004.1",
        "courseType": "专业课",
        "midTerm": "--",
        "endTerm": "84",
        "usual": "--",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "84",
        "point": "3"
      },
      {
        "name": "大学体育（3）",
        "credit": "1",
        "semester": "2018-秋",
        "status": "正常",
        "result": "90",
        "code": "H271700003036.103",
        "courseType": "专业课",
        "midTerm": "--",
        "endTerm": "--",
        "usual": "--",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "90",
        "point": "4"
      },
      {
        "name": "数据结构与算法分析",
        "credit": "4",
        "semester": "2018-秋",
        "status": "正常",
        "result": "95",
        "code": "H101730016064.1",
        "courseType": "专业课",
        "midTerm": "100",
        "endTerm": "92",
        "usual": "20",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "95",
        "point": "4.5"
      },
      {
        "name": "数据分析设计",
        "credit": "2",
        "semester": "2020-春",
        "status": "正常",
        "result": "优秀",
        "code": "H101772103002.01",
        "courseType": "集中实践教学",
        "midTerm": "",
        "endTerm": "优秀",
        "usual": "",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "优秀",
        "point": "4.5"
      },
      {
        "name": "web系统开发设计",
        "credit": "2",
        "semester": "2020-春",
        "status": "正常",
        "result": "合格",
        "code": "H101772106002.01",
        "courseType": "集中实践教学",
        "midTerm": "",
        "endTerm": "合格",
        "usual": "",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "合格",
        "point": "3.5"
      },
      {
        "name": "大学生就业创业指导",
        "credit": "0.5",
        "semester": "2020-春",
        "status": "正常",
        "result": "合格",
        "code": "H271780002016.25",
        "courseType": "综合教育课程",
        "midTerm": "",
        "endTerm": "合格",
        "usual": "",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "合格",
        "point": "3.5"
      },
      {
        "name": "专业实习",
        "credit": "4",
        "semester": "2020-春",
        "status": "正常",
        "result": "优秀",
        "code": "H101775104004.01",
        "courseType": "集中实践教学",
        "midTerm": "",
        "endTerm": "优秀",
        "usual": "",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "优秀",
        "point": "4.5"
      },
      {
        "name": "信息系统分析与设计",
        "credit": "3.5",
        "semester": "2020-春",
        "status": "正常",
        "result": "93.3",
        "code": "H101730023056.01",
        "courseType": "专业必修",
        "midTerm": "95",
        "endTerm": "94",
        "usual": "89",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "93.3",
        "point": "4"
      }
    ],
    "gpa": {
      "semester": "all",
      "gradePointAverage": 3.2946,
      "weightedAverage": 84.502,
      "gradePointTotal": 489.25,
      "scoreTotal": 12548.55,
      "creditTotal": 148.5,
      "courseCount": 61
    }
  }
}
""".data(using: .utf8)!
        let responseDemo = try! JSONDecoder().decode(GradeResponse.self, from: demoData)
        let viewModel = GradeViewModel(user: User(username: "1710030215", password: "*"))
        viewModel.gradeList = responseDemo.data!.grade
        viewModel.gradePointAverage = responseDemo.data!.gpa
        return GradeView(viewModel: viewModel)
    }
}

