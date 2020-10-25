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
            Image(systemName: (weekdayStatusList.a != 0) ? "checkmark.seal.fill" : "xmark.seal")
                .foregroundColor((weekdayStatusList.a != 0) ? .blue : .red)
            Image(systemName: (weekdayStatusList.b != 0) ? "checkmark.seal.fill" : "xmark.seal")
                .foregroundColor((weekdayStatusList.b != 0) ? .blue : .red)
            Image(systemName: (weekdayStatusList.c != 0) ? "checkmark.seal.fill" : "xmark.seal")
                .foregroundColor((weekdayStatusList.c != 0) ? .blue : .red)
            Image(systemName: (weekdayStatusList.d != 0) ? "checkmark.seal.fill" : "xmark.seal")
                .foregroundColor((weekdayStatusList.d != 0) ? .blue : .red)
            Image(systemName: (weekdayStatusList.e != 0) ? "checkmark.seal.fill" : "xmark.seal")
                .foregroundColor((weekdayStatusList.e != 0) ? .blue : .red)
        }
    }
}

//struct ClassroomDetailRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        ClassroomDetailRowView()
//    }
//}
