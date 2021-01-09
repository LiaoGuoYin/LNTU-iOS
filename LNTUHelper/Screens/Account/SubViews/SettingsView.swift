//
//  SettingsView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/12/8.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var router = ViewRouter.router
    @State private var isShowingSheet = false
    @State private var tappedUrlString = "" {
        didSet {
            isShowingSheet = true
        }
    }
    
    var body: some View {
        Form {
            Section(header: Text("实验功能")) {
                Toggle(isOn: $router.isOffline) {
                    LabelView(name: "懒加载模式", iconName: "airplane")
                }
            }
            
            Section(header: Text("关于项目")) {
                if #available(iOS 14.0, *) {
                    ForEach(SettingData.AboutItemList, id: \.urlString) { each in
                        Link(destination: URL(string: each.urlString)!) {
                            LabelView(name: each.name, iconName: each.iconName)
                        }
                    }
                } else {
                    ForEach(SettingData.AboutItemList, id: \.urlString) { each in
                        LabelView(name: each.name, iconName: each.iconName)
                            .onTapGesture {
                                self.tappedUrlString = each.urlString
                            }
                    }
                }
            }
            .foregroundColor(Color("primary"))
            
            Section {
                logoutButton
            }
        }
        .navigationBarTitle(Text("更多"), displayMode: .inline)
        .sheet(isPresented: $isShowingSheet) {
            SafariView(urlString: tappedUrlString)
        }
    }
    var logoutButton: some View {
        Button(action: {
            Haptic.shared.tappedHaptic()
            if let notificationToken = Constants.notificationToken {
                APIClient.notificationToken(type: .remove, username: Constants.currentUser.username, token: notificationToken) { (result) in
                    switch result {
                    case.failure(let error):
                        print("Nofication Registration To Server Error: " + error.localizedDescription)
                    case .success(let response):
                        if response.code != 200 {
                            print("Notification Remove From Server Responded with Code " + String(response.code) + ":" + response.message)
                        } else {
                            print("The Notification token was successfully removed from the server")
                        }
                    }
                }
            }
            Constants.currentUser.password = ""
            Constants.isLogin = false
            router.banner.type = .Warning
            router.banner.title = "退出登录成功，已清除用户密码"
            router.banner.content = "Success"
        }) {
            HStack {
                Spacer()
                Text("退出登录")
                Spacer()
            }
            .foregroundColor(Color(.systemPink))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
