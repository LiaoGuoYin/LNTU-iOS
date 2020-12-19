//
//  LNTUHelperApp.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import SwiftUI

struct LNTUHelperApp: View {
    
    @EnvironmentObject var router: ViewRouter
    @State private var selected = TabBarItemEnum.account
    
    var body: some View {
        TabView(selection: $selected) {
            CourseTableView(viewModel: router.courseTableViewModel)
                .tabItem { Image(systemName: selected == .courseTable ? "square.on.square.fill" : "square.on.square") }
                .tag(TabBarItemEnum.courseTable)
            
            GradeAndQualityActivityView(viewModel: router.gradeViewModel)
                .tabItem { Image(systemName: selected == .grade ?  "doc.fill" :  "doc") }
                .tag(TabBarItemEnum.grade)
            
            ClassroomView(viewModel: router.classroomViewModel)
                .tabItem { Image(systemName: selected == .classroom ?  "square.fill" :  "square") }
                .tag(TabBarItemEnum.classroom)
            
            NoticeView(viewModel: router.noticeViewModel)
                .tabItem { Image(systemName: selected == .notice ?  "bubble.middle.bottom.fill" :  "bubble.middle.bottom") }
                .tag(TabBarItemEnum.notice)
            
            AccountView(viewModel: LoginViewModel())
                .tabItem { Image(systemName: selected == .account ?  "person.fill" :  "person") }
                .tag(TabBarItemEnum.account)
        }
        .sheet(isPresented: $router.isShowLoginView, content: {
            LoginView(viewModel: router.loginViewModel)
                .environmentObject(router)
        })
        .environmentObject(router)
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(Color("primary"))
        .banner(data: $router.banner, isShow: $router.isShowBanner)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let router = ViewRouter(isLogin: false, isOffline: true)
        return LNTUHelperApp()
            .environmentObject(router)
    }
}
