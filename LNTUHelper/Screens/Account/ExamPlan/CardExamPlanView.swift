//
//  CardExamPlanView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/12/5.
//

import SwiftUI

struct CardExamPlanView: View {
    
    @State var course: ExamPlanResponseData
    var currentScreenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(course.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom)
           
            HStack {
                Text(course.location)
                Spacer()
                Text(course.seatNumber)
                    .frame(width: currentScreenWidth / 2)
            }
            
            Divider()
            
            HStack {
                Text(course.date)
                Spacer()
                Text(course.time)
                    .frame(width: currentScreenWidth / 2)
            }
            
            Divider()
            
//            HStack {
//                Text(course.type)
//                Spacer()
//                Text(course.status)
//                    .frame(width: currentScreenWidth / 2)
//            }
//
//            Divider()

        }
        .font(.headline)
        .foregroundColor(.white)
        .padding()
        .background(course.location.contains("未安排") ? Color(.systemGray) : Color(.systemGreen))
        .cornerRadius(3)
    }
}

struct CardExamPlanView_Previews: PreviewProvider {
    static var previews: some View {
        CardExamPlanView(course: MockData.examPlanList[2])
    }
}
