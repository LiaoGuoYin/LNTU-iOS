//
//  DetatilExamPlanView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2021/1/8.
//

import SwiftUI

struct DetatilExamPlanView: View {
    
    @State var course: ExamPlanResponseData
    let deviceSize = UIScreen.main.bounds
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("课程")
                Text("序号")
                Text("日期")
                Text("时间")
                Text("教学楼")
                Text("座位号")
                Text("类型")
                Text("状态")
                Text("其他备注")
            }
            .font(.headline)
            Spacer()
            VStack(alignment: .leading, spacing: 16) {
                Text(course.name)
                Text(course.code)
                Text(course.date)
                Text(course.time)
                Text(course.location)
                Text(course.seatNumber)
                Text(course.type)
                Text(course.currentStatus.rawValue)
                Text(course.comment.isEmpty ? "-" : course.comment)
            }
            .padding(.trailing)
        }
        .padding()
        .foregroundColor(.white)
    }
}

struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetatilExamPlanView(course: MockData.examPlanList[2])
    }
}
