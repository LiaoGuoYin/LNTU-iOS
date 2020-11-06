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
    @State var selectedSemester: String = "2020-春"

    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(Array(viewModel.gradeResultKeyList), id: \.self) { key in
                            Text(key)
                                .foregroundColor(.white)
                                .padding()
                                .background(selectedSemester == key ? Color("primary") : Color(.systemBlue))
                                .cornerRadius(6)
                                .onTapGesture {
                                    self.selectedSemester = key
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                if viewModel.gradeResultKeyList.contains(selectedSemester) {
                    ForEach(Array(arrayLiteral: viewModel.gradeResult[selectedSemester]!), id: \.self) { each in
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
                    Text("Opps, 还没有考试记录噢")
                        .padding()
                }
                //                    SemesterPickerView()
                //                    GradePointAverageView(gpa: $viewModel.gradePointAverage)
            }
            .navigationBarItems(trailing: refreshButton)
            .navigationBarTitle("成绩",displayMode: .large)
            .navigationViewStyle(DefaultNavigationViewStyle())
            .sheet(isPresented: $isShowDetail) {
                GradeRowDetailView(course: tappedCourse)
            }
        }
        .banner(data: $viewModel.banner, isShow: $viewModel.isShowBanner)
    }
    
    var refreshButton: some View {
        Button(action: {
            Haptic.shared.complexSuccess()
            viewModel.refreshGradeList(semester: "2020-秋")
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
        "semester": "2017-20181",
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
        "name": "计算机基础训练",
        "credit": "2",
        "semester": "2017-20181",
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
        "semester": "2017-20181",
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
        "semester": "2017-20181",
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
        "semester": "2017-20181",
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
        "semester": "2017-20181",
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
        "semester": "2017-20181",
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
        "name": "美学原理 *",
        "credit": "1",
        "semester": "2017-20181",
        "status": "正常",
        "result": "合格",
        "code": "CX6221.1",
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
        "name": "网络创业理论与实践 *",
        "credit": "1",
        "semester": "2017-20181",
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
        "semester": "2017-20181",
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
      },
      {
        "name": "军事理论",
        "credit": "1",
        "semester": "2017-20181",
        "status": "正常",
        "result": "74",
        "code": "H271780001036.18",
        "courseType": "专业课",
        "midTerm": "0",
        "endTerm": "47",
        "usual": "50",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "74",
        "point": "2"
      },
      {
        "name": "军事训练",
        "credit": "1",
        "semester": "2017-20181",
        "status": "正常",
        "result": "合格",
        "code": "H271781001003.1",
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
        "name": "程序设计基础",
        "credit": "4",
        "semester": "2017-20181",
        "status": "正常",
        "result": "94",
        "code": "H101710014048.1",
        "courseType": "专业课",
        "midTerm": "95",
        "endTerm": "93",
        "usual": "10",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "94",
        "point": "4"
      },
      {
        "name": "大学生职业生涯规划",
        "credit": "0.5",
        "semester": "2017-20182",
        "status": "正常",
        "result": "合格",
        "code": "H271780001016.12",
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
        "name": "大学外语（2）",
        "credit": "4",
        "semester": "2017-20182",
        "status": "正常",
        "result": "81",
        "code": "H271700002064.28",
        "courseType": "专业课",
        "midTerm": "71",
        "endTerm": "73",
        "usual": "30",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "81",
        "point": "3"
      },
      {
        "name": "中国近现代史纲要",
        "credit": "2",
        "semester": "2017-20182",
        "status": "正常",
        "result": "68",
        "code": "H271700001032.7",
        "courseType": "专业课",
        "midTerm": "0",
        "endTerm": "46",
        "usual": "40",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "68",
        "point": "1.5"
      },
      {
        "name": "高等数学（下）",
        "credit": "5.5",
        "semester": "2017-20182",
        "status": "正常",
        "result": "66",
        "code": "H271700002088.3",
        "courseType": "专业课",
        "midTerm": "72",
        "endTerm": "48",
        "usual": "30",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "66",
        "point": "1.5"
      },
      {
        "name": "线性代数",
        "credit": "2.5",
        "semester": "2017-20182",
        "status": "正常",
        "result": "70",
        "code": "H271700001040.1",
        "courseType": "专业课",
        "midTerm": "0",
        "endTerm": "57",
        "usual": "30",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "70",
        "point": "2"
      },
      {
        "name": "面向对象程序设计（Java）",
        "credit": "3",
        "semester": "2017-20182",
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
        "semester": "2017-20182",
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
        "name": "广告作品赏析 *",
        "credit": "1",
        "semester": "2017-20182",
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
        "name": "云计算与大数据 *",
        "credit": "1.5",
        "semester": "2017-20182",
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
        "semester": "2017-20182",
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
        "semester": "2017-20182",
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
        "semester": "2018-20191",
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
        "name": "市场营销策略 *",
        "credit": "1",
        "semester": "2018-20191",
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
        "semester": "2018-20191",
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
        "semester": "2018-20191",
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
        "semester": "2018-20191",
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
        "semester": "2018-20191",
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
        "semester": "2018-20191",
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
        "name": "股票交易实务 *",
        "credit": "1.5",
        "semester": "2018-20191",
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
        "semester": "2018-20191",
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
        "semester": "2018-20191",
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
        "name": "大学体育（4）",
        "credit": "1",
        "semester": "2018-20192",
        "status": "正常",
        "result": "84",
        "code": "H271700004036.104",
        "courseType": "专业课",
        "midTerm": "--",
        "endTerm": "--",
        "usual": "--",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "84",
        "point": "3"
      },
      {
        "name": "管理信息系统",
        "credit": "3",
        "semester": "2018-20192",
        "status": "正常",
        "result": "74",
        "code": "H101710010048.1",
        "courseType": "专业课",
        "midTerm": "0",
        "endTerm": "67",
        "usual": "20",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "74",
        "point": "2"
      },
      {
        "name": "大学体育（4）",
        "credit": "1",
        "semester": "2018-20192",
        "status": "正常",
        "result": "84",
        "code": "F141700004036.0",
        "courseType": "专业课",
        "midTerm": "--",
        "endTerm": "--",
        "usual": "--",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "84",
        "point": "3"
      },
      {
        "name": "毛泽东思想和中国特色社会主义理论体系概论",
        "credit": "5",
        "semester": "2018-20192",
        "status": "正常",
        "result": "75",
        "code": "H271700007080.5",
        "courseType": "专业课",
        "midTerm": "0",
        "endTerm": "54",
        "usual": "48",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "75",
        "point": "2.5"
      },
      {
        "name": "大学外语（4）",
        "credit": "4",
        "semester": "2018-20192",
        "status": "正常",
        "result": "79",
        "code": "H271700004064.29",
        "courseType": "专业课",
        "midTerm": "0",
        "endTerm": "70",
        "usual": "30",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "79",
        "point": "2.5"
      },
      {
        "name": "认识实习",
        "credit": "2",
        "semester": "2018-20192",
        "status": "正常",
        "result": "优秀",
        "code": "H101775002002.1",
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
        "name": "数据库原理及应用",
        "credit": "4.5",
        "semester": "2018-20192",
        "status": "正常",
        "result": "98",
        "code": "H101730019072.1",
        "courseType": "专业课",
        "midTerm": "100",
        "endTerm": "97",
        "usual": "10",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "98",
        "point": "4.5"
      },
      {
        "name": "操作系统",
        "credit": "4",
        "semester": "2018-20192",
        "status": "正常",
        "result": "79",
        "code": "H101730022064.1",
        "courseType": "专业课",
        "midTerm": "100",
        "endTerm": "69",
        "usual": "20",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "79",
        "point": "2.5"
      },
      {
        "name": "中外经典名著导读 *",
        "credit": "1",
        "semester": "2019-20201",
        "status": "正常",
        "result": "优秀",
        "code": "HXC17005.1",
        "courseType": "专业课",
        "midTerm": "--",
        "endTerm": "--",
        "usual": "--",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "优秀",
        "point": "4.5"
      },
      {
        "name": "生命科学导论 *",
        "credit": "1.5",
        "semester": "2019-20201",
        "status": "正常",
        "result": "85",
        "code": "HXC17015.1",
        "courseType": "专业课",
        "midTerm": "0",
        "endTerm": "79",
        "usual": "30",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "85",
        "point": "3.5"
      },
      {
        "name": "web 系统开发",
        "credit": "3",
        "semester": "2019-20201",
        "status": "正常",
        "result": "93",
        "code": "H101750026048.1",
        "courseType": "专业课",
        "midTerm": "0",
        "endTerm": "94",
        "usual": "18",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "93",
        "point": "4"
      },
      {
        "name": "微机原理（双语）",
        "credit": "2.5",
        "semester": "2019-20201",
        "status": "正常",
        "result": "98",
        "code": "H101730021040.1",
        "courseType": "专业课",
        "midTerm": "100",
        "endTerm": "98",
        "usual": "19",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "98",
        "point": "4.5"
      },
      {
        "name": "管理统计学",
        "credit": "3",
        "semester": "2019-20201",
        "status": "正常",
        "result": "85",
        "code": "H101730033048.1",
        "courseType": "专业课",
        "midTerm": "95",
        "endTerm": "74",
        "usual": "20",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "85",
        "point": "3.5"
      },
      {
        "name": "经济学",
        "credit": "2",
        "semester": "2019-20201",
        "status": "正常",
        "result": "79",
        "code": "H101710001032.1",
        "courseType": "专业课",
        "midTerm": "0",
        "endTerm": "57",
        "usual": "50",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "79",
        "point": "2.5"
      },
      {
        "name": "企业资源计划（ERP）",
        "credit": "3",
        "semester": "2019-20201",
        "status": "正常",
        "result": "90",
        "code": "H101750037048.1",
        "courseType": "专业课",
        "midTerm": "0",
        "endTerm": "88",
        "usual": "37",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "90",
        "point": "4"
      },
      {
        "name": "程序设计（python）",
        "credit": "3.5",
        "semester": "2019-20201",
        "status": "正常",
        "result": "91",
        "code": "H101750010056.1",
        "courseType": "专业课",
        "midTerm": "100",
        "endTerm": "82",
        "usual": "30",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "91",
        "point": "4"
      },
      {
        "name": "普通话水平测试轻松过",
        "credit": "1.5",
        "semester": "2019-20202",
        "status": "正常",
        "result": "优秀",
        "code": "CXTS0592.01",
        "courseType": "校级公选课（全校）",
        "midTerm": "",
        "endTerm": "优秀",
        "usual": "",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "优秀",
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
        "midTerm": "",
        "endTerm": "合格",
        "usual": "",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "合格",
        "point": "3.5"
      },
      {
        "name": "会计学",
        "credit": "2.5",
        "semester": "2019-20202",
        "status": "正常",
        "result": "86",
        "code": "H101730004040.01",
        "courseType": "专业必修",
        "midTerm": "",
        "endTerm": "86",
        "usual": "17",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "86",
        "point": "3.5"
      },
      {
        "name": "统计机器学习",
        "credit": "3",
        "semester": "2019-20202",
        "status": "正常",
        "result": "96",
        "code": "H101750041048.01",
        "courseType": "专业必修",
        "midTerm": "100",
        "endTerm": "90",
        "usual": "100",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "96",
        "point": "4.5"
      },
      {
        "name": "信息系统项目管理",
        "credit": "3.5",
        "semester": "2019-20202",
        "status": "正常",
        "result": "95",
        "code": "H101750028056.01",
        "courseType": "专业必修",
        "midTerm": "99",
        "endTerm": "89",
        "usual": "99",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "95",
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
        "midTerm": "95",
        "endTerm": "82",
        "usual": "99",
        "makeUpScore": null,
        "makeUpScoreResult": null,
        "totalScore": "92",
        "point": "4"
      },
      {
        "name": "数据分析设计",
        "credit": "2",
        "semester": "2019-20202",
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
        "name": "web 系统开发设计",
        "credit": "2",
        "semester": "2019-20202",
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
        "semester": "2019-20202",
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
        "semester": "2019-20202",
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
        "semester": "2019-20202",
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

