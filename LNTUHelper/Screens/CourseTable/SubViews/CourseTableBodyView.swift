//
//  CourseTableBodyView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/26.
//

import SwiftUI

struct CourseTableBodyView: View {
    
    @Binding var courseTableMatrix: CourseTableMatrix
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 2) {
                    ForEach(1...5, id: \.self) { y in
                        HStack(spacing: 2) {
                            ForEach(1...7, id: \.self) { x in
                                CourseCellView(cell: $courseTableMatrix[x, y][0])
                            }
                        }
                    }
                }
            }
        }
    }
}

struct CourseTableBodyView_Previews: PreviewProvider {
    static var previews: some View {
        let courseTableMatrix = flatToMatrix(courseList: MockData.courseTableList, currentWeek: 10)
        CourseTableBodyView(courseTableMatrix: .constant(courseTableMatrix))
    }
}
