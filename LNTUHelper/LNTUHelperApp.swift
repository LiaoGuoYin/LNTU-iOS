//
//  LNTUHelperApp.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import SwiftUI

struct LNTUHelperApp: View {
    
    @ObservedObject var router = ViewRouter.router
    
    var body: some View {
        ZStack {
            TabView(selection: $router.selectedTab) {
                CourseTableView(viewModel: router.courseTableViewModel)
                    .tabItem { Image(systemName: router.selectedTab == .courseTable ? "square.on.square.fill" : "square.on.square") }
                    .tag(TabBarItemEnum.courseTable)
                
                GradeAndQualityActivityView(viewModel: router.gradeViewModel)
                    .tabItem { Image(systemName: router.selectedTab == .grade ?  "doc.fill" :  "doc") }
                    .tag(TabBarItemEnum.grade)
                
                ClassroomView(viewModel: router.classroomViewModel)
                    .tabItem { Image(systemName: router.selectedTab == .classroom ?  "square.fill" :  "square") }
                    .tag(TabBarItemEnum.classroom)
                
                NoticeView(viewModel: router.noticeViewModel)
                    .tabItem { Image(systemName: router.selectedTab == .notice ?  "bubble.middle.bottom.fill" :  "bubble.middle.bottom") }
                    .tag(TabBarItemEnum.notice)
                
                AccountView(viewModel: LoginViewModel())
                    .tabItem { Image(systemName: router.selectedTab == .account ?  "person.fill" :  "person") }
                    .tag(TabBarItemEnum.account)
            }
            .sheet(isPresented: $router.isShowLoginView, content: {
                LoginView(viewModel: router.loginViewModel)
            })
            .navigationViewStyle(StackNavigationViewStyle())
            .accentColor(Color("primary"))
            .banner(data: $router.banner, isShow: $router.isShowBanner)
            .blur(radius: router.isBlured ? 40 : 0)
            .animation(.easeInOut(duration: 0.3), value: router.isBlured)
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
        return LNTUHelperApp()
    }
}
