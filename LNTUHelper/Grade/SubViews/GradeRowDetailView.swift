//
//  GradeRowDetailView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import SwiftUI

struct GradeRowDetailView: View {
    @Binding var course: GradeResponseDataGrade
    var body: some View {
        VStack(alignment: .leading, spacing: 50) {
            VStack(alignment: .leading, spacing: 20) {
                Text(course.name)
                Text(course.courseType)
                Text(course.semester)
                Text(course.code)
            }
            VStack(alignment: .leading, spacing: 20) {
                Text("绩点: \(course.point)")
                Text("期中成绩: \(course.midTerm)")
                Text("期末成绩: \(course.endTerm)")
                Text("期中成绩: \(course.midTerm)")
                Text("平时成绩: \(course.usual)")
                Text("最终成绩: \(course.result)")
            }
        }
        .padding()
        .foregroundColor(.white)
        .font(.system(size: 24, weight: .regular, design: .monospaced))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("primary"))
        .cornerRadius(10)
        .edgesIgnoringSafeArea(.all)
    }
}


struct GradeRowDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let demoData = """
              {
                "name": "信息系统分析与设计信息系统分析与设计信息系统分析与设计信息系统分析与设计",
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
              }
              """.data(using: .utf8)!
        let demoGrade = try! JSONDecoder().decode(GradeResponseDataGrade.self, from: demoData)
        return GradeRowDetailView(course: .constant(demoGrade))
    }
}
