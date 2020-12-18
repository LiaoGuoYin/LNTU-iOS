//
//  CourseTableView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/26.
//

import SwiftUI

struct CourseTableView: View {
    
    @EnvironmentObject var router: ViewRouter
    @ObservedObject var viewModel: CourseTableViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                WeekSelectorView(title: .constant(""), selectedWeek: $viewModel.currentWeek)
                Divider()
                CourseTableBodyView(courseTableMatrix: $viewModel.martrix)
            }
            .padding(.horizontal)
            .navigationBarTitle(Text(TabBarItemEnum.courseTable.rawValue), displayMode: .large)
            .navigationBarItems(trailing: refreshButton)
        }
        .onAppear { Haptic.shared.tappedHaptic() }
    }
    
    var refreshButton: some View {
        Button(action: {
            Haptic.shared.tappedHaptic()
            viewModel.refreshCourseTable {
                router.isShowingLoginView = true
            }
            router.banner = viewModel.banner
        }) {
            Text("刷新")
        }
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
            .environmentObject(ViewRouter(user: MockData.user))
    }
}
