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
                HStack(spacing: 2) {
                    Text("第 \(viewModel.currentWeek) 周")
                        .font(.caption)
                        .frame(width: 50)
                        .padding()
                    WeekSelectorView(selectedWeek: $viewModel.currentWeek)
                        .padding(.vertical, 8)
                }
                CourseTableBodyView(courseTableMatrix: $viewModel.martrix)
                    .padding(.horizontal)
                    .navigationBarTitle(Text("课表"), displayMode: .large)
                    .navigationBarItems(trailing: refreshButton)
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
}

struct CourseTableView_Previews: PreviewProvider {
    static var previews: some View {
        return CourseTableView(viewModel: CourseTableViewModel(user: User(username: "1710030215", password: "")))
    }
}