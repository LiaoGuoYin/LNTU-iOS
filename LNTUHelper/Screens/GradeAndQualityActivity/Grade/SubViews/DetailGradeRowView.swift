//
//  DetailGradeRowView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2021/1/8.
//

import SwiftUI

// MARK: - TODO: Refactoring to combine this view with DetailExamPlanView.
struct DetailGradeRowView: View {
    
    @State var course: GradeResponseData
    let deviceSize = UIScreen.main.bounds
    let propertyList = ["课程名", "序号", "类型", "学期", "学分", "期中(实验)成绩", "期末成绩", "平时成绩", "补考成绩", "补考总评", "总评成绩", "最终成绩"]
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(propertyList, id: \.self) {
                    Text($0)
                }
            }
            .font(.headline)
            Spacer()
            VStack(alignment: .center, spacing: 16) {
                Group {
                    Text(course.name)
                    Text(course.code)
                    Text(course.courseType)
                    Text(course.semester)
                }
                Group {
                    Text(course.credit)
                    Text(course.midTerm)
                    Text(course.endTerm)
                    Text(course.usual)
                    Text(course.makeUpScore ?? "")
                    Text(course.makeUpScoreResult ?? "")
                    Text(course.totalScore)
                    Text(course.result)
                        .fontWeight(.black)
                    // 单科绩点可能不准
                    // Text(course.point)
                    // .fontWeight(.black)
                }
            }
            .padding(.trailing)
        }
        .padding()
        .foregroundColor(.white)
        .background(Color("primary"))
        .cornerRadius(8)
        .padding()
    }
}

struct DetailGradeRowView_Previews: PreviewProvider {
    static var previews: some View {
        DetailGradeRowView(course: MockData.gradeList[2])
    }
}
