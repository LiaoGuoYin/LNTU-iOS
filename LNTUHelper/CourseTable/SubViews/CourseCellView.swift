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
        VStack(spacing: 3) {
            Text(cell.name)
            Text(cell.teacher)
            Text(cell.weeksString)
                .padding(.top, 3)
            Text(cell.room)
        }
        .font(.caption)
        .padding(8)
        .foregroundColor(.white)
        .frame(width: UIScreen.main.bounds.width / 6, height: UIScreen.main.bounds.height / 6)
        .background(Color("primary"))
        .cornerRadius(6)
        .multilineTextAlignment(.center)
    }
}

struct CourseCellView_Previews: PreviewProvider {
    static var previews: some View {
        CourseCellView(cell: .constant(CourseTableCell()))
    }
}

