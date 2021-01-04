//
//  LNTUHelperApp.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import SwiftUI

struct LNTUHelperApp: View {
    
    @EnvironmentObject var router: ViewRouter
    @State private var selectedTab = TabBarItemEnum.account
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                CourseTableView(viewModel: router.courseTableViewModel)
                    .tabItem { Image(systemName: selectedTab == .courseTable ? "square.on.square.fill" : "square.on.square") }
                    .tag(TabBarItemEnum.courseTable)
                
                GradeAndQualityActivityView(viewModel: router.gradeViewModel)
                    .tabItem { Image(systemName: selectedTab == .grade ?  "doc.fill" :  "doc") }
                    .tag(TabBarItemEnum.grade)
                
                ClassroomView(viewModel: router.classroomViewModel)
                    .tabItem { Image(systemName: selectedTab == .classroom ?  "square.fill" :  "square") }
                    .tag(TabBarItemEnum.classroom)
                
                NoticeView(viewModel: router.noticeViewModel)
                    .tabItem { Image(systemName: selectedTab == .notice ?  "bubble.middle.bottom.fill" :  "bubble.middle.bottom") }
                    .tag(TabBarItemEnum.notice)
                
                AccountView(viewModel: LoginViewModel())
                    .tabItem { Image(systemName: selectedTab == .account ?  "person.fill" :  "person") }
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
            .animation(.easeInOut(duration: 0.3), value: router.isBlured)
            .blur(radius: router.isBlured ? 40 : 0)
            .disabled(router.isBlured)
            // Disable all interactions with the background view when a new view pops up
            
            if router.isBlured {
                router.topView!
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let router = ViewRouter(isLogin: false, isOffline: true)
        return LNTUHelperApp()
            .environmentObject(router)
    }
}
