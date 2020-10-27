//
//  ClassroomDetailRowView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import SwiftUI

struct ClassroomDetailRowView: View {
    @Binding var weekdayStatusList: ClassroomResponseData.ClassroomDetail
    var body: some View {
        HStack {
            Image(systemName: (weekdayStatusList.a == 0) ? "square" : "square.fill")
                .foregroundColor((weekdayStatusList.a == 0) ? navyBlue : .pink)
            
            Image(systemName: (weekdayStatusList.b == 0) ? "square" : "square.fill")
                .foregroundColor((weekdayStatusList.b == 0) ? navyBlue : .pink)
            
            Image(systemName: (weekdayStatusList.c == 0) ? "square" : "square.fill")
                .foregroundColor((weekdayStatusList.c == 0) ? navyBlue : .pink)
            
            Image(systemName: (weekdayStatusList.d == 0) ? "square" : "square.fill")
                .foregroundColor((weekdayStatusList.d == 0) ? navyBlue : .pink)
            
            Image(systemName: (weekdayStatusList.e == 0) ? "square" : "square.fill")
                .foregroundColor((weekdayStatusList.e == 0) ? navyBlue : .pink)
        }
    }
}

struct ClassroomDetailRowView_Previews: PreviewProvider {
    static var previews: some View {
        ClassroomDetailRowView(weekdayStatusList: .constant(ClassroomResponseData.ClassroomDetail(a: 1, b: 1, c: 0, d: 0, e: 1)))
    }
}
