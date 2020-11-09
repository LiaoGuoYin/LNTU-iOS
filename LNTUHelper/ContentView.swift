//
//  ContentView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var router: ViewRouter
    var body: some View {
        VStack {
            if router.isLogin {
                TabView {
                    CourseTableView(viewModel: router.courseTableViewModel)
                        .tabItem {
                            VStack {
                                Image(systemName: "number.square")
                                Text("课表")
                            }
                        }.tag(0)
                    
                    NoticeView(viewModel: router.noticeViewModel)
                        .tabItem {
                            VStack {
                                Image(systemName: "flag")
                                Text("通知")
                            }
                        }.tag(1)
                    
                    ClassroomView(viewModel: router.classroomViewModel)
                        .tabItem {
                            VStack {
                                Image(systemName: "square")
                                Text("空教室")
                            }
                        }.tag(2)
                    
                    GradeView(viewModel: router.gradeViewModel)
                        .tabItem {
                            VStack {
                                Image(systemName: "doc.richtext")
                                Text("成绩")
                            }
                        }.tag(3)
                    
                    UserCenterView(viewModel: router.loginViewModel)
                        .tabItem {
                            VStack {
                                Image(systemName: "person.crop.circle")
                                Text("账户中心")
                            }
                        }.tag(4)
                }
                .banner(data: $router.banner, isShow: $router.isShowBanner)
                .accentColor(Color("primary"))
            } else {
                LoginView()
                    .accentColor(Color("primary"))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(username: "1710030215", password: "")
        let router = ViewRouter(user: user, isLogin: true)
        ContentView()
            .environmentObject(router)
    }
}
