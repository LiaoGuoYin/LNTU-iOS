//
//  CourseCellView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/26.
//

import Foundation
import SwiftUI

struct CourseCellView: View {
    @Binding var cell: CourseTableCell
    var body: some View {
        VStack(spacing: 10) {
            Text(cell.name)
            Text(cell.teacher)
            Text(cell.room)
        }
        .font(.footnote)
        .padding(10)
        .foregroundColor(.white)
        .frame(width: UIScreen.main.bounds.width / 5 - 1, height: UIScreen.main.bounds.height / 7)
        .background(navyBlue)
        .cornerRadius(7)
        .multilineTextAlignment(.center)
    }
}

struct CourseCellView_Previews: PreviewProvider {
    static var previews: some View {
        CourseCellView(cell: .constant(CourseTableCell()))
    }
}

