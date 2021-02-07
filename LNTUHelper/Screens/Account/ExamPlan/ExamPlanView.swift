//
//  ExamPlanView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/11/9.
//

import SwiftUI

struct ExamPlanView: View {
    
    @ObservedObject var router = ViewRouter.router
    @ObservedObject var viewModel: ExamPlanViewModel
    
    var body: some View {
        VStack {
            if !viewModel.examPlanList.isEmpty {
                List(viewModel.examPlanList, id: \.name) { course in
                    VStack {
                        if course.currentStatus == ExamStatus.preparing {
                            CardExamPlanView(course: course)
                        } else {
                            GrayCardExamPlanView(course: course)
                        }
                    }
                    .onTapGesture {
                        Haptic.shared.tappedHaptic()
                        router.showBlurView {
                            DetailExamPlanView(course: course, courseStatusColor:
                                               course.currentStatus == ExamStatus.preparing ? Color(.systemGreen) : Color(.systemGray))
                                .onTapGesture {
                                    router.isBlured.toggle()
                                }
                        }
                    }
                }
            } else {
                Text("目前没有考试安排")
                    .foregroundColor(Color.secondary)
            }
        }
        .navigationBarItems(trailing: refreshButton)
        .navigationBarTitle(Text("考试安排"), displayMode: .large)
        .onAppear(perform: {
            self.refresh()
        })
    }
    
    var refreshButton: some View {
        Button(action: {
            Haptic.shared.tappedHaptic()
            self.refresh()
        }) {
            Text("刷新")
        }
    }
    
    func refresh() {
        viewModel.refreshExamPlanList { (isSuccess) in
            router.isShowLoginView = isSuccess ? false : true
            router.banner = viewModel.banner
        }
    }
}

struct ExamPlanView_Previews: PreviewProvider {
    static var previews: some View {
        ExamPlanView(viewModel: ExamPlanViewModel(examPlanList: MockData.examPlanList))
    }
}
