//
//  ContentView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CourseTableView(viewModel: CourseTableViewModel(user: User(username: 0, password: "*")))
                .tabItem { Text("课表") }.tag(0)
            
            ClassroomView(viewModel: ClassroomViewModel(form: ClassroomForm(week: 10, campus: .hld)))
                .tabItem { Text("空教室") }.tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
