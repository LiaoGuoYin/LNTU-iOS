//
//  LNTUHelperApp.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import SwiftUI

struct LNTUHelperApp: View {
    
    @EnvironmentObject private var router: ViewRouter
    @State private var selected = 0
    
    var body: some View {
        if router.isLogin {
            TabView(selection: $selected) {
                CourseTableView(viewModel: router.courseTableViewModel)
                    .tabItem {
                        Image(systemName: selected == 0 ? "number.square.fill" : "number.square")
                    }.tag(0)
                
                NoticeView(viewModel: router.noticeViewModel)
                    .tabItem {
                        Image(systemName: selected == 1 ?  "flag.fill" :  "flag")
                    }.tag(1)
                
                ClassroomView(viewModel: router.classroomViewModel)
                    .tabItem {
                        Image(systemName: selected == 2 ?  "square.fill" :  "square")
                    }.tag(2)
                
                GradeView(viewModel: router.gradeViewModel)
                    .tabItem {
                        Image(systemName: selected == 3 ?  "doc.richtext.fill" :  "doc.richtext")
                    }.tag(3)
                
                UserCenterView(viewModel: router.loginViewModel)
                    .tabItem {
                        Image(systemName: selected == 4 ?  "person.crop.circle.fill" :  "person.crop.circle")
                    }.tag(4)
            }
            .accentColor(Color("primary"))
            .banner(data: $router.banner, isShow: $router.isShowBanner)
            .environmentObject(router)
        } else {
            LoginView()
                .accentColor(Color("primary"))
                .banner(data: $router.banner, isShow: $router.isShowBanner)
                .environmentObject(router)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let router = ViewRouter(user: MockData.user, isLogin: true)
        LNTUHelperApp()
            .environmentObject(router)
    }
}
