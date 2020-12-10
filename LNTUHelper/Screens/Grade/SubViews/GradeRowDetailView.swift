//
//  GradeRowDetailView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import SwiftUI

struct GradeRowDetailView: View {
    
    @Binding var course: GradeResponseData
    
    var body: some View {
        VStack(alignment: .leading, spacing: UIScreen.main.bounds.height / 8) {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text(course.name)
                    Spacer()
                }
                Text(course.semester)
                Text(course.courseType)
            }
            
            VStack(alignment: .leading, spacing: 20) {
                Text("学分: \(course.credit)")
                Text("期中成绩: \(course.midTerm)")
                Text("期末成绩: \(course.endTerm)")
                Text("期中成绩: \(course.midTerm)")
                Text("平时成绩: \(course.usual)")
                Text("最终成绩: \(course.result)")
                Text("单科绩点: \(course.point)")
            }
        }
        .padding(.leading, UIScreen.main.bounds.width / 8)
        .foregroundColor(.white)
        .font(.system(size: 24, weight: .regular, design: .monospaced))
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color("primary"))
        .cornerRadius(10)
        .edgesIgnoringSafeArea(.all)
    }
}


struct GradeRowDetailView_Previews: PreviewProvider {
    static var previews: some View {
        return GradeRowDetailView(course: .constant(MockData.gradeList.randomElement()!))
    }
}
