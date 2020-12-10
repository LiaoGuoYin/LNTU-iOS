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
        .foregroundColor(.white)
        .padding(.horizontal, 2)
        .multilineTextAlignment(.center)
        .frame(width: UIScreen.main.bounds.width / 6, height: UIScreen.main.bounds.height / 7)
        .background(cell.name == "" ? Color("cellBlock") : Color("primary"))
        .cornerRadius(6)
    }
}

struct CourseCellView_Previews: PreviewProvider {
    static var previews: some View {
        let courseTableMatrix = flatToMatrix(courseList: MockData.courseTableList, currentWeek: 10)
        CourseCellView(cell: .constant(courseTableMatrix[2, 2][1]))
    }
}

