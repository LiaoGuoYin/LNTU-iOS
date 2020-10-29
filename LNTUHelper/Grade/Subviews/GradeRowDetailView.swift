//
//  GradeRowDetailView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import SwiftUI

struct GradeRowDetailView: View {
    @State var course: GradeResponseDataGrade
    var body: some View {
        VStack(spacing: 50) {
            Text(course.code)
            Text(course.semester)
            Text(course.name)
            Text(course.courseType)
            Text(course.credit)
            HStack {
                Text(course.usual)
                Text(course.midTerm)
                Text(course.endTerm)
                Text(course.result)
            }
            .padding()
        }
        .foregroundColor(.white)
        .font(.system(size: 24, weight: .regular, design: .monospaced))
        .frame(width: 1024, height: 1800)
        .background(Color(.systemPink))
        .padding()
        .cornerRadius(10)
    }
}


struct GradeRowDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let demoData = """
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
              }
              """.data(using: .utf8)!
        let demoGrade = try! JSONDecoder().decode(GradeResponseDataGrade.self, from: demoData)
        return GradeRowDetailView(course: demoGrade)
    }
}
