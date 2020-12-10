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
        VStack {
            WeekSelectorView(title: .constant(""), selectedWeek: $viewModel.currentWeek)
            CourseTableBodyView(courseTableMatrix: $viewModel.martrix)
                .padding(.top)
        }
        .padding(.horizontal)
        .navigationBarItems(leading: examPlanView, trailing: refreshButton)
        .accentColor(Color("primary"))
        .onAppear(perform: {
            Haptic.shared.tappedHaptic()
        })
        // .navigationBarTitle(Text(viewModel.selectedWeekString), displayMode: .inline) TODO
        // .banner(data: $viewModel.banner, isShow: $viewModel.isShowBanner)
    }
    
    var refreshButton: some View {
        Button(action: {
            Haptic.shared.tappedHaptic()
            viewModel.refreshCourseTable()
        }) {
            Text("刷新")
        }
    }
    
    var examPlanView: some View {
        NavigationLink(
            destination: ExamPlanView(viewModel: ExamPlanViewModel(user: viewModel.user)),
            label: {
                Text("考试")
                Image(systemName: "number.square")
            })
    }
    
    var selectingSegmentButton: some View {
        HStack {
            Picker("教学周", selection: $viewModel.currentWeek) {
                Text("本周").tag(viewModel.currentWeek)
                Text("全部").tag(0)
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}

struct CourseTableView_Previews: PreviewProvider {
    static var previews: some View {
        CourseTableView(viewModel: CourseTableViewModel(user: MockData.user))
    }
}
