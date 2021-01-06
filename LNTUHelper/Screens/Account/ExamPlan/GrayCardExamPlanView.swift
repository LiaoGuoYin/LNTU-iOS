//
//  CardExamPlanView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/12/5.
//

import SwiftUI

struct GrayCardExamPlanView: View {
    
    @State var course: ExamPlanResponseData
    var deviceSize = UIScreen.main.bounds
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(course.name)
                    .fontWeight(.bold)
                
//                HStack {
//                    BrandTagView(content: course.type)
//                    BrandTagView(content: course.status)
//                    // BrandTag(content: course.date)
//                    // BrandTag(content: course.time)
//                }
            }
            .padding()
            
            Spacer()
            
            VStack(spacing: 12) {
                Text(course.currentStatus.rawValue)
                    .font(.title)
            }
            .padding()
            .frame(width: deviceSize.width / 3.3)
            .background(Color("cellBlock"))
            .cornerRadius(8)
            
        }
        .lineLimit(1)
        .font(.system(.body, design: .rounded))
        .foregroundColor(.white)
        .background(Color(.systemGray))
        .cornerRadius(3)
    }
    
}

struct GrayCardExamPlanView_Previews: PreviewProvider {
    static var previews: some View {
        GrayCardExamPlanView(course: MockData.examPlanList[3])
    }
}
