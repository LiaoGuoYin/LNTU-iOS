//
//  ContentView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var router: ViewRouter
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        if router.isLogin {
            TabView {
                CourseTableView(viewModel: CourseTableViewModel(user: viewModel.user))
                    .tabItem {
                        VStack {
                            Image(systemName: "number.square")
                            Text("课表")
                        }
                    }.tag(0)
                
                NoticeView(viewModel: NoticeViewModel())
                    .tabItem {
                        VStack {
                            Image(systemName: "flag")
                            Text("通知")
                        }
                    }.tag(1)
                
                ClassroomView(viewModel: ClassroomViewModel(form: ClassroomForm(week: 10, campus: .hld)))
                    .tabItem {
                        VStack {
                            Image(systemName: "square")
                            Text("空教室")
                        }
                    }.tag(2)
                
                GradeView(viewModel: GradeViewModel(user: viewModel.user))
                    .tabItem {
                        VStack {
                            Image(systemName: "doc.richtext")
                            Text("成绩")
                        }
                    }.tag(3)
                
                UserCenterView(viewModel: viewModel)
                    .tabItem {
                        VStack {
                            Image(systemName: "person.crop.circle")
                            Text("账户中心")
                        }
                    }.tag(4)
            }
            .accentColor(Color("navyBlue"))
            .banner(data: $router.banner, isShow: $router.isShowBanner)
        } else {
            LoginView(viewModel: viewModel)
                .accentColor(Color("navyBlue"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(username: "", password: "")
        ContentView(viewModel: LoginViewModel(user: user))
            .environmentObject(ViewRouter(user: user, isLogin: true))
    }
}
