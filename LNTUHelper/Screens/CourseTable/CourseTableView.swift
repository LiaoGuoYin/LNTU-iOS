//
//  CourseTableView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/26.
//

import SwiftUI

struct CourseTableView: View {
    
    @ObservedObject var router = ViewRouter.router
    @ObservedObject var viewModel: CourseTableViewModel
    
    
    var body: some View {
        NavigationView {
            CourseTableBodyView(courseTableMatrix: $viewModel.martrix)
                .padding(.horizontal)
                .navigationBarTitle(Text(TabBarItemEnum.courseTable.rawValue), displayMode: .large)
                .navigationBarItems(leading: refreshButton, trailing: selectWeekButton)
        }
        .onAppear(perform: {
            Haptic.shared.tappedHaptic()
            if !Constants.isLogin { router.isShowLoginView = true }
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
    
    var selectWeekButton: some View {
        HStack {
            Button(action: {
                viewModel.currentWeek = viewModel.currentWeek - 1
            }, label: {
                Image(systemName: "chevron.left")
            })
            .disabled(viewModel.currentWeek == 1)
            
            Text("第 \(viewModel.currentWeek) 周")
                .onTapGesture(perform: {
                    Haptic.shared.tappedHaptic()
                    router.showBlurView {
                        WeekSelectorView(title: .constant(""), selectedIndex: $viewModel.currentWeek, numberList: Array(1...22).map { String($0) }, displayMode: .grid(7))
                    }
                })
                .foregroundColor(Color("primary"))
                .frame(width: 68)
            
            Button(action: {
                viewModel.currentWeek = viewModel.currentWeek + 1
            }, label: {
                Image(systemName: "chevron.right")
            })
            .disabled(viewModel.currentWeek == 22)
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
    }
}
