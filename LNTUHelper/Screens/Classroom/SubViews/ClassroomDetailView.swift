//
//  ClassroomDetailView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import SwiftUI

struct ClassroomDetailView: View {
    
    @Binding var classroomList: [ClassroomResponseDataRow]
    @Binding var selectedWeekday: Int
    var screenWidth: CGFloat =  UIScreen.main.bounds.width
    
    var body: some View {
        HStack {
            Text("教室名")
                .layoutPriority(1)
                .frame(width: screenWidth / 4)
            Spacer()
            Text("类型")
                .frame(width: screenWidth / 4)
            Text("容量")
                .frame(width: screenWidth / 8)
            Text("状态")
                .frame(width: screenWidth / 4)
                .padding(.trailing)
        }
        
        ForEach(classroomList, id: \.self) { each in
            HStack {
                Text(each.room)
                    .bold()
                    .layoutPriority(1)
                    .frame(width: screenWidth / 4)
                    .truncationMode(.head)
                    .foregroundColor(Color.primary)
                
                Spacer()
                Text(each.type)
                    .frame(width: screenWidth / 4)
                Text(each.capacity)
                    .frame(width: screenWidth / 8)
                ClassroomDetailRowView(roomStatusString: .constant(each.scheduleList[selectedWeekday - 1]))
                    .padding(.trailing)
                    .frame(width: screenWidth / 4)
                    .layoutPriority(2)
            }
            .lineLimit(1)
        }
    }
}

struct ClassroomDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ClassroomDetailView(classroomList: .constant(MockData.classroomResponseData.classroomList), selectedWeekday: .constant(1))
    }
}
