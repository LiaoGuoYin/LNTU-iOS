//
//  LNTUHelperApp.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import SwiftUI

struct LNTUHelperApp: View {
    
    @EnvironmentObject private var router: ViewRouter
    @State private var selected: TabBarItemEnum = TabBarItemEnum.account
    
    var body: some View {
        VStack {
            if router.isLogin {
                TabView(selection: $selected) {
                    CourseTableView(viewModel: router.courseTableViewModel)
                        .tabItem { Image(systemName: selected == .courseTable ? "square.on.square.fill" : "square.on.square") }
                        .tag(TabBarItemEnum.courseTable)
                    
                    GradeView(viewModel: router.gradeViewModel, tappedCourse: MockData.gradeList.first!)
                        .tabItem { Image(systemName: selected == .grade ?  "doc.fill" :  "doc") }
                        .tag(TabBarItemEnum.grade)
                    
                    ClassroomView(viewModel: router.classroomViewModel)
                        .tabItem { Image(systemName: selected == .classroom ?  "square.fill" :  "square") }
                        .tag(TabBarItemEnum.classroom)
                    
                    NoticeView(viewModel: router.noticeViewModel)
                        .tabItem { Image(systemName: selected == .notice ?  "bubble.middle.bottom.fill" :  "bubble.middle.bottom") }
                        .tag(TabBarItemEnum.notice)
                    
                    AccountView(viewModel: router.loginViewModel)
                        .tabItem { Image(systemName: selected == .account ?  "person.fill" :  "person") }
                        .tag(TabBarItemEnum.account)
                }
            }  else {
                LoginView()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(Color("primary"))
        .environmentObject(router)
        .banner(data: $router.banner, isShow: $router.isShowBanner)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        var user = MockData.user
        if let localUsername = UserDefaults.standard.value(forKey: SettingsKey.educationUsername.rawValue) as? String,
           let localPassword =  UserDefaults.standard.value(forKey: SettingsKey.educationPassword.rawValue) as? String {
            user = User(username: localUsername, password: localPassword)
        }
        
        let router = ViewRouter(user: user, isLogin: true, isOffline: true)
        return LNTUHelperApp()
            .environmentObject(router)
    }
}
