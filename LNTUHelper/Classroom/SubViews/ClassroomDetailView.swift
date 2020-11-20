//
//  ClassroomDetailView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import SwiftUI

struct ClassroomDetailView: View {
    
    @Binding var classroomList: [ClassroomResponseDataRow]
    @State var selectedWeekday: Int = getCurrentWeekDay()
    var screenWidth: CGFloat =  UIScreen.main.bounds.width
    
    var body: some View {
        VStack {
            Stepper(value: $selectedWeekday, in: 1...7) {
                Text("周 \(selectedWeekday)")
                    .foregroundColor(Color("primary"))
            }
            List {
                HStack {
                    Text("教室名")
                        .bold()
                        .layoutPriority(1)
                        .frame(width: screenWidth / 4)
                    Spacer()
                    Text("类型")
                        .frame(width: screenWidth / 4)
                    Text("容量")
                        .frame(width: screenWidth / 8)
                    Text("状态")
                        .frame(width: screenWidth / 4)
                }
                .foregroundColor(Color(.systemGray))
                .listRowInsets(EdgeInsets())
                ForEach(classroomList, id: \.self) { each in
                    HStack {
                        Text(each.room)
                            .bold()
                            .layoutPriority(1)
                            .frame(width: screenWidth / 4)
                        Spacer()
                        Text(each.type)
                            .frame(width: screenWidth / 4)
                        Text(each.capacity)
                            .frame(width: screenWidth / 8)
                        ClassroomDetailRowView(roomStatusString: .constant(each.scheduleList[selectedWeekday - 1]))
                            .padding(.trailing)
                            .frame(width: screenWidth / 4)
                    }
                    .lineLimit(1)
                }
                .listRowInsets(EdgeInsets())

            }
        }
    }
}

struct ClassroomDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let classroomResponseDemo = try! JSONDecoder().decode(ClassroomResponse.self, from: classroomResponseDemoData).data
        return ClassroomDetailView(classroomList: .constant(classroomResponseDemo.classroomList))
    }
}

let classroomResponseDemoData = """
{
  "code": 200,
  "message": "Success",
  "data": {
    "week": "12",
    "buildingName": "hldjf",
    "classroomList": [
      {
        "room": "葫芦岛一机房",
        "type": "机房",
        "capacity": "40",
        "scheduleList": [
          "0110",
          "01100",
          "00110",
          "00101",
          "01100",
          "00100",
          "00100"
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
      },
      {
        "room": "葫芦岛五机房",
        "type": "机房",
        "capacity": "40",
        "scheduleList": [
          "00000",
          "01000",
          "00000",
          "01000",
          "00110",
          "01100",
          "00000"
        ]
      },
      {
        "room": "葫芦岛三机房",
        "type": "机房",
        "capacity": "40",
        "scheduleList": [
          "00000",
          "01000",
          "00000",
          "01000",
          "00110",
          "01100",
          "00000"
        ]
      },
      {
        "room": "葫芦岛四机房",
        "type": "机房",
        "capacity": "40",
        "scheduleList": [
          "00000",
          "01000",
          "00000",
          "01000",
          "00110",
          "01100",
          "00000"
        ]
      }
    ]
  }
}
""".data(using: .utf8)!
