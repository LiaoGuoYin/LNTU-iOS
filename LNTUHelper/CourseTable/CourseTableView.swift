//
//  CourseTableView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/26.
//

import SwiftUI

struct CourseTableView: View {
    
    @ObservedObject var viewModel: CourseTableViewModel
    @State var teachingWeek: Int = 9
    
    var body: some View {
        NavigationView {
            CourseTableBodyView(courseTableMatrix: $viewModel.martrix)
                .padding(.horizontal)
                .navigationBarTitle(Text("课表"), displayMode: .large)
                .navigationBarItems(trailing: refreshButton)
        }
        .banner(data: $viewModel.banner, isShow: $viewModel.isShowBanner)
    }
    
    var refreshButton: some View {
        Button(action: {
            Haptic.shared.complexSuccess()
            viewModel.refreshCourseTable()
        }) {
            Text("刷新")
        }
    }
}

struct CourseTableView_Previews: PreviewProvider {
    static var previews: some View {
        CourseTableView(viewModel: CourseTableViewModel(user: User(username: "", password: "")))
    }
}
