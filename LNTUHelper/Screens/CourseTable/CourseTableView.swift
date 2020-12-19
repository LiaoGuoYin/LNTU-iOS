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
            .navigationBarItems(leading: refreshButton)
        }
        .onAppear {
            Haptic.shared.tappedHaptic()
            if !Constants.isLogin { router.isShowLoginView = true }
        }
    }
    
    var refreshButton: some View {
        Button(action: {
            Haptic.shared.tappedHaptic()
            self.refresh()
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
    
    func refresh() {
        viewModel.refreshCourseTable { (isSuccess) in
            router.isShowLoginView = isSuccess ? false : true
            router.banner = viewModel.banner
        }
    }
}

struct CourseTableView_Previews: PreviewProvider {
    static var previews: some View {
        CourseTableView(viewModel: CourseTableViewModel())
            .environmentObject(ViewRouter())
    }
}
