//
//  ExamPlanView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/11/9.
//

import SwiftUI

struct ExamPlanView: View {
    
    @ObservedObject var viewModel: ExamPlanViewModel
    
    var body: some View {
        List(viewModel.examPlanList, id: \.name) { course in
            CardExamPlanView(course: course)
        }
        .navigationBarItems(trailing: refreshButton)
        .navigationBarTitle(Text("考试安排"), displayMode: .inline)
        // .banner(data: $viewModel.banner, isShow: $viewModel.isShowBanner)
    }
    
    var refreshButton: some View {
        Button(action: {
            Haptic.shared.simpleSuccess()
            viewModel.refreshExamPlanList()
        }) {
            Text("刷新")
        }
    }
}

struct ExamPlanView_Previews: PreviewProvider {
    static var previews: some View {
        ExamPlanView(viewModel: ExamPlanViewModel(user: MockData.user, examPlanList: MockData.examPlanList))
    }
}
