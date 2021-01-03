//
//  GradeRowDetailView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import SwiftUI

struct GradeRowDetailView: View {
    
    @Binding var course: GradeResponseData
    @State private var deviceSize = UIScreen.main.bounds
    
    var body: some View {
        VStack(alignment: .leading, spacing: deviceSize.height / 8) {
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
                Text("期中(实验)成绩: \(course.midTerm)")
                Text("期末成绩: \(course.endTerm)")
                Text("平时成绩: \(course.usual)")
                
                if course.isNormal {
                    EmptyView()
                } else {
                    Text("补考成绩: \(course.makeUpScore ?? "")")
                    Text("补考总评: \(course.makeUpScoreResult ?? "")")
                }
                
                Text("总评成绩: \(course.totalScore)")
                Text("最终成绩: \(course.result)")
                    .fontWeight(.black)
                
                Text("单科绩点: \(course.point)")
                    .fontWeight(.black)
            }
        }
        .font(.system(size: 24, weight: .regular, design: .monospaced))
        .padding(.leading, deviceSize.width / 5)
        .foregroundColor(.white)
        .frame(width: deviceSize.width, height: deviceSize.height)
        .background(Color("primary"))
        .cornerRadius(10)
        .edgesIgnoringSafeArea(.all)
    }
}


struct GradeRowDetailView_Previews: PreviewProvider {
    static var previews: some View {
        return GradeRowDetailView(course: .constant(MockData.gradeList[3]))
    }
}
