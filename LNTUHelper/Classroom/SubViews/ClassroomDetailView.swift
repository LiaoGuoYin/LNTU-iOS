//
//  ClassroomDetailView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import SwiftUI

struct ClassroomDetailView: View {
    
    @Binding var classroomList: [ClassroomResponseDataRow]
    @State private var selectedWeekday: Int = getCurrentWeekDay()
    
    var body: some View {
        VStack(spacing: 6) {
            Stepper(value: $selectedWeekday, in: 1...7) {
                Text("周 \(selectedWeekday)")
                    .font(.headline)
                    .foregroundColor(Color("primary"))
            }
            
            ForEach(classroomList, id: \.self) { each in
                HStack {
                    Text(each.room)
                        .bold()
                        .layoutPriority(1)
                    Spacer()
                    Text(each.type)
                    Text(each.capacity)
                        .frame(width: UIScreen.main.bounds.width / 8)
                    ClassroomDetailRowView(roomStatusString: .constant(each.scheduleList[selectedWeekday - 1]))
                }
                .font(.subheadline)
                .lineLimit(1)
            }
        }
    }
}

struct ClassroomDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ClassroomDetailView(classroomList: .constant(classroomResponseDemo.data.classroomList))
    }
}

let classroomResponseDemoData = """
{
  "code": 200,
  "message": "Success",
  "data": {
    "week": "11",
    "buildingName": "hldjf",
    "classRoomList": [
      {
        "room": "葫芦岛一机房",
        "type": "机房",
        "capacity": "40",
        "scheduleList": [
          "01100",
          "00000",
          "00000",
          "00110",
          "00100",
          "00000",
          "00000"
        ]
      },
      {
        "room": "葫芦岛二机房",
        "type": "机房",
        "capacity": "40",
        "scheduleList": [
          "00000",
          "00000",
          "00000",
          "00000",
          "00000",
          "00000",
          "00000"
        ]
      }
    ]
  }
}
"""
    .data(using: .utf8)!

let classroomResponseDemo = try! JSONDecoder().decode(ClassroomResponse.self, from: classroomResponseDemoData)
