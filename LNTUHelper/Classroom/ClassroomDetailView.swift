//
//  ClassroomDetailView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import SwiftUI

struct ClassroomDetailView: View {
    
    @Binding var classroomList: [ClassroomResponseData]
    @State var selectedWeekday: Int = 1
    
    var body: some View {
        HStack {
            Text("教室")
            Spacer()
            Text("容量")
            Spacer()
            Text("类别")
            Spacer()
            Stepper(value: $selectedWeekday, in: 1...7) {
                Text("周\(selectedWeekday)")
            }
        }
        ForEach(classroomList, id: \.self) { each in
            HStack {
                Text(each.address)
                Spacer()
                Text(each.type)
                Spacer()
                Text(String(each.num))
                Spacer()
                ClassroomDetailRowView(weekdayStatusList: .constant(each.data[selectedWeekday - 1]))
            }
        }
    }
}

//struct ClassroomDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ClassroomDetailView(classroomList: classroomResponseListDemo)
//    }
//}
//
//    .data(using: .utf8)!
//
//let classroomResponseListDemo = try! JSONDecoder().decode(ClassroomResponse.self, from: classroomResponseDemoData).data
