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
