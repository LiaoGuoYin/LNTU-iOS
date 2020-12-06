//
//  CourseTableView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/26.
//

import SwiftUI

struct CourseTableView: View {
    
    @ObservedObject var viewModel: CourseTableViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                WeekSelectorView(selectedWeek: $viewModel.currentWeek)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                CourseTableBodyView(courseTableMatrix: $viewModel.martrix)
                    .padding(.horizontal)
                    .navigationBarTitle(Text("第 \(viewModel.currentWeek) 周"), displayMode: .inline)
                    .navigationBarItems(leading: examPlanView, trailing: refreshButton)
            }
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
        .banner(data: $viewModel.banner, isShow: $viewModel.isShowBanner)
    }
    
    var refreshButton: some View {
        Button(action: {
            Haptic.shared.simpleSuccess()
            viewModel.refreshCourseTable()
        }) {
            Text("刷新")
        }
    }
    
    var examPlanView: some View {
        NavigationLink(destination: ExamPlanView(viewModel: ExamPlanViewModel(user: viewModel.user)),
                       label: { LabelView(name: "", iconName: "deskclock", iconColor: Color.green) })
    }
}

struct CourseTableView_Previews: PreviewProvider {
    static var previews: some View {
        CourseTableView(viewModel: CourseTableViewModel(user: MockData.user))
    }
}
