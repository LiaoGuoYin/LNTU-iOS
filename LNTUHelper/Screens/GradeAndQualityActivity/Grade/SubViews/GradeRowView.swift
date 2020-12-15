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
                .fontWeight(course.isNormal ? .none : .black)
                .lineLimit(1)
            Spacer()
            Text(self.course.result)
                .fontWeight(course.isNormal ? .none : .black)
        }
        .padding()
        .foregroundColor(course.isNormal ? Color.white: Color(.systemTeal))
        .background(Color("primary"))
        .cornerRadius(8)
        .shadow(radius: 1)
    }
}

struct GradeRowView_Previews: PreviewProvider {
    static var previews: some View {
        GradeRowView(course: MockData.gradeList.randomElement()!)
    }
}
