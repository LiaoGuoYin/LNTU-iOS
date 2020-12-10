//
//  SettingsView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/12/8.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var router: ViewRouter
    
    var body: some View {
        Form {
            Section(header: Text("实验功能")) {
                Toggle(isOn: $router.isOffline) {
                    LabelView(name: "懒加载模式", iconName: "airplane")
                }
            }
            
            Section(header: Text("关于项目")) {
                if #available(iOS 14.0, *) {
                    Link(destination: URL(string: "https://liaoguoyin.com")!) {
                        LabelView(name: "关注作者", iconName: "number")
                    }
                    
                    Link(destination: URL(string: "https://lntu.liaoguoyin.com/privacy.html")!) {
                        LabelView(name: "用户协议", iconName: "doc.plaintext")
                    }
                    
                    Link(destination: URL(string: "https://github.com/LiaoGuoYin/LNTU-API")!) {
                        LabelView(name: "项目开源地址", iconName: "link")
                    }
                } else {
                    LabelView(name: "TODO for iOS 13", iconName: "link")
                }
            }
            
            Section {
                logoutButton
            }
        }
    }
    var logoutButton: some View {
        Button(action: {
            Haptic.shared.tappedHaptic()
            router.isLogin = false
        }) {
            HStack {
                Spacer()
                Text("退出登录")
                    .foregroundColor(Color(.systemPink))
                Spacer()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(ViewRouter(user: MockData.user))
    }
}
