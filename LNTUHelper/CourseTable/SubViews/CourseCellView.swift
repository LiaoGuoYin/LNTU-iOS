//
//  CourseCellView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/26.
//

import Foundation
import SwiftUI

struct CourseCellView: View {
    @Binding var cell: CourseTableMatrixCell
    var body: some View {
        VStack(spacing: 3) {
            Text(cell.name)
            Text(cell.teacher)
            Text(cell.weeksString)
            Text(cell.room)
                .padding(.horizontal, 2)
        }
        .font(.caption)
        .padding(.horizontal, 2)
        .foregroundColor(.white)
        .frame(width: UIScreen.main.bounds.width / 6, height: UIScreen.main.bounds.height / 7)
        .background(Color("primary"))
        .cornerRadius(6)
        .multilineTextAlignment(.center)
    }
}

struct CourseCellView_Previews: PreviewProvider {
    static var previews: some View {
        let courseTableDemo = try! JSONDecoder().decode(CourseTableResponse.self, from: courseTableDemoData)
        let courseTableMatrix = flatToMatrix(courseList: courseTableDemo.data!, currentWeek: 10)
        CourseCellView(cell: .constant(courseTableMatrix[1,1][1]))
    }
}

