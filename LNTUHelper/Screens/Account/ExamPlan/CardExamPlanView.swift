//
//  CardExamPlanView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/12/5.
//

import SwiftUI

struct CardExamPlanView: View {
    
    @State var course: ExamPlanResponseData
    var deviceSize = UIScreen.main.bounds
    @State private var remainDateTime: String = ""
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(course.name)
                    .padding(.bottom)

                HStack {
                    BrandTagView(content: course.date)
                    BrandTagView(content: course.time)
                }
                
                if course.currentStatus == ExamStatus.preparing {
                    Divider()
                    Text(remainDateTime)
                } else {
                    EmptyView()
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            Spacer()
            
            VStack {
                Text(course.seatNumber)
                    .font(.title)
                Divider()
                Text(course.location)
            }
            .padding()
            .frame(width: deviceSize.width / 3.3)
            .background(Color("cellBlock"))
            .cornerRadius(8)
            .examFinished(isShowing: course.currentStatus == .finished)
        }
        .lineLimit(1)
        .font(.system(.headline, design: .rounded))
        .foregroundColor(.white)
        .background(Color(.systemGreen))
        .cornerRadius(3)
        .onReceive(timer) { time in
            self.remainDateTime = countDownRemainTime(from: course.dateTime)
        }
    }
}

struct CardExamPlanView_Previews: PreviewProvider {
    static var previews: some View {
        CardExamPlanView(course: MockData.examPlanList[2])
    }
}

func countDownRemainTime(from dateTime: Date) -> String {
    let startTimeStamp = dateTime.timeIntervalSince1970
    let endTimeStamp = Date().timeIntervalSince1970
    
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .brief
    formatter.allowedUnits = [.day, .hour, .minute, .second]
    return formatter.string(from: startTimeStamp-endTimeStamp) ?? "剩余时间计算错误"
}
