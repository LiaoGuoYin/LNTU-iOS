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
        List(viewModel.examPlanList, id: \.name) { course in
            CardExamPlanView(course: course)
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
