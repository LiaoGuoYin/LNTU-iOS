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
            Text(course.name)
                .padding(.horizontal)
            Spacer()
            Text(course.currentStatus.rawValue)
                .font(.title)
                .padding()
                .frame(width: deviceSize.width / 3)
                .background(Color("cellBlock"))
        }
        .lineLimit(1)
        .font(.system(.body, design: .rounded))
        .foregroundColor(.white)
        .background(Color(.systemGray))
        .cornerRadius(3)
        .examFinished(isShowing: course.currentStatus == .finished)
    }
}

struct GrayCardExamPlanView_Previews: PreviewProvider {
    
    static let devices = ["iPhone 12", "iPhone SE", "iPhone 12 Pro Max"]
    
    static var previews: some View {
        GrayCardExamPlanView(course: MockData.examPlanList[3])
            .multiDevicePreview(deviceNames: devices)
    }
}
