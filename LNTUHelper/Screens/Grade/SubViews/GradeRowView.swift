//
//  GradeRowView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import SwiftUI


struct GradeRowView: View {
    @State var course: GradeResponseData
    var body: some View {
        HStack {
            Text(self.course.name)
                .lineLimit(1)
            Spacer()
            Text(self.course.result)
        }
        .padding()
        .foregroundColor(course.status == "正常" ? Color.white: Color(.systemGreen))
        .background(Color("primary"))
        .cornerRadius(8)
        .shadow(radius: 1)
    }
}

struct GradeRowView_Previews: PreviewProvider {
    static var previews: some View {
        return GradeRowView(course: MockData.gradeList.randomElement()!)
    }
}
