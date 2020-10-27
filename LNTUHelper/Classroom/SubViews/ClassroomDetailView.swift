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
        VStack {
            HStack {
                Text("教室")
                Spacer()
                Text("容量")
                Text("类别")
                Stepper(value: $selectedWeekday, in: 1...7) {
                    Text("周\(selectedWeekday)")
                        .foregroundColor(navyBlue)
                }
            }
            ForEach(classroomList, id: \.self) { each in
                HStack {
                    Text(each.address)
                    Spacer()
                    Text(each.type)
                    Text(String(each.num))
                        .frame(width: UIScreen.main.bounds.width / 8)
                    ClassroomDetailRowView(weekdayStatusList: .constant(each.data[selectedWeekday - 1]))
                }
            }
        }
    }
}

struct ClassroomDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ClassroomDetailView(classroomList: .constant(classroomResponseListDemo))
    }
}
let classroomResponseDemoData = """
{
  "code": 200,
  "message": "success",
  "data": [
    {
      "address": "葫芦岛一测试机房",
      "num": 40,
      "type": "机房",
      "data": [
        {
          "a": 0,
          "b": 0,
          "c": 0,
          "d": 0,
          "e": 0
        },
        {
          "a": 0,
          "b": 0,
          "c": 0,
          "d": 0,
          "e": 0
        },
        {
          "a": 0,
          "b": 0,
          "c": 0,
          "d": 0,
          "e": 0
        },
        {
          "a": 0,
          "b": 0,
          "c": 0,
          "d": 0,
          "e": 0
        },
        {
          "a": 0,
          "b": 0,
          "c": 0,
          "d": 0,
          "e": 0
        },
        {
          "a": 0,
          "b": 0,
          "c": 0,
          "d": 0,
          "e": 0
        },
        {
          "a": 0,
          "b": 0,
          "c": 0,
          "d": 0,
          "e": 0
        }
      ]
    },
    {
      "address": "葫芦岛二机房",
      "num": 40,
      "type": "机房",
      "data": [
        {
          "a": 0,
          "b": 0,
          "c": 0,
          "d": 0,
          "e": 0
        },
        {
          "a": 0,
          "b": 0,
          "c": 0,
          "d": 0,
          "e": 0
        },
        {
          "a": 0,
          "b": 0,
          "c": 0,
          "d": 0,
          "e": 0
        },
        {
          "a": 0,
          "b": 0,
          "c": 0,
          "d": 0,
          "e": 0
        },
        {
          "a": 0,
          "b": 0,
          "c": 0,
          "d": 0,
          "e": 0
        },
        {
          "a": 0,
          "b": 0,
          "c": 0,
          "d": 0,
          "e": 0
        },
        {
          "a": 0,
          "b": 0,
          "c": 0,
          "d": 0,
          "e": 0
        }
      ]
    }
  ]
}
"""
.data(using: .utf8)!

let classroomResponseListDemo = try! JSONDecoder().decode(ClassroomResponse.self, from: classroomResponseDemoData).data
