//
//  ContentView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var router: ViewRouter
    var body: some View {
        if router.isLogin {
            TabView {
                CourseTableView(viewModel: CourseTableViewModel(user: router.user))
                    .tabItem {
                        VStack {
                            Image(systemName: "number.square")
                            Text("课表")
                        }
                    }.tag(0)
                
                ClassroomView(viewModel: ClassroomViewModel(form: ClassroomForm(week: 10, campus: .hld)))
                    .tabItem {
                        VStack {
                            Image(systemName: "square")
                            Text("空教室")
                        }
                    }.tag(1)
                
                Text("通知")
                    .tabItem {
                        VStack {
                            Image(systemName: "square")
                            Text("通知")
                        }
                    }.tag(2)
                
                Text("成绩")
                    .tabItem {
                        VStack {
                            Image(systemName: "square")
                            Text("成绩")
                        }
                    }.tag(3)
                
                UserCenterView()
                    .tabItem {
                        VStack {
                            Image(systemName: "square")
                            Text("账户中心")
                        }
                    }.tag(4)
            }
            .accentColor(Color("navyBlue"))
            .banner(data: $router.banner, isShow: $router.isShowBanner)
            .onAppear(perform: {
                router.banner.content = "\(router.user.username) 登录成功"
            })
        } else {
            LoginView(viewModel: LoginViewModel(user: router.user))
                .accentColor(Color("navyBlue"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewRouter(user: User(username: "1710030215", password: ""), isLogin: true))
    }
}
