//
//  ContentView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var router: ViewRouter
    @State private var selected = 0
    
    var body: some View {
        if router.isLogin {
            TabView(selection: $selected) {
                CourseTableView(viewModel: router.courseTableViewModel)
                    .tabItem {
                        VStack {
                            Image(systemName: selected == 0 ? "number.square.fill" : "number.square")
                            Text("课表")
                        }
                    }.tag(0)
                
                NoticeView(viewModel: router.noticeViewModel)
                    .tabItem {
                        VStack {
                            Image(systemName: selected == 1 ?  "flag.fill" :  "flag")
                            Text("通知")
                        }
                    }.tag(1)
                
                ClassroomView(viewModel: router.classroomViewModel)
                    .tabItem {
                        VStack {
                            Image(systemName: selected == 2 ?  "square.fill" :  "square")
                            Text("空教室")
                        }
                    }.tag(2)
                
                GradeView(viewModel: router.gradeViewModel)
                    .tabItem {
                        VStack {
                            Image(systemName: selected == 3 ?  "doc.richtext.fill" :  "doc.richtext")
                            Text("成绩")
                        }
                    }.tag(3)
                
                UserCenterView(viewModel: router.loginViewModel)
                    .environmentObject(router)
                    .tabItem {
                        VStack {
                            Image(systemName: selected == 4 ?  "person.crop.circle.fill" :  "person.crop.circle")
                            Text("账户中心")
                        }
                    }.tag(4)
            }
            .accentColor(Color("primary"))
            .banner(data: $router.banner, isShow: $router.isShowBanner)
        } else {
            LoginView()
                .accentColor(Color("primary"))
                .environmentObject(router)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let user = MockData.user
        let router = ViewRouter(user: user, isLogin: true)
        ContentView()
            .environmentObject(router)
    }
}
