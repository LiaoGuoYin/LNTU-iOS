//
//  GradeRowView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import SwiftUI


struct GradeRowView: View {
    @State var course: GradeResponseDataGrade
    var body: some View {
        HStack {
            Image(systemName: "checkmark.seal.fill")
                .foregroundColor(Color.green)
            Text(self.course.name)
                .lineLimit(1)
            Spacer()
            Text(self.course.result)
            Image(systemName: "chevron.right.circle.fill")
                .font(.subheadline)
        }
        .padding()
        .foregroundColor(Color(.systemPink))
        .font(.headline)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 1, y: 1)
    }
}

struct GradeRowView_Previews: PreviewProvider {
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
        return GradeRowView(course: demoGrade)
    }
}
