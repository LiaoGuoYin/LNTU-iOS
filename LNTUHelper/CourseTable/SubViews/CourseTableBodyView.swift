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
                    ForEach(1...5, id: \.self) { row in
                        HStack(spacing: 2) {
                            ForEach(1...7, id: \.self) { column in
                                CourseCellView(cell: $courseTableMatrix.matrix[(row-1)*7+column])
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
        CourseTableBodyView(courseTableMatrix: .constant(CourseTableMatrix(courseTableCellList: [CourseTableCell()])))
    }
}
